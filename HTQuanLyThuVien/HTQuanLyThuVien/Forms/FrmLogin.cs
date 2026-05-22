using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HTQuanLyThuVien.Forms
{
    public partial class FrmLogin : Form
    {
        public FrmLogin()
        {
            InitializeComponent();
        }

        private void lbSub_Click(object sender, EventArgs e)
        {

        }

        private void lbUser_Click(object sender, EventArgs e)
        {

        }

        private void FrmLogin_Load(object sender, EventArgs e)
        {
            cboTaiKhoan.Items.Add("admin01");
            cboTaiKhoan.Items.Add("tt001");
            cboTaiKhoan.Items.Add("docgia01");

            cboTaiKhoan.SelectedIndex = 0;
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {

        }
    }
}
