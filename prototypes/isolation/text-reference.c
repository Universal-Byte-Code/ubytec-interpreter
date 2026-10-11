/* Independent oracle for the stateful text packet used by the isolation prototype. */
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum {
    HEADER_SIZE = 64,
    STATE_HEADER_SIZE = 32,
    PACKET_OVERHEAD = 112,
    MAX_BYTES = 65536,
    MAX_FIELDS = 256
};

static uint64_t load_u64(const unsigned char *p)
{
    uint64_t value;
    memcpy(&value, p, sizeof(value));
    return value;
}

static void store_u64(unsigned char *p, uint64_t value)
{
    memcpy(p, &value, sizeof(value));
}

static void store_i64(unsigned char *p, int64_t value)
{
    memcpy(p, &value, sizeof(value));
}

static int is_space(unsigned char c)
{
    return c == 32 || (c >= 9 && c <= 13);
}

static unsigned char upper(unsigned char c)
{
    return c >= 'a' && c <= 'z' ? (unsigned char)(c - ('a' - 'A')) : c;
}

static int scan_fields(
    unsigned char *state,
    const unsigned char *source,
    uint64_t length,
    uint64_t capacity,
    int writing)
{
    uint64_t cursor = 0;
    uint64_t count = 0;

    while (cursor < length) {
        uint64_t first = cursor;
        while (cursor < length && source[cursor] != ',')
            cursor++;
        uint64_t last = cursor;
        cursor++;

        while (first < last && is_space(source[first]))
            first++;
        while (first < last && is_space(source[last - 1]))
            last--;

        if (first < last) {
            if (count >= capacity)
                return -11;
            if (writing) {
                store_u64(state + 32 + count * 16, first);
                store_u64(state + 40 + count * 16, last - first);
            }
            count++;
        }
    }

    if (writing)
        store_u64(state, count);
    return (int)count;
}

static int64_t run_text(
    unsigned char *workspace,
    const unsigned char *source,
    uint64_t length,
    uint64_t fields,
    uint64_t output_capacity,
    int corrupt)
{
    int count = scan_fields(workspace, source, length, fields, 0);
    if (count < 0)
        return count;

    count = scan_fields(workspace, source, length, fields, 1);
    if (count < 0)
        return count;

    unsigned char *work = workspace + STATE_HEADER_SIZE + fields * 16;
    for (uint64_t i = 0; i < length; i++)
        work[i] = upper(source[i]);

    if (corrupt) {
        if (count == 0)
            return -13;
        store_u64(workspace + 32, length + 1);
    }

    uint64_t stored_count = load_u64(workspace);
    uint64_t stored_capacity = load_u64(workspace + 8);
    uint64_t stored_length = load_u64(workspace + 16);
    uint64_t stored_bytes = load_u64(workspace + 24);
    uint64_t workspace_length = STATE_HEADER_SIZE + fields * 16 + stored_bytes;

    if (workspace_length < STATE_HEADER_SIZE ||
        stored_capacity > MAX_FIELDS ||
        stored_count > stored_capacity ||
        stored_bytes > MAX_BYTES ||
        stored_length > stored_bytes)
        return -13;

    uint64_t table_bytes = STATE_HEADER_SIZE + stored_capacity * 16;
    if (table_bytes > workspace_length || stored_bytes > workspace_length - table_bytes)
        return -13;

    if (output_capacity == 0 || output_capacity > MAX_BYTES)
        return -12;

    uint64_t needed = stored_count == 0 ? 0 : stored_count - 1;
    for (uint64_t i = 0; i < stored_count; i++) {
        uint64_t offset = load_u64(workspace + 32 + i * 16);
        uint64_t size = load_u64(workspace + 40 + i * 16);
        if (offset > stored_length || size > stored_length - offset)
            return -13;
        needed += size;
    }

    if (needed >= output_capacity)
        return -12;

    unsigned char *text = workspace + table_bytes;
    unsigned char *output = workspace + workspace_length;
    uint64_t position = 0;
    for (uint64_t i = 0; i < stored_count; i++) {
        if (i != 0)
            output[position++] = '|';
        uint64_t offset = load_u64(workspace + 32 + i * 16);
        uint64_t size = load_u64(workspace + 40 + i * 16);
        memcpy(output + position, text + offset, (size_t)size);
        position += size;
    }
    output[position] = 0;
    return (int64_t)needed;
}

static int64_t execute_packet(unsigned char *data, size_t size, int corrupt)
{
    if (size < HEADER_SIZE)
        return -10;

    int64_t result = -10;
    if (size >= PACKET_OVERHEAD) {
        uint64_t length = load_u64(data);
        uint64_t capacity = load_u64(data + 8);
        uint64_t fields = load_u64(data + 16);
        uint64_t output_capacity = load_u64(data + 24);

        if (capacity <= MAX_BYTES &&
            length <= capacity &&
            fields <= MAX_FIELDS &&
            output_capacity <= MAX_BYTES) {
            uint64_t expected = PACKET_OVERHEAD + 2 * capacity + 16 * fields + output_capacity;
            uint64_t state_offset = HEADER_SIZE + capacity;
            if (expected == size &&
                state_offset + STATE_HEADER_SIZE <= size &&
                load_u64(data + state_offset + 8) == fields &&
                load_u64(data + state_offset + 16) == length &&
                load_u64(data + state_offset + 24) == capacity) {
                result = run_text(
                    data + state_offset,
                    data + HEADER_SIZE,
                    length,
                    fields,
                    output_capacity,
                    corrupt);
            }
        }
    }

    store_i64(data + 48, result);
    if (result < 0) {
        store_i64(data + 56, result);
    } else {
        uint64_t capacity = load_u64(data + 8);
        uint64_t state_offset = HEADER_SIZE + capacity;
        store_u64(data + 32, (uint64_t)result);
        store_u64(data + 40, load_u64(data + state_offset));
        store_i64(data + 56, 0);
    }
    return result;
}

static unsigned char *read_file(const char *path, size_t *size)
{
    FILE *file = fopen(path, "rb");
    if (!file)
        return NULL;
    if (fseek(file, 0, SEEK_END) != 0) {
        fclose(file);
        return NULL;
    }
    long length = ftell(file);
    if (length < 0 || fseek(file, 0, SEEK_SET) != 0) {
        fclose(file);
        return NULL;
    }
    *size = (size_t)length;
    unsigned char *data = malloc(*size == 0 ? 1 : *size);
    if (!data) {
        fclose(file);
        return NULL;
    }
    if (*size != 0 && fread(data, 1, *size, file) != *size) {
        free(data);
        fclose(file);
        return NULL;
    }
    if (fclose(file) != 0) {
        free(data);
        return NULL;
    }
    return data;
}

static int write_file(const char *path, const unsigned char *data, size_t size)
{
    FILE *file = fopen(path, "wb");
    if (!file)
        return -1;
    int failed = size != 0 && fwrite(data, 1, size, file) != size;
    failed |= fclose(file) != 0;
    return failed ? -1 : 0;
}

int main(int argc, char **argv)
{
    if (argc != 3 && argc != 4)
        return 2;
    if (argc == 4 && strcmp(argv[3], "corrupt") != 0)
        return 2;

    size_t size = 0;
    unsigned char *data = read_file(argv[1], &size);
    if (!data)
        return 2;

    int64_t result = execute_packet(data, size, argc == 4);
    if (write_file(argv[2], data, size) != 0) {
        free(data);
        return 2;
    }
    free(data);

    printf("%" PRId64 "\n", result);
    return 0;
}
