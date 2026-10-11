using System.Runtime.InteropServices;

namespace Ubytec.Tests;

/// <summary>Calls the host C runtime with an explicit C locale, independently of Ubytec.</summary>
internal sealed class CReference : IDisposable
{
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate nint CreateLocale(int category, [MarshalAs(UnmanagedType.LPStr)] string name);
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate nint NewLocale(int mask, [MarshalAs(UnmanagedType.LPStr)] string name, nint previous);
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate void FreeLocale(nint locale);
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate int CharacterLocale(int c, nint locale);
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate int Character(int c);
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate int AtoiLocale(nint text, nint locale);
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate long StrtolLocale(nint text, nint end, int radix, nint locale);

    private readonly nint library;
    private readonly nint locale;
    private readonly Dictionary<string, CharacterLocale> characters = new(StringComparer.Ordinal);
    private readonly Character ascii;
    private readonly FreeLocale free;
    private readonly AtoiLocale? atoi;
    private readonly StrtolLocale? strtol;

    internal CReference()
    {
        library = NativeLibrary.Load(OperatingSystem.IsWindows() ? "ucrtbase.dll" : "libc.so.6");
        T Export<T>(string name) where T : Delegate => Marshal.GetDelegateForFunctionPointer<T>(NativeLibrary.GetExport(library, name));
        if (OperatingSystem.IsWindows())
        {
            free = Export<FreeLocale>("_free_locale");
            locale = Export<CreateLocale>("_create_locale")(0, "C");
            ascii = Export<Character>("__isascii");
            atoi = Export<AtoiLocale>("_atoi_l");
        }
        else
        {
            free = Export<FreeLocale>("freelocale");
            locale = Export<NewLocale>("newlocale")(1, "C", 0);
            ascii = Export<Character>("isascii");
            // strtol_l matches atoi on the tested, representable decimal-int domain.
            strtol = Export<StrtolLocale>("strtol_l");
        }
        if (locale == 0) throw new InvalidOperationException("Cannot create reference C locale.");
        foreach (var name in new[] { "isalpha", "isdigit", "isalnum", "isprint", "toupper", "tolower" })
            characters.Add(name, Export<CharacterLocale>((OperatingSystem.IsWindows() ? "_" : "") + name + "_l"));
    }

    internal int EvaluateCharacter(string function, int input)
    {
        string name = function[3..];
        int value = name == "isascii" ? ascii(input) : characters[name](input, locale);
        return name.StartsWith("is", StringComparison.Ordinal) ? (value == 0 ? 0 : 1) : value;
    }

    internal int EvaluateAtoi(nint text) => atoi is not null
        ? atoi(text, locale) : checked((int)strtol!(text, 0, 10, locale));

    public void Dispose()
    {
        free(locale);
        NativeLibrary.Free(library);
    }
}
