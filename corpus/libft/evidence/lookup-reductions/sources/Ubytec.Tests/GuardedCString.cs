using System.Runtime.InteropServices;

namespace Ubytec.Tests;

/// <summary>Places a C string's terminating NUL immediately before an inaccessible page.</summary>
internal sealed class GuardedCString : IDisposable
{
    private readonly nint allocation;
    private readonly int page = Environment.SystemPageSize;
    internal nint Pointer { get; }

    internal GuardedCString(byte[] bytes, bool requireTerminator = true)
    {
        if (bytes.Length > page || (requireTerminator && (bytes.Length == 0 || bytes[^1] != 0)))
            throw new ArgumentException("Expected a page-sized or smaller buffer, terminated unless explicitly bounded.");
        allocation = OperatingSystem.IsWindows()
            ? VirtualAlloc(0, (nuint)(page * 2), 0x3000, 0x04)
            : mmap(0, (nuint)(page * 2), 3, 0x22, -1, 0);
        if (allocation == 0 || allocation == -1) throw new InvalidOperationException("Guard allocation failed.");
        bool protectedPage = OperatingSystem.IsWindows()
            ? VirtualProtect(allocation + page, (nuint)page, 0x01, out _)
            : mprotect(allocation + page, (nuint)page, 0) == 0;
        if (!protectedPage)
        {
            Dispose();
            throw new InvalidOperationException("Guard protection failed.");
        }
        Pointer = allocation + page - bytes.Length;
        Marshal.Copy(bytes, 0, Pointer, bytes.Length);
    }

    public void Dispose()
    {
        if (OperatingSystem.IsWindows()) VirtualFree(allocation, 0, 0x8000);
        else munmap(allocation, (nuint)(page * 2));
    }

    [DllImport("kernel32", SetLastError = true)] private static extern nint VirtualAlloc(nint address, nuint size, uint allocationType, uint protection);
    [DllImport("kernel32", SetLastError = true)] [return: MarshalAs(UnmanagedType.Bool)]
    private static extern bool VirtualProtect(nint address, nuint size, uint protection, out uint oldProtection);
    [DllImport("kernel32", SetLastError = true)] [return: MarshalAs(UnmanagedType.Bool)]
    private static extern bool VirtualFree(nint address, nuint size, uint freeType);
    [DllImport("libc", SetLastError = true)] private static extern nint mmap(nint address, nuint length, int protection, int flags, int fd, nint offset);
    [DllImport("libc", SetLastError = true)] private static extern int mprotect(nint address, nuint length, int protection);
    [DllImport("libc", SetLastError = true)] private static extern int munmap(nint address, nuint length);
}
