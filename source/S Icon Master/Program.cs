// SPDX-License-Identifier: GPL-2.0-only
namespace S_Icon_Master
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.SetHighDpiMode(HighDpiMode.DpiUnaware);
            ApplicationConfiguration.Initialize();
            ConsoleForm console = new ConsoleForm();
            Application.Run(new SelectDirForm(console));
        }
    }

}
