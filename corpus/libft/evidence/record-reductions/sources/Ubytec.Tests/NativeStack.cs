using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text;
using Xunit;

namespace Ubytec.Tests;

/// <summary>Assembles trusted compiler output and executes it with the host x64 ABI.</summary>
internal static class NativeStack
{
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
    private delegate void Entry(nint output);

    internal static long[] Run(string body, int cells, string? definitions = null)
    {
        if (RuntimeInformation.ProcessArchitecture != Architecture.X64 ||
            !(OperatingSystem.IsWindows() || OperatingSystem.IsLinux()))
            throw new PlatformNotSupportedException("Native opcode tests require Windows/Linux x64.");

        string directory = Path.Combine(Path.GetTempPath(), "ubytec-opcodes-" + Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(directory);
        try
        {
            string source = Path.Combine(directory, "test.asm");
            string binary = Path.Combine(directory, "test.bin");
            var asm = new StringBuilder("bits 64\n  push rbp\n  mov rbp, rsp\n");
            asm.AppendLine(OperatingSystem.IsWindows() ? "mov r11, rcx" : "mov r11, rdi");
            asm.AppendLine(body);
            // Record actual depth before removing results, so every stack effect is checked.
            asm.AppendLine("mov rax, rbp\n  sub rax, rsp\n  mov [r11], rax");
            for (int i = cells; i > 0; i--)
                asm.AppendLine($"pop rax\n  mov [r11 + {i * 8}], rax");
            asm.AppendLine("mov rsp, rbp\n  pop rbp\n  ret");
            if (definitions is not null) asm.AppendLine(definitions);
            File.WriteAllText(source, asm.ToString());
            var start = new ProcessStartInfo(Environment.GetEnvironmentVariable("UBYTEC_NASM") ?? "nasm")
            {
                RedirectStandardError = true,
                UseShellExecute = false,
                CreateNoWindow = true
            };
            foreach (string arg in new[] { "-f", "bin", "-o", binary, source }) start.ArgumentList.Add(arg);
            using (var process = Process.Start(start)!)
            {
                string error = process.StandardError.ReadToEnd();
                Assert.True(process.WaitForExit(30000), "NASM did not finish.");
                Assert.True(process.ExitCode == 0, error);
            }

            byte[] code = File.ReadAllBytes(binary);
            nint executable = Allocate(code.Length);
            nint output = Marshal.AllocHGlobal((cells + 1) * 8);
            try
            {
                Marshal.Copy(code, 0, executable, code.Length);
                Protect(executable, code.Length);
                Marshal.GetDelegateForFunctionPointer<Entry>(executable)(output);
                Assert.Equal((long)cells * 8, Marshal.ReadInt64(output));
                return Enumerable.Range(1, cells).Select(i => Marshal.ReadInt64(output, i * 8)).ToArray();
            }
            finally
            {
                Marshal.FreeHGlobal(output);
                if (OperatingSystem.IsWindows()) Assert.True(VirtualFree(executable, 0, 0x8000));
                else Assert.Equal(0, munmap(executable, (nuint)code.Length));
            }
        }
        finally { Directory.Delete(directory, true); }
    }

    private static nint Allocate(int size)
    {
        nint ptr = OperatingSystem.IsWindows()
            ? VirtualAlloc(0, (nuint)size, 0x3000, 0x04)
            : mmap(0, (nuint)size, 3, 0x22, -1, 0);
        if (ptr == 0 || ptr == -1) throw new InvalidOperationException("Cannot allocate test memory.");
        return ptr;
    }

    private static void Protect(nint ptr, int size)
    {
        if (OperatingSystem.IsWindows()) Assert.True(VirtualProtect(ptr, (nuint)size, 0x20, out _));
        else Assert.Equal(0, mprotect(ptr, (nuint)size, 5));
    }

    [DllImport("kernel32", SetLastError = true)]
    private static extern nint VirtualAlloc(nint address, nuint size, uint allocationType, uint protection);
    [DllImport("kernel32", SetLastError = true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    private static extern bool VirtualProtect(nint address, nuint size, uint protection, out uint oldProtection);
    [DllImport("kernel32", SetLastError = true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    private static extern bool VirtualFree(nint address, nuint size, uint freeType);
    [DllImport("libc", SetLastError = true)]
    private static extern nint mmap(nint address, nuint length, int protection, int flags, int fd, nint offset);
    [DllImport("libc", SetLastError = true)]
    private static extern int mprotect(nint address, nuint length, int protection);
    [DllImport("libc", SetLastError = true)]
    private static extern int munmap(nint address, nuint length);
}
