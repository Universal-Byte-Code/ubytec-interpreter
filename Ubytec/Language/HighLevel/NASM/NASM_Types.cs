using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_Types<T> where T : IUbytecHighLevelEntity
    {
        public NASM_Types(
            CompilationScopes scopes,
            StringBuilder sb,
            T contextEntity,
            bool nullableClasses = false,
            bool nullableStructs = false,
            bool nullableRecords = false,
            bool nullableEnums = false)
        {
            if (!contextEntity.HasProperty(nameof(Module.Classes)) ||
                !contextEntity.HasProperty(nameof(Module.Structs)) ||
                !contextEntity.HasProperty(nameof(Module.Records)) ||
                !contextEntity.HasProperty(nameof(Module.Enums)))
                throw new NotImplementedException($"Type collections missing in {typeof(T).Name}.");

            dynamic dyn = contextEntity;

            var tmpCls = dyn.Classes;
            if (!(nullableClasses && tmpCls == null))
            {
                if (tmpCls is not Class[] cls) throw new InvalidCastException("Classes is not Class[].");
                foreach (var c in cls) sb.Append(FormatCompiledLines(c.Compile(scopes), scopes.GetDepth()));
            }

            var tmpStr = dyn.Structs;
            if (!(nullableStructs && tmpStr == null))
            {
                if (tmpStr is not Struct[] str) throw new InvalidCastException("Structs is not Struct[].");
                foreach (var s in str) sb.Append(FormatCompiledLines(s.Compile(scopes), scopes.GetDepth()));
            }

            var tmpRec = dyn.Records;
            if (!(nullableRecords && tmpRec == null))
            {
                if (tmpRec is not Record[] rec) throw new InvalidCastException("Records is not Record[].");
                foreach (var r in rec) sb.Append(FormatCompiledLines(r.Compile(scopes), scopes.GetDepth()));
            }

            var tmpEnm = dyn.Enums;
            if (!(nullableEnums && tmpEnm == null))
            {
                if (tmpEnm is not Enum[] enm) throw new InvalidCastException("Enums is not Enum[].");
                foreach (var e in enm) sb.Append(FormatCompiledLines(e.Compile(scopes), scopes.GetDepth()));
            }
        }
    }
}
