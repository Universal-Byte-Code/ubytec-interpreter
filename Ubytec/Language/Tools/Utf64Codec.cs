using System.Text;

namespace Ubytec.Language.Tools
{
    /// <summary>
    /// Encoder/decoder for UTF-64, a URL-safe encoding for JSONish strings.
    /// Full Surrogate Pair Support version (handles code points above 0xFFFF).
    /// Original concept by Iain Merrick on https://github.com/more-please/more-stuff/tree/main/utf64
    /// 
    /// Version: 1.0.4 (C# port, with advanced Unicode)
    /// </summary>
    public static class Utf64Codec
    {
        // The base64 mapping used for encoding/decoding 
        // '_' (ASCII 95), 'A'..'Z' (1..26), 'a'..'z' (27..52), '0'..'9' (53..62), '-'(63).
        private const string Base64Map = "_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-";

        // Characters mapped directly to entries in Base64Map by index
        private const string SpecialChars = "_\"',.;:!?()[]{}#=+-*/\\\n ";

        /// <summary>
        /// Encode a .NET string into UTF-64.
        /// - Merges surrogate pairs to produce correct code points.
        /// - Produces "a-z", "0-9", "-" as themselves.
        /// - Maps chars in SpecialChars to Base64Map by index.
        /// - Otherwise uses 'X', 'Y' or 'Z' expansions based on code point range.
        /// </summary>
        public static string Encode(string input)
        {
            if (input == null) throw new ArgumentNullException(nameof(input));

            var sb = new StringBuilder();

            int i = 0;
            while (i < input.Length)
            {
                // Convert next character (or surrogate pair) to code point
                int codePoint = char.ConvertToUtf32(input, i);

                // If it's a surrogate pair, skip an extra char
                i += char.IsSurrogatePair(input, i) ? 2 : 1;

                // 1) a-z, 0-9, '-'
                if ((codePoint >= 'a' && codePoint <= 'z') ||
                    (codePoint >= '0' && codePoint <= '9') ||
                     codePoint == '-')
                {
                    sb.Append((char)codePoint);
                    continue;
                }

                // 2) Check if in SpecialChars => map to Base64Map by index
                int specialIndex = SpecialChars.IndexOf((char)codePoint);
                if (specialIndex >= 0)
                {
                    sb.Append(Base64Map[specialIndex]);
                    continue;
                }

                // 3) Otherwise branch by numeric value
                if (codePoint < 64)
                {
                    // 'X' => 0..63
                    sb.Append('X')
                      .Append(Base64Map[codePoint]);
                }
                else if (codePoint < 128)
                {
                    // 'Y' => 64..127
                    sb.Append('Y')
                      .Append(Base64Map[codePoint - 64]);
                }
                else
                {
                    // 'Z' => multi-byte scenario
                    sb.Append('Z');
                    EncodeExtended(sb, codePoint);
                }
            }

            return sb.ToString();
        }

        /// <summary>
        /// Decode a UTF-64 string back to a normal .NET string (UTF-16),
        /// including surrogate pairs for code points above 0xFFFF.
        /// </summary>
        public static string Decode(string input)
        {
            if (input == null) throw new ArgumentNullException(nameof(input));

            var sb = new StringBuilder();
            int index = 0;
            int length = input.Length;

            // local helper to get next 6-bit code from Base64Map
            int NextCode()
            {
                if (index >= length)
                    throw new FormatException("Unexpected end of input while decoding (NextCode).");

                char c = input[index++];
                int n = c;

                if (n == 95) return 0;   // '_'
                if (n >= 65 && n <= 90) return 1 + (n - 65);    // 'A'..'Z' => 1..26
                if (n >= 97 && n <= 122) return 27 + (n - 97);   // 'a'..'z' => 27..52
                if (n >= 48 && n <= 57) return 53 + (n - 48);   // '0'..'9' => 53..62
                if (n == 45) return 63;  // '-'

                throw new FormatException($"Invalid UTF-64 character: {c}");
            }

            while (index < length)
            {
                char c = input[index++];

                // a-z, 0-9, '-', '_'
                if ((c >= 'a' && c <= 'z') ||
                    (c >= '0' && c <= '9') ||
                     c == '-' ||
                     c == '_')
                {
                    sb.Append(c);
                    continue;
                }

                // 'A'..'W' => map to SpecialChars
                if (c >= 'A' && c <= 'W')
                {
                    int specialIndex = c - 64;  // 'A'(65)->1, 'B'(66)->2, etc.
                    if (specialIndex < 1 || specialIndex >= SpecialChars.Length)
                    {
                        throw new FormatException($"Invalid mapping for character '{c}' (index {specialIndex}).");
                    }
                    sb.Append(SpecialChars[specialIndex]);
                    continue;
                }

                // 'X' => ASCII 0..63
                if (c == 'X')
                {
                    int code = NextCode();
                    sb.Append((char)code);
                    continue;
                }

                // 'Y' => ASCII 64..127
                if (c == 'Y')
                {
                    int code = NextCode() + 64;
                    sb.Append((char)code);
                    continue;
                }

                // 'Z' => multi-byte scenario
                if (c == 'Z')
                {
                    int codePoint = DecodeExtended();
                    // If codePoint > 0xFFFF => produce a surrogate pair
                    sb.Append(char.ConvertFromUtf32(codePoint));
                    continue;
                }

                // Invalid character
                throw new FormatException($"Invalid UTF-64 character: {c}");

            } // end while

            return sb.ToString();

            // local function for multi-byte scenario
            int DecodeExtended()
            {
                // Read the prefix
                int prefix = NextCode();
                int bytesNeeded;

                // Determine how many 6-bit groups remain
                if (prefix < 0x20)
                {
                    // prefix 0..31 => 1 more 6-bit group
                    prefix &= 0x1F;
                    bytesNeeded = 1;
                }
                else if (prefix < 0x30)
                {
                    // prefix 32..47 => 2 more 6-bit groups
                    prefix &= 0x0F;
                    bytesNeeded = 2;
                }
                else if (prefix < 0x38)
                {
                    // prefix 48..55 => 3 more 6-bit groups
                    prefix &= 0x07;
                    bytesNeeded = 3;
                }
                else
                {
                    throw new FormatException($"Invalid UTF-8 prefix in 'Z': {prefix}");
                }

                int codePoint = prefix;
                for (int b = 0; b < bytesNeeded; b++)
                {
                    codePoint = (codePoint << 6) + NextCode();
                }

                return codePoint;
            }
        }

        #region Private Helpers

        /// <summary>
        /// Encodes code points >= 128 using the 'Z' pattern:
        /// - up to 0x7FF => 2 "bytes"
        /// - up to 0xFFFF => 3 "bytes"
        /// - up to 0x10FFFF => 4 "bytes"
        /// Each "byte" is 6 bits from the code point.
        /// </summary>
        private static void EncodeExtended(StringBuilder sb, int codePoint)
        {
            // 2-byte scenario
            if (codePoint <= 0x7FF)
            {
                sb.Append(Base64Map[codePoint >> 6]);       // top 6 bits
                sb.Append(Base64Map[codePoint & 0x3F]);     // lower 6 bits
            }
            else if (codePoint <= 0xFFFF)
            {
                // 3-byte scenario
                int top = 0x20 + (codePoint >> 12);
                sb.Append(Base64Map[top]);

                int mid = (codePoint >> 6) & 0x3F;
                int low = codePoint & 0x3F;
                sb.Append(Base64Map[mid])
                  .Append(Base64Map[low]);
            }
            else if (codePoint <= 0x10FFFF)
            {
                // 4-byte scenario
                int top = 0x30 + (codePoint >> 18);
                sb.Append(Base64Map[top]);

                int midHigh = (codePoint >> 12) & 0x3F;
                int midLow = (codePoint >> 6)  & 0x3F;
                int low = codePoint & 0x3F;

                sb.Append(Base64Map[midHigh])
                  .Append(Base64Map[midLow])
                  .Append(Base64Map[low]);
            }
            else
            {
                // Invalid code point
                throw new FormatException($"Invalid Unicode code point: {codePoint} (max 0x10FFFF).");
            }
        }

        #endregion
    }
}
