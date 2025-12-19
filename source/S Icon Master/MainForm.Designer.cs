// SPDX-License-Identifier: GPL-2.0-only
namespace S_Icon_Master
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            label1 = new Label();
            DirList = new ListBox();
            pictureBox1 = new PictureBox();
            hideCheckBox = new CheckBox();
            ApplyButton = new PictureBox();
            ExitButton = new PictureBox();
            ConsoleButton = new PictureBox();
            ((System.ComponentModel.ISupportInitialize)pictureBox1).BeginInit();
            ((System.ComponentModel.ISupportInitialize)ApplyButton).BeginInit();
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
            label1.Location = new Point(55, 38);
            label1.Name = "label1";
            label1.Size = new Size(219, 42);
            label1.TabIndex = 1;
            label1.Text = "The following directories were\r\ndetected to contain icons:";
            label1.TextAlign = ContentAlignment.TopCenter;
            // 
            // DirList
            // 
            DirList.BackColor = Color.FromArgb(50, 4, 150);
            DirList.ForeColor = Color.White;
            DirList.FormattingEnabled = true;
            DirList.ItemHeight = 15;
            DirList.Items.AddRange(new object[] { "(None)" });
            DirList.Location = new Point(12, 83);
            DirList.Name = "DirList";
            DirList.Size = new Size(304, 499);
            DirList.TabIndex = 7;
            // 
            // pictureBox1
            // 
            pictureBox1.BackColor = Color.Transparent;
            pictureBox1.Image = (Image)resources.GetObject("pictureBox1.Image");
            pictureBox1.InitialImage = (Image)resources.GetObject("pictureBox1.InitialImage");
            pictureBox1.Location = new Point(227, 0);
            pictureBox1.Name = "pictureBox1";
            pictureBox1.Size = new Size(100, 36);
            pictureBox1.SizeMode = PictureBoxSizeMode.Zoom;
            pictureBox1.TabIndex = 8;
            pictureBox1.TabStop = false;
            // 
            // hideCheckBox
            // 
            hideCheckBox.AutoSize = true;
            hideCheckBox.BackColor = Color.Transparent;
            hideCheckBox.ForeColor = Color.White;
            hideCheckBox.Location = new Point(78, 588);
            hideCheckBox.Name = "hideCheckBox";
            hideCheckBox.Size = new Size(172, 19);
            hideCheckBox.TabIndex = 9;
            hideCheckBox.Text = "Hide icon file after applying";
            hideCheckBox.UseVisualStyleBackColor = false;
            // 
            // ApplyButton
            // 
            ApplyButton.BackColor = Color.Transparent;
            ApplyButton.BackgroundImageLayout = ImageLayout.None;
            ApplyButton.Cursor = Cursors.Hand;
            ApplyButton.Image = (Image)resources.GetObject("ApplyButton.Image");
            ApplyButton.Location = new Point(174, 615);
            ApplyButton.Name = "ApplyButton";
            ApplyButton.Size = new Size(142, 46);
            ApplyButton.SizeMode = PictureBoxSizeMode.StretchImage;
            ApplyButton.TabIndex = 14;
            ApplyButton.TabStop = false;
            ApplyButton.Click += ApplyButton_Click;
            // 
            // ExitButton
            // 
            ExitButton.BackColor = Color.Transparent;
            ExitButton.BackgroundImageLayout = ImageLayout.None;
            ExitButton.Cursor = Cursors.Hand;
            ExitButton.Image = (Image)resources.GetObject("ExitButton.Image");
            ExitButton.Location = new Point(12, 615);
            ExitButton.Name = "ExitButton";
            ExitButton.Size = new Size(142, 46);
            ExitButton.SizeMode = PictureBoxSizeMode.StretchImage;
            ExitButton.TabIndex = 15;
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
            ConsoleButton.TabIndex = 16;
            ConsoleButton.TabStop = false;
            ConsoleButton.Click += ConsoleButton_Click;
            // 
            // MainForm
            // 
            AutoScaleMode = AutoScaleMode.None;
            BackColor = Color.FromArgb(255, 128, 128);
            BackgroundImage = Properties.Resources.bg1;
            BackgroundImageLayout = ImageLayout.Stretch;
            ClientSize = new Size(328, 673);
            ControlBox = false;
            Controls.Add(ConsoleButton);
            Controls.Add(ExitButton);
            Controls.Add(ApplyButton);
            Controls.Add(hideCheckBox);
            Controls.Add(pictureBox1);
            Controls.Add(DirList);
            Controls.Add(label1);
            DoubleBuffered = true;
            FormBorderStyle = FormBorderStyle.Fixed3D;
            Icon = (Icon)resources.GetObject("$this.Icon");
            MaximizeBox = false;
            Name = "MainForm";
            Text = "S Icon Master - Apply Icons";
            Load += MainForm_Load;
            ((System.ComponentModel.ISupportInitialize)pictureBox1).EndInit();
            ((System.ComponentModel.ISupportInitialize)ApplyButton).EndInit();
            ((System.ComponentModel.ISupportInitialize)ExitButton).EndInit();
            ((System.ComponentModel.ISupportInitialize)ConsoleButton).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion
        private Label label1;
        private ListBox DirList;
        private PictureBox pictureBox1;
        private CheckBox hideCheckBox;
        private PictureBox ApplyButton;
        private PictureBox ExitButton;
        private PictureBox ConsoleButton;
    }

}
