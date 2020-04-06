using ManagerTeach;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ManagerTeach.GUI
{
    public partial class TaiDT : Form
    {
        public TaiDT()
        {
            InitializeComponent();
        }
        public TaiDT(string id) : this()
        {
            dateTimePicker1.Value = DateTime.Today;
            string query = "EXEC dbo.XuatThongTinGV '" + id + "'";
            DataBL data = new DataBL();
            DataTable info = data.getDataSet(query).Tables[0];
            lbl_nameTeach.Text = info.Rows[0]["TenGiaoVien"].ToString().Trim();
            lbl_NameDonVi.Text = info.Rows[0]["TenDonViChinhQuyen"].ToString().Trim();

            string time = dateTimePicker1.Value.Year.ToString();

            time = (Int32.Parse(time) + 1).ToString();
            string query1 = "SELECT Tenchuongtrinhdaotao as Loaidaotao, TenHocPhan,SiSo , He, Lop, SoTC, SoTiet, GioChuan FROM GiangDay('" + id +"', '1900-1-1', '" + time+ "')";
            tableDataDT.DataSource = data.getDataSet(query1).Tables[0];
            string query2 = "select TenHocPhan as HocPhan , TenLop as Lop , SoBai, SoGio as GioChuan from TinhChamThi('" + id + "', '1900-1-1', '" + time + "')";
            tableDataBB.DataSource = data.getDataSet(query2).Tables[0];
            string query3 = "select TenLoaiHinh as LoaiHinh, TenHV as HocVien, TenLop as Lop,  TenHe as He, SoCanBoHD as SoCanBoHuongDan, GioChuan from  TinhHuongDan('" + id + "', '1900-1-1', '" + time + "')";
            tableDataBSS.DataSource = data.getDataSet(query3).Tables[0];
        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void bunifuCustomLabel2_Click(object sender, EventArgs e)
        {

        }
    }
}
