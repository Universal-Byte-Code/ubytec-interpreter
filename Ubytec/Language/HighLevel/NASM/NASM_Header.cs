using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_Header<T> where T : IUbytecHighLevelEntity
    {
        public NASM_Header(
            CompilationScopes scopes,
            StringBuilder sb,
            T contextEntity,
            bool nullableName = false,
            bool nullableVersion = false,
            bool nullableAuthor = false)
        {
            if (!contextEntity.HasProperty(nameof(Module.Name)) ||
                !contextEntity.HasProperty(nameof(Module.Version)) ||
                !contextEntity.HasProperty(nameof(Module.Author)))
                throw new NotImplementedException($"Property Name/Version/Author missing in {typeof(T).Name}.");

            var tempName = ((dynamic)contextEntity).Name;
            var tempVersion = ((dynamic)contextEntity).Version;
            var tempAuthor = ((dynamic)contextEntity).Author;

            if (nullableName    && tempName    == null ||
                nullableVersion && tempVersion == null ||
                nullableAuthor  && tempAuthor  == null)
                return;

            if (tempName is not string name) throw new InvalidCastException($"Name is not string in {typeof(T).Name}.");
            if (tempVersion is not string version) throw new InvalidCastException($"Version is not string in {typeof(T).Name}.");
            if (tempAuthor is not string author) throw new InvalidCastException($"Author is not string in {typeof(T).Name}.");

            sb.Append(FormatCompiledLines($"{scopes.Peek().StartLabel}:", scopes.GetDepth(-1)));
            sb.AppendLine(
                FormatCompiledLines($"; Module: {name} v{version} by {author}", scopes.GetDepth(-1))
            );
        }
    }
}
