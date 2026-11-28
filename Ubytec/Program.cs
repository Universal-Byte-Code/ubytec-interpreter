[assembly: System.CLSCompliant(true)]
[assembly: System.Runtime.InteropServices.ComVisible(true)]

namespace Ubytec;

internal static class Program
{
    private static int Main(string[] args) => CommandLineDriver.Run(args);
}
