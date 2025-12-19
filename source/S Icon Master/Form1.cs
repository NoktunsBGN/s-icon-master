// SPDX-License-Identifier: GPL-2.0-only
namespace S_Icon_Master
{
    public partial class SelectDirForm : Form
    {
        bool validDir = false;
        ConsoleForm console;
        public SelectDirForm(ConsoleForm console)
        {
            InitializeComponent();
            this.console = console;
        }

        private void SelectButton_Click(object sender, EventArgs e)
        {
            using (FolderBrowserDialog fbd = new FolderBrowserDialog())
            {
                fbd.Description = "Select a parent directory";
                fbd.ShowNewFolderButton = false;
                console.DirList.Items.Add("Opening directory selection dialog...");
                if (fbd.ShowDialog() == DialogResult.OK)
                {
                    ParentDirText.Text = fbd.SelectedPath;
                    validDir = true;
                    console.DirList.Items.Add("Directory selected successfully!");
                }
                else
                {
                    ParentDirText.Text = "Error: No directory selected or directory is invalid.";
                    validDir = false;
                    console.DirList.Items.Add("Error: No directory selected or directory is invalid.");
                    MessageBox.Show("No directory selected or directory is invalid.", "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void ExitButton_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void SearchButton_Click(object sender, EventArgs e)
        {
            if (validDir)
            {
                console.DirList.Items.Add("Searching directory...");
                MainForm mainForm = new MainForm(ParentDirText.Text, console);
                mainForm.Show();
                Hide();
            }
            else
            {
                console.DirList.Items.Add("Error: No directory selected or directory is invalid.");
                MessageBox.Show("No directory selected or directory is invalid.", "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
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
