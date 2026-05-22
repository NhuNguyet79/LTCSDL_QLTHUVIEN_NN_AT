namespace HTQuanLyThuVien.Forms
{
    partial class FrmLogin
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
            this.label1 = new System.Windows.Forms.Label();
            this.pnlLogin = new System.Windows.Forms.Panel();
            this.lbTittle = new System.Windows.Forms.Label();
            this.lbSub = new System.Windows.Forms.Label();
            this.lbUser = new System.Windows.Forms.Label();
            this.lbPass = new System.Windows.Forms.Label();
            this.txtMatKhau = new System.Windows.Forms.TextBox();
            this.btnDangNhap = new System.Windows.Forms.Button();
            this.cboTaiKhoan = new System.Windows.Forms.ComboBox();
            this.btQuenMK = new System.Windows.Forms.Button();
            this.pnlLogin.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(295, 17);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(0, 16);
            this.label1.TabIndex = 0;
            // 
            // pnlLogin
            // 
            this.pnlLogin.BackColor = System.Drawing.Color.White;
            this.pnlLogin.Controls.Add(this.cboTaiKhoan);
            this.pnlLogin.Controls.Add(this.btQuenMK);
            this.pnlLogin.Controls.Add(this.btnDangNhap);
            this.pnlLogin.Controls.Add(this.txtMatKhau);
            this.pnlLogin.Controls.Add(this.lbPass);
            this.pnlLogin.Controls.Add(this.lbUser);
            this.pnlLogin.Controls.Add(this.lbSub);
            this.pnlLogin.Controls.Add(this.lbTittle);
            this.pnlLogin.Location = new System.Drawing.Point(153, 108);
            this.pnlLogin.Name = "pnlLogin";
            this.pnlLogin.Size = new System.Drawing.Size(589, 431);
            this.pnlLogin.TabIndex = 1;
            // 
            // lbTittle
            // 
            this.lbTittle.Font = new System.Drawing.Font("Segoe UI", 22.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbTittle.Location = new System.Drawing.Point(94, 20);
            this.lbTittle.Margin = new System.Windows.Forms.Padding(3, 35, 3, 0);
            this.lbTittle.Name = "lbTittle";
            this.lbTittle.Size = new System.Drawing.Size(409, 49);
            this.lbTittle.TabIndex = 0;
            this.lbTittle.Text = "Đăng nhập hệ thống";
            this.lbTittle.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lbSub
            // 
            this.lbSub.Font = new System.Drawing.Font("Segoe UI", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbSub.ForeColor = System.Drawing.SystemColors.ActiveBorder;
            this.lbSub.Location = new System.Drawing.Point(168, 80);
            this.lbSub.Name = "lbSub";
            this.lbSub.Size = new System.Drawing.Size(286, 23);
            this.lbSub.TabIndex = 1;
            this.lbSub.Text = "Tài khoản mẫu theo vai trò";
            this.lbSub.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.lbSub.Click += new System.EventHandler(this.lbSub_Click);
            // 
            // lbUser
            // 
            this.lbUser.AutoSize = true;
            this.lbUser.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbUser.Location = new System.Drawing.Point(50, 115);
            this.lbUser.Margin = new System.Windows.Forms.Padding(40, 145, 3, 0);
            this.lbUser.Name = "lbUser";
            this.lbUser.Size = new System.Drawing.Size(145, 25);
            this.lbUser.TabIndex = 2;
            this.lbUser.Text = "Tên đăng nhập";
            this.lbUser.Click += new System.EventHandler(this.lbUser_Click);
            // 
            // lbPass
            // 
            this.lbPass.AutoSize = true;
            this.lbPass.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbPass.Location = new System.Drawing.Point(50, 200);
            this.lbPass.Margin = new System.Windows.Forms.Padding(40, 145, 3, 0);
            this.lbPass.Name = "lbPass";
            this.lbPass.Size = new System.Drawing.Size(93, 25);
            this.lbPass.TabIndex = 2;
            this.lbPass.Text = "Mật khẩu";
            this.lbPass.Click += new System.EventHandler(this.lbUser_Click);
            // 
            // txtMatKhau
            // 
            this.txtMatKhau.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtMatKhau.Location = new System.Drawing.Point(55, 232);
            this.txtMatKhau.Margin = new System.Windows.Forms.Padding(40, 280, 3, 3);
            this.txtMatKhau.Name = "txtMatKhau";
            this.txtMatKhau.Size = new System.Drawing.Size(466, 34);
            this.txtMatKhau.TabIndex = 3;
            this.txtMatKhau.Text = "123456";
            this.txtMatKhau.UseSystemPasswordChar = true;
            // 
            // btnDangNhap
            // 
            this.btnDangNhap.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnDangNhap.FlatAppearance.BorderSize = 0;
            this.btnDangNhap.FlatAppearance.MouseDownBackColor = System.Drawing.Color.DodgerBlue;
            this.btnDangNhap.FlatAppearance.MouseOverBackColor = System.Drawing.Color.DodgerBlue;
            this.btnDangNhap.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnDangNhap.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnDangNhap.ForeColor = System.Drawing.Color.White;
            this.btnDangNhap.Location = new System.Drawing.Point(59, 285);
            this.btnDangNhap.Margin = new System.Windows.Forms.Padding(40, 360, 3, 3);
            this.btnDangNhap.Name = "btnDangNhap";
            this.btnDangNhap.Size = new System.Drawing.Size(216, 45);
            this.btnDangNhap.TabIndex = 4;
            this.btnDangNhap.Text = "Đăng nhập";
            this.btnDangNhap.UseVisualStyleBackColor = false;
            this.btnDangNhap.Click += new System.EventHandler(this.btnDangNhap_Click);
            // 
            // cboTaiKhoan
            // 
            this.cboTaiKhoan.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboTaiKhoan.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cboTaiKhoan.FormattingEnabled = true;
            this.cboTaiKhoan.Location = new System.Drawing.Point(55, 148);
            this.cboTaiKhoan.Margin = new System.Windows.Forms.Padding(40, 180, 3, 3);
            this.cboTaiKhoan.Name = "cboTaiKhoan";
            this.cboTaiKhoan.Size = new System.Drawing.Size(465, 37);
            this.cboTaiKhoan.TabIndex = 5;
            // 
            // btQuenMK
            // 
            this.btQuenMK.BackColor = System.Drawing.Color.LightSlateGray;
            this.btQuenMK.FlatAppearance.BorderSize = 0;
            this.btQuenMK.FlatAppearance.MouseDownBackColor = System.Drawing.Color.CornflowerBlue;
            this.btQuenMK.FlatAppearance.MouseOverBackColor = System.Drawing.Color.CornflowerBlue;
            this.btQuenMK.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btQuenMK.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btQuenMK.ForeColor = System.Drawing.Color.White;
            this.btQuenMK.Location = new System.Drawing.Point(305, 285);
            this.btQuenMK.Margin = new System.Windows.Forms.Padding(40, 360, 3, 3);
            this.btQuenMK.Name = "btQuenMK";
            this.btQuenMK.Size = new System.Drawing.Size(216, 45);
            this.btQuenMK.TabIndex = 4;
            this.btQuenMK.Text = "Quên Mật khẩu";
            this.btQuenMK.UseVisualStyleBackColor = false;
            this.btQuenMK.Click += new System.EventHandler(this.btnDangNhap_Click);
            // 
            // FrmLogin
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.MidnightBlue;
            this.ClientSize = new System.Drawing.Size(882, 653);
            this.Controls.Add(this.pnlLogin);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "FrmLogin";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Đăng Nhập";
            this.Load += new System.EventHandler(this.FrmLogin_Load);
            this.pnlLogin.ResumeLayout(false);
            this.pnlLogin.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Panel pnlLogin;
        private System.Windows.Forms.Label lbTittle;
        private System.Windows.Forms.Label lbSub;
        private System.Windows.Forms.Label lbUser;
        private System.Windows.Forms.Label lbPass;
        private System.Windows.Forms.TextBox txtMatKhau;
        private System.Windows.Forms.Button btnDangNhap;
        private System.Windows.Forms.ComboBox cboTaiKhoan;
        private System.Windows.Forms.Button btQuenMK;
    }
}