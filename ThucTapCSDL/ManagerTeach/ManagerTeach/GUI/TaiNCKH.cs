using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ManagerTeach.GUI
{
    public partial class TaiNCKH : Form
    {
        string id_gv;
        public TaiNCKH()
        {
            InitializeComponent();
        }
        public TaiNCKH(string id) : this()
        {
            dateTimePicker1.Value = DateTime.Today;
            id_gv = id;
            string query = "EXEC dbo. XuatThongTinGV '" + id + "'";
            DataBL data = new DataBL();
            DataTable info = data.getDataSet(query).Tables[0];
            lbl_nameTeach.Text = info.Rows[0]["TenGiaoVien"].ToString().Trim();
            lbl_NameDonVi.Text = info.Rows[0]["TenDonViChinhQuyen"].ToString().Trim();
            string time = dateTimePicker1.Value.Year.ToString();
            string query1 = "SELECT TenDeTai,TenLoaiHinhCon AS Loai, VaiTroTrongNghienCuu As Vaitro,SoThanhVien,SoGioChuan AS GioChuan,ThoiGianBatDau AS BatDau,ThoiGianKetThuc AS KetThuc FROM ThongKe_Detai('" + id + "')";
            tableDataNCKH.DataSource = data.getDataSet(query1).Tables[0];
            string query2 = "SELECT TenBaiBao,TenLoaiHinhCon AS Loai,VaiTroTrongBaiBao AS VaiTro,SoTacGia,SoGioChuan AS GioChuan,ThoiGianBatDau AS BatDau,ThoiGianKetThuc AS KetThuc FROM ThongKe_BaiBao('" + id + "')";
            tableDataBB.DataSource = data.getDataSet(query2).Tables[0];
            string query3 = "SELECT TenSach,TenLoaiHinhCon,VaiTroTrongBienSoan AS VaiTro,SoThanhVien,SoGioChuan AS GioChuan,ThoiGianBatDau AS BatDau,ThoiGianKetThuc AS KetThuc FROM ThongKe_BienSoanSach('" + id + "')";
            tableDataBSS.DataSource = data.getDataSet(query3).Tables[0];
        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {
            
            string query = "EXEC TK_GV_BB_TM @magiaovien = '"+ id_gv +"',@time = '"+dateTimePicker1.Value+"'";
            DataBL data = new DataBL();
            tableDataBB.DataSource = data.getDataSet(query).Tables[0];
            string query1 = "EXEC TK_GV_DT_TM @magiaovien = '" + id_gv + "',@time = '" + dateTimePicker1.Value + "'";
            tableDataNCKH.DataSource = data.getDataSet(query1).Tables[0];
            string query2 = "EXEC TK_GV_BSS_TM @magiaovien = '" + id_gv + "',@time = '" + dateTimePicker1.Value + "'";
            tableDataBSS.DataSource = data.getDataSet(query2).Tables[0];


        }

      
    }
}
