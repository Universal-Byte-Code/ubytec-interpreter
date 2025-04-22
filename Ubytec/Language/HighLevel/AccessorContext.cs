using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct AccessorContext : IUbytecHighLevelEntity
    {
        public Func? Get { get; }
        public Func? Set { get; }
        public Func? Init { get; }
        public UType PropertyType { get; }
        public Guid ID { get; }

        public AccessorContext(Func[] accessors, Guid id, UType propertyType)
        {
            PropertyType = propertyType;
            ID= id;

            ValidateInternal(accessors, propertyType, out Func? get, out Func? set, out Func? init);

            Get = get;
            Set = set;
            Init = init;
        }

        public Func[] ToArray()
        {
            if (Set is not null) return Get is not null ? [Get.Value, Set.Value] : [Set.Value];
            if (Init is not null) return Get is not null ? [Get.Value, Init.Value] : [Init.Value];
            return Get is not null ? [Get.Value] : [];
        }

        public void Validate()
        {
            _ = new AccessorContext(ToArray(), ID, PropertyType); // reuse validation logic
        }

        private static void ValidateInternal(Func[] accessors, UType propertyType, out Func? get, out Func? set, out Func? init)
        {
            if (accessors.Length > 2)
                throw new ArgumentException("AccessorContext can contain at most 2 functions.", nameof(accessors));

            get = null;
            set = null;
            init = null;

            foreach (var accessor in accessors)
            {
                switch (accessor.Name.ToLowerInvariant())
                {
                    case "get":
                        if (get is not null)
                            throw new ArgumentException("Duplicate getter accessor detected.");
                        if (!accessor.ReturnType.Equals(propertyType))
                            throw new ArgumentException($"Getter return type '{accessor.ReturnType}' does not match property type '{propertyType}'.");
                        get = accessor;
                        break;

                    case "set":
                        if (set is not null)
                            throw new ArgumentException("Duplicate setter accessor detected.");
                        if (init is not null)
                            throw new ArgumentException("Cannot have both 'set' and 'init' accessors.");
                        if (accessor.ReturnType.Type != PrimitiveType.Void)
                            throw new ArgumentException("Setter must return void.");
                        if (accessor.Arguments.Length != 1 || !accessor.Arguments[0].Type.Equals(propertyType))
                            throw new ArgumentException("Setter must take exactly one argument of the property type.");
                        set = accessor;
                        break;

                    case "init":
                        if (init is not null)
                            throw new ArgumentException("Duplicate init accessor detected.");
                        if (set is not null)
                            throw new ArgumentException("Cannot have both 'set' and 'init' accessors.");
                        if (accessor.ReturnType.Type != PrimitiveType.Void)
                            throw new ArgumentException("Init must return void.");
                        if (accessor.Arguments.Length != 1 || !accessor.Arguments[0].Type.Equals(propertyType))
                            throw new ArgumentException("Init must take exactly one argument of the property type.");
                        init = accessor;
                        break;

                    default:
                        throw new ArgumentException($"Invalid accessor name: '{accessor.Name}'. Expected 'get', 'set', or 'init'.");
                }
            }
        }

        public string Compile(CompilationScopes scopes)
        {
            var sb = new StringBuilder();
            sb.AppendLine($"; AccessorContext ID: {ID}");
            sb.AppendLine(Get?.Compile(scopes));
            sb.AppendLine(Set?.Compile(scopes));
            sb.AppendLine(Init?.Compile(scopes));
            return sb.ToString();
        }
    }
}