// SPDX-License-Identifier: GPL-2.0-only
namespace S_Icon_Master
{
    partial class SelectDirForm
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SelectDirForm));
            label1 = new Label();
            ParentDirText = new RichTextBox();
            pictureBox1 = new PictureBox();
            SelectButton = new PictureBox();
            SearchButton = new PictureBox();
            ExitButton = new PictureBox();
            ConsoleButton = new PictureBox();
            ((System.ComponentModel.ISupportInitialize)pictureBox1).BeginInit();
            ((System.ComponentModel.ISupportInitialize)SelectButton).BeginInit();
            ((System.ComponentModel.ISupportInitialize)SearchButton).BeginInit();
            ((System.ComponentModel.ISupportInitialize)ExitButton).BeginInit();
            ((System.ComponentModel.ISupportInitialize)ConsoleButton).BeginInit();
            SuspendLayout();
            // 
            // label1
            // 
            label1.Anchor = AnchorStyles.Top;
            label1.AutoSize = true;
            label1.BackColor = Color.Transparent;
            label1.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point);
            label1.ForeColor = Color.White;
            label1.Location = new Point(22, 38);
            label1.Name = "label1";
            label1.Size = new Size(279, 21);
            label1.TabIndex = 0;
            label1.Text = "Select the parent directory to search in:";
            label1.TextAlign = ContentAlignment.TopCenter;
            // 
            // ParentDirText
            // 
            ParentDirText.BackColor = Color.FromArgb(50, 4, 150);
            ParentDirText.ForeColor = Color.White;
            ParentDirText.Location = new Point(22, 62);
            ParentDirText.Name = "ParentDirText";
            ParentDirText.ReadOnly = true;
            ParentDirText.Size = new Size(279, 41);
            ParentDirText.TabIndex = 3;
            ParentDirText.Text = "(None)";
            // 
            // pictureBox1
            // 
            pictureBox1.BackColor = Color.Transparent;
            pictureBox1.Image = (Image)resources.GetObject("pictureBox1.Image");
            pictureBox1.InitialImage = (Image)resources.GetObject("pictureBox1.InitialImage");
            pictureBox1.Location = new Point(222, 0);
            pictureBox1.Name = "pictureBox1";
            pictureBox1.Size = new Size(100, 36);
            pictureBox1.SizeMode = PictureBoxSizeMode.Zoom;
            pictureBox1.TabIndex = 6;
            pictureBox1.TabStop = false;
            // 
            // SelectButton
            // 
            SelectButton.BackColor = Color.Transparent;
            SelectButton.BackgroundImageLayout = ImageLayout.None;
            SelectButton.Cursor = Cursors.Hand;
            SelectButton.Image = Properties.Resources.button_select;
            SelectButton.Location = new Point(90, 109);
            SelectButton.Name = "SelectButton";
            SelectButton.Size = new Size(142, 27);
            SelectButton.SizeMode = PictureBoxSizeMode.StretchImage;
            SelectButton.TabIndex = 12;
            SelectButton.TabStop = false;
            SelectButton.Click += SelectButton_Click;
            // 
            // SearchButton
            // 
            SearchButton.BackColor = Color.Transparent;
            SearchButton.BackgroundImageLayout = ImageLayout.None;
            SearchButton.Cursor = Cursors.Hand;
            SearchButton.Image = (Image)resources.GetObject("SearchButton.Image");
            SearchButton.Location = new Point(167, 247);
            SearchButton.Name = "SearchButton";
            SearchButton.Size = new Size(142, 46);
            SearchButton.SizeMode = PictureBoxSizeMode.StretchImage;
            SearchButton.TabIndex = 13;
            SearchButton.TabStop = false;
            SearchButton.Click += SearchButton_Click;
            // 
            // ExitButton
            // 
            ExitButton.BackColor = Color.Transparent;
            ExitButton.BackgroundImageLayout = ImageLayout.None;
            ExitButton.Cursor = Cursors.Hand;
            ExitButton.Image = (Image)resources.GetObject("ExitButton.Image");
            ExitButton.Location = new Point(12, 247);
            ExitButton.Name = "ExitButton";
            ExitButton.Size = new Size(142, 46);
            ExitButton.SizeMode = PictureBoxSizeMode.StretchImage;
            ExitButton.TabIndex = 14;
            ExitButton.TabStop = false;
            ExitButton.Click += ExitButton_Click;
            // 
            // ConsoleButton
            // 
            ConsoleButton.BackColor = Color.Transparent;
            ConsoleButton.BackgroundImageLayout = ImageLayout.None;
            ConsoleButton.Cursor = Cursors.Hand;
            ConsoleButton.Image = (Image)resources.GetObject("ConsoleButton.Image");
            ConsoleButton.Location = new Point(1, 1);
            ConsoleButton.Name = "ConsoleButton";
            ConsoleButton.Size = new Size(58, 15);
            ConsoleButton.SizeMode = PictureBoxSizeMode.StretchImage;
            ConsoleButton.TabIndex = 15;
            ConsoleButton.TabStop = false;
            ConsoleButton.Click += ConsoleButton_Click;
            // 
            // SelectDirForm
            // 
            AutoScaleMode = AutoScaleMode.None;
            BackColor = Color.Black;
            BackgroundImage = Properties.Resources.bg0;
            ClientSize = new Size(323, 305);
            ControlBox = false;
            Controls.Add(ConsoleButton);
            Controls.Add(ExitButton);
            Controls.Add(SearchButton);
            Controls.Add(SelectButton);
            Controls.Add(pictureBox1);
            Controls.Add(ParentDirText);
            Controls.Add(label1);
            FormBorderStyle = FormBorderStyle.Fixed3D;
            Icon = (Icon)resources.GetObject("$this.Icon");
            MaximizeBox = false;
            Name = "SelectDirForm";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "S Icon Master - Select Directory";
            ((System.ComponentModel.ISupportInitialize)pictureBox1).EndInit();
            ((System.ComponentModel.ISupportInitialize)SelectButton).EndInit();
            ((System.ComponentModel.ISupportInitialize)SearchButton).EndInit();
            ((System.ComponentModel.ISupportInitialize)ExitButton).EndInit();
            ((System.ComponentModel.ISupportInitialize)ConsoleButton).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label label1;
        private RichTextBox ParentDirText;
        private PictureBox pictureBox1;
        private PictureBox SelectButton;
        private PictureBox SearchButton;
        private PictureBox ExitButton;
        private PictureBox ConsoleButton;
    }

}
