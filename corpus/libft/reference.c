/* Independent command-line C oracle for the scalar Ubytec corpus.
   cc -std=c11 -O2 reference.c -o libft-reference
   ./libft-reference isalpha 65
   ./libft-reference atoi "  -42suffix"
   Character arguments: EOF (-1) or unsigned-char values (0..255).
   atoi arguments: the converted value must be representable as int. */
#include <ctype.h>
#include <limits.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
    if (argc != 3 || setlocale(LC_ALL, "C") == NULL) return 2;
    if (strcmp(argv[1], "atoi") == 0) {
        printf("%d\n", atoi(argv[2]));
        return 0;
    }
    char *end;
    long input = strtol(argv[2], &end, 10);
    if (end == argv[2] || *end != '\0' || input < EOF || input > UCHAR_MAX) return 2;
    int c = (int)input;
    int result;
    if (strcmp(argv[1], "isalpha") == 0) result = !!isalpha(c);
    else if (strcmp(argv[1], "isdigit") == 0) result = !!isdigit(c);
    else if (strcmp(argv[1], "isalnum") == 0) result = !!isalnum(c);
    else if (strcmp(argv[1], "isascii") == 0) result = c >= 0 && c <= 127;
    else if (strcmp(argv[1], "isprint") == 0) result = !!isprint(c);
    else if (strcmp(argv[1], "toupper") == 0) result = toupper(c);
    else if (strcmp(argv[1], "tolower") == 0) result = tolower(c);
    else return 2;
    printf("%d\n", result);
    return 0;
}
