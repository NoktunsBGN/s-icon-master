// SPDX-License-Identifier: GPL-2.0-only
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S_Icon_Master
{
    public partial class MainForm : Form
    {
        string dirPath;
        ConsoleForm console;
        List<string> icons = new List<string>();
        List<string> dirs = new List<string>();
        public MainForm(string dirPath, ConsoleForm console)
        {
            InitializeComponent();
            this.dirPath = dirPath;
            this.console = console;
        }

        private void ExitButton_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            LoadDirList(dirPath);
        }

        private void LoadDirList(string parentPath)
        {
            DirList.Items.Clear();
            icons.Clear();
            dirs.Clear();
            string[] dirsCurr = Directory.GetDirectories(parentPath);
            foreach (string dir in dirsCurr)
            {
                string[] iconsCurr = Directory.GetFiles(dir, "*.ico");
                if (iconsCurr.Length > 0)
                {
                    DirList.Items.Add(dir);
                    console.DirList.Items.Add("Found directory " + dir.Split("\\")[dir.Split("\\").Length - 1] + " with icon.");
                    dirs.Add(dir);
                    icons.Add(iconsCurr[0].Split("\\")[iconsCurr[0].Split("\\").Length - 1]);
                }
            }
        }

        private void ApplyButton_Click(object sender, EventArgs e)
        {
            if (DirList.Items.Count > 0)
            {
                for (int i = 0; i < DirList.Items.Count; i++)
                {
                    console.DirList.Items.Add("Applying icon to " + dirs[i].Split("\\")[dirs[i].Split("\\").Length - 1] + "...");
                    string iniPath = Path.Combine(dirs[i], "desktop.ini");
                    List<string> iniContents = new List<string>();
                    iniContents.Clear();
                    iniContents.Add("[.ShellClassInfo]");
                    iniContents.Add("IconResource=.\\" + icons[i] + ",0");
                    iniContents.Add("[ViewState]");
                    iniContents.Add("Mode=");
                    iniContents.Add("Vid=");
                    iniContents.Add("FolderType=Generic");
                    if (File.Exists(iniPath))
                    {
                        File.Delete(iniPath);
                    }
                    File.WriteAllLines(iniPath, iniContents);
                    File.SetAttributes(iniPath, FileAttributes.System | FileAttributes.Hidden);
                    if (hideCheckBox.Checked)
                    {
                        File.SetAttributes(Path.Combine(dirs[i], icons[i]), FileAttributes.Hidden);
                    }
                    DirectoryInfo dirInfo = new DirectoryInfo(dirs[i]);
                    dirInfo.Attributes |= FileAttributes.System;
                }
                MessageBox.Show("Applied all " + DirList.Items.Count + " available icons!", "Done!", MessageBoxButtons.OK);
                console.DirList.Items.Add("Applied all " + DirList.Items.Count + " available icons!");
            }
            else
            {
                MessageBox.Show("No icons found to apply.", "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                console.DirList.Items.Add("Error: No icons found to apply.");
            }
        }

        private void ConsoleButton_Click(object sender, EventArgs e)
        {
            if (console.Visible)
            {
                console.Hide();
            }
            else
            {
                console.Show();
            }
        }
    }
}

