using System;
using System.Text;

namespace Ubytec.Language.Tools
{
    /// <summary>
    /// Encoder/decoder for UTF-64, a URL-safe, JSONish string encoding with full
    /// surrogate pair support (handles code points above 0xFFFF).
    /// Original concept by Iain Merrick (https://github.com/more-please/more-stuff/tree/main/utf64).
    /// C# port Version: 1.0.4.
    /// </summary>
    public static class Utf64Codec
    {
        // The base64 mapping used for encoding/decoding:
        // '_' (ASCII 95), 'A'..'Z' (1..26), 'a'..'z' (27..52), '0'..'9' (53..62), '-' (63).
        private const string Base64Map = "_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-";

        // Characters mapped directly to entries in Base64Map by index.
        private const string SpecialChars = "_\"',.;:!?()[]{}#=+-*/\\\n ";

        /// <summary>
        /// Encodes the specified .NET UTF-16 string into UTF-64.
        /// </summary>
        /// <param name="input">The input string to encode.</param>
        /// <returns>The UTF-64–encoded representation of <paramref name="input"/>.</returns>
        /// <exception cref="ArgumentNullException">
        /// Thrown if <paramref name="input"/> is <c>null</c>.
        /// </exception>
        public static string Encode(string input)
        {
            if (input == null) throw new ArgumentNullException(nameof(input));

            var sb = new StringBuilder();
            int i = 0;

            while (i < input.Length)
            {
                // Convert next character (or surrogate pair) to code point
                int codePoint = char.ConvertToUtf32(input, i);
                i += char.IsSurrogatePair(input, i) ? 2 : 1;

                // 1) Lowercase letters, digits, and hyphen map to themselves
                if ((codePoint >= 'a' && codePoint <= 'z') ||
                    (codePoint >= '0' && codePoint <= '9') ||
                     codePoint == '-')
                {
                    sb.Append((char)codePoint);
                    continue;
                }

                // 2) SpecialChars map by index into Base64Map
                int specialIndex = SpecialChars.IndexOf((char)codePoint);
                if (specialIndex >= 0)
                {
                    sb.Append(Base64Map[specialIndex]);
                    continue;
                }

                // 3) Otherwise branch by numeric range
                if (codePoint < 64)
                {
                    // 'X' prefix for code points 0..63
                    sb.Append('X')
                      .Append(Base64Map[codePoint]);
                }
                else if (codePoint < 128)
                {
                    // 'Y' prefix for code points 64..127
                    sb.Append('Y')
                      .Append(Base64Map[codePoint - 64]);
                }
                else
                {
                    // 'Z' prefix for extended multi-byte encoding
                    sb.Append('Z');
                    EncodeExtended(sb, codePoint);
                }
            }

            return sb.ToString();
        }

        /// <summary>
        /// Decodes the specified UTF-64 string back into a .NET UTF-16 string,
        /// reconstructing surrogate pairs for code points above 0xFFFF.
        /// </summary>
        /// <param name="input">The UTF-64–encoded string to decode.</param>
        /// <returns>The decoded .NET string.</returns>
        /// <exception cref="ArgumentNullException">
        /// Thrown if <paramref name="input"/> is <c>null</c>.
        /// </exception>
        /// <exception cref="FormatException">
        /// Thrown if the input contains invalid UTF-64 sequences.
        /// </exception>
        public static string Decode(string input)
        {
            if (input == null) throw new ArgumentNullException(nameof(input));

            var sb = new StringBuilder();
            int index = 0, length = input.Length;

            int NextCode()
            {
                if (index >= length)
                    throw new FormatException("Unexpected end of input while decoding (NextCode).");

                char c = input[index++];
                int n = c;

                if (n == 95) return 0;                // '_'
                if (n >= 65 && n <= 90) return 1 + (n - 65);    // 'A'..'Z'
                if (n >= 97 && n <= 122) return 27 + (n - 97);  // 'a'..'z'
                if (n >= 48 && n <= 57) return 53 + (n - 48);   // '0'..'9'
                if (n == 45) return 63;               // '-'
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
                    int specialIndex = c - 64;
                    if (specialIndex < 1 || specialIndex >= SpecialChars.Length)
                        throw new FormatException($"Invalid mapping for character '{c}' (index {specialIndex}).");
                    sb.Append(SpecialChars[specialIndex]);
                    continue;
                }

                // 'X' => ASCII 0..63
                if (c == 'X')
                {
                    sb.Append((char)NextCode());
                    continue;
                }

                // 'Y' => ASCII 64..127
                if (c == 'Y')
                {
                    sb.Append((char)(NextCode() + 64));
                    continue;
                }

                // 'Z' => extended multi-byte scenario
                if (c == 'Z')
                {
                    int codePoint = DecodeExtended();
                    sb.Append(char.ConvertFromUtf32(codePoint));
                    continue;
                }

                throw new FormatException($"Invalid UTF-64 character: {c}");
            }

            return sb.ToString();

            int DecodeExtended()
            {
                int prefix = NextCode();
                int bytesNeeded;

                if (prefix < 0x20)
                {
                    prefix &= 0x1F;
                    bytesNeeded = 1;
                }
                else if (prefix < 0x30)
                {
                    prefix &= 0x0F;
                    bytesNeeded = 2;
                }
                else if (prefix < 0x38)
                {
                    prefix &= 0x07;
                    bytesNeeded = 3;
                }
                else
                {
                    throw new FormatException($"Invalid UTF-8 prefix in 'Z': {prefix}");
                }

                int codePoint = prefix;
                for (int b = 0; b < bytesNeeded; b++)
                    codePoint = (codePoint << 6) + NextCode();

                return codePoint;
            }
        }

        #region Private Helpers

        /// <summary>
        /// Appends the extended UTF-64 encoding for code points ≥ 128,
        /// producing 2–4 “bytes” (6-bit groups) as needed.
        /// </summary>
        /// <param name="sb">The <see cref="StringBuilder"/> to append to.</param>
        /// <param name="codePoint">
        /// The Unicode code point to encode (must be between 128 and 0x10FFFF).
        /// </param>
        /// <exception cref="FormatException">
        /// Thrown if <paramref name="codePoint"/> is outside the valid Unicode range.
        /// </exception>
        private static void EncodeExtended(StringBuilder sb, int codePoint)
        {
            if (codePoint <= 0x7FF)
            {
                // 2-byte scenario
                sb.Append(Base64Map[codePoint >> 6]);
                sb.Append(Base64Map[codePoint & 0x3F]);
            }
            else if (codePoint <= 0xFFFF)
            {
                // 3-byte scenario
                int top = 0x20 + (codePoint >> 12);
                sb.Append(Base64Map[top]);
                sb.Append(Base64Map[(codePoint >> 6) & 0x3F]);
                sb.Append(Base64Map[codePoint & 0x3F]);
            }
            else if (codePoint <= 0x10FFFF)
            {
                // 4-byte scenario
                int top = 0x30 + (codePoint >> 18);
                sb.Append(Base64Map[top]);
                sb.Append(Base64Map[(codePoint >> 12) & 0x3F]);
                sb.Append(Base64Map[(codePoint >> 6) & 0x3F]);
                sb.Append(Base64Map[codePoint & 0x3F]);
            }
            else
            {
                throw new FormatException($"Invalid Unicode code point: {codePoint} (max 0x10FFFF).");
            }
        }

        #endregion
    }
}
