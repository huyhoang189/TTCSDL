using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ManagerTeach
{
    public partial class Form1 : Form
    {
       
        int WIDTH_PANEL_MENU_MAX = 234;
        int WIDTH_PANEL_MENU_MIN = 49;
        public Form1()
        {
            InitializeComponent();
            tbc_MainOfMnc.SizeMode = TabSizeMode.Fixed;
            tbc_MainOfMnc.Appearance = TabAppearance.FlatButtons;
            tbc_MainOfMnc.ItemSize = new Size(0, 1);
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            tbc_MainOfMnc.SelectedTab = tab6;
            showSide();
        }
        private void hideSide()
        {
            pn_Menu.Width = WIDTH_PANEL_MENU_MIN;
            pn_MenuChil.Visible = true;
        }
        private void showSide()
        {
            lbl_nam.Visible = false;
            bunifuDatepicker1.Visible = false;
            pn_MenuChil.Visible = false;
            comboBox1.Visible = false;
            pn_Menu.Width = WIDTH_PANEL_MENU_MAX;

        }
        private void actionSide()
        {
            if (pn_Menu.Width == WIDTH_PANEL_MENU_MIN) showSide();
            else hideSide();
        }

        private void btn_MenuDrop_Click(object sender, EventArgs e)
        {
            if (pn_Menu.Width == WIDTH_PANEL_MENU_MIN) showSide();
            else hideSide();
            tbc_MainOfMnc.SelectedTab = tab6;
            lbl_Status.Text = "Help";
        }

        private void btn_AnLM_Click(object sender, EventArgs e)
        {
            hideSide();
            tbc_MainOfMnc.SelectedTab = tab1;
            lbl_Status.Text = "Thống Kê Theo Khoa";
        }

        private void btn_Search_Click(object sender, EventArgs e)
        {
            hideSide();
            tbc_MainOfMnc.SelectedTab = tab2;
            lbl_Status.Text = "Tìm Kiếm";
        }

        private void btn_Syn_Click(object sender, EventArgs e)
        {
            showSide();
            string query = " SELECT MaGiaoVien AS ID,TenGiaoVien AS [Họ Và Tên] , NgaySinh as [Ngày Sinh],GioiTinh as[Giới Tính] ,QueQuan as [Quê Quán],DiaChi as[Địa Chỉ],SDT FROM dbo.GiaoVien";
            DataGridView.DataSource = getData(query).Tables[0];
        }
        public DataSet getData(string query)
        {
            DataBL data = new DataBL();
            return data.getDataSet(query);

        }
        private void bunifuFlatButton4_Click(object sender, EventArgs e)
        {
            hideSide();
            tbc_MainOfMnc.SelectedTab = tab6;
            lbl_Status.Text = "Help";
        }

        private void tbc_MainOfMnc_SelectedIndexChanged(object sender, EventArgs e)
        {
            lbl_nam.Visible = false;
            bunifuDatepicker1.Visible = false;
            comboBox1.Visible = false;
        }

        private void btn_findBSS_Click(object sender, EventArgs e)
        {
            string query = " SELECT * FROM dbo.BienSoanSach";
            DataGridView.DataSource = getData(query).Tables[0];
        }

        private void btn_findBB_Click(object sender, EventArgs e)
        {
            string query = "EXEC ShowBaiBao";
            DataGridView.DataSource = getData(query).Tables[0];
        }

        private void btn_findDTNC_Click(object sender, EventArgs e)
        {
            string query = " SELECT TenDeTai,SoLuongThanhVien,TenLoaiHinhCon,DonViTinh,GioChuan FROM dbo.DeTaiNghienCuu,dbo.LoaiHinhConNCKH "
                              + "WHERE DeTaiNghienCuu.MaLoaiHinhCon = LoaiHinhConNCKH.MaLoaiHinhCon";
            DataGridView.DataSource = getData(query).Tables[0];
        }

        private void btn_TKTaiNCKH_Click(object sender, EventArgs e)
        {
            lbl_nam.Visible = true;
            bunifuDatepicker1.Visible = true;
            comboBox1.Visible = true;
            string query = "SELECT TenKhoa AS [Tên Khoa],SUM(ThucTai) AS [Thực Tải] ,SUM(TaiYeuCau) AS [Yêu Cầu],SUM(NCKH) AS [%NCKH] FROM dbo. ShowNCKH('" + bunifuDatepicker1.Value.Year
                           + "')GROUP BY TenKhoa";
            DataGridView.DataSource = getData(query).Tables[0];
            lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
        }

        private void DataGridView_MouseClick(object sender, MouseEventArgs e)
        {
            if (pn_Menu.Width == WIDTH_PANEL_MENU_MAX)
            {
                if (e.Button == MouseButtons.Right)
                {

                    ContextMenu cm = new ContextMenu();

                    ContextMenu cmHeader = new ContextMenu();
                    int currentMouseOverRow = DataGridView.HitTest(e.X, e.Y).RowIndex;
                    int currentMouseOverCol = DataGridView.HitTest(e.X, e.Y).ColumnIndex;

                    if (currentMouseOverRow >= 0)
                    {
                        if (DataGridView.Rows[currentMouseOverRow].Selected == true)
                        {
                            MenuItem itemTaiNCKH = new MenuItem();
                            itemTaiNCKH.Text = "Tải nghiên cứu khoa học";
                            MenuItem itemTaiDT = new MenuItem();
                            itemTaiDT.Text = "Tải đào tạo";
                            MenuItem itemTongtai = new MenuItem();
                            itemTongtai.Text = "Thông Tin ";

                            cm.MenuItems.Add(itemTaiNCKH);
                            cm.MenuItems.Add(itemTaiDT);
                            cm.MenuItems.Add(itemTongtai);
                            itemTaiNCKH.Click += showItemNCKH;
                            itemTaiDT.Click += showItemTaiDaoTao;
                            cm.Show(DataGridView, new Point(e.X, e.Y));

                        }
                    }

                }
            }
            if(btn_Search.selected == true && btn_findBB.selected == true)
            {
                if (e.Button == MouseButtons.Right)
                {

                    ContextMenu cm = new ContextMenu();

                    ContextMenu cmHeader = new ContextMenu();
                    int currentMouseOverRow = DataGridView.HitTest(e.X, e.Y).RowIndex;
                    int currentMouseOverCol = DataGridView.HitTest(e.X, e.Y).ColumnIndex;

                    if (currentMouseOverRow >= 0)
                    {
                        if (DataGridView.Rows[currentMouseOverRow].Selected == true)
                        {
                            MenuItem itemMember = new MenuItem();
                            itemMember.Text = "Thành Viên";
                            cm.MenuItems.Add(itemMember);
                            itemMember.Click += showItemMemBer;
                            cm.Show(DataGridView, new Point(e.X, e.Y));

                        }
                    }

                }
            }
        }

        private void showItemNCKH(object sender, EventArgs e)
        {
            int pos = DataGridView.SelectedRows[0].Index;
            DataGridViewRow temp = this.DataGridView.Rows[pos];
            string id = temp.Cells[0].Value.ToString().Trim();
            GUI.TaiNCKH tai = new GUI.TaiNCKH(id);
            tai.ShowDialog();
        }
        private void showItemMemBer(object sender, EventArgs e)
        {
            int pos = DataGridView.SelectedRows[0].Index;
            DataGridViewRow temp = this.DataGridView.Rows[pos];
            string id = temp.Cells[0].Value.ToString().Trim();
            GUI.frMember mem = new GUI.frMember(id, 1);
            mem.ShowDialog();
        }
        private void showItemTaiDaoTao(object sender, EventArgs e)
        {
            int pos = DataGridView.SelectedRows[0].Index;
            DataGridViewRow temp = this.DataGridView.Rows[pos];
            string id = temp.Cells[0].Value.ToString().Trim();
            GUI.TaiDT a = new GUI.TaiDT(id);
            a.ShowDialog();
        }
        private void btn_ANL_GiaoVien_Click_1(object sender, EventArgs e)
        {
            hideSide();
            tbc_MainOfMnc.SelectedTab = tab3;
            lbl_Status.Text = "Thống Kê Giáo Viên";
        }

        private void bunifuDatepicker1_onValueChanged(object sender, EventArgs e)
        {
            if (btn_AnLM.selected == true && btn_TKTaiNCKH.selected == true)
            {
                string query = "SELECT TenKhoa AS [Tên Khoa],SUM(ThucTai) AS [Thực Tải] ,SUM(TaiYeuCau) AS [Yêu Cầu],SUM(NCKH) AS [%NCKH] FROM dbo. ShowNCKH('" + bunifuDatepicker1.Value.Year
                          + "')GROUP BY TenKhoa";
                DataGridView.DataSource = getData(query).Tables[0];
                lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
            }
            if(btn_ANL_GiaoVien.selected == true && btn_GV_TaiNCKH.selected == true)
            {
                string query = "SELECT TenKhoa AS [Tên Khoa],TenGiaoVien as [Tên Giáo Viên],ThucTai AS [Thực Tải] ,TaiYeuCau AS [Yêu Cầu],NCKH AS [%NCKH] FROM dbo. ShowNCKH('" + bunifuDatepicker1.Value.Year
                           + "')";
                DataGridView.DataSource = getData(query).Tables[0];
                lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
            }
            if(btn_ANL_GiaoVien.selected == true && btn_GV_Tongtai.selected == true)
            {
                string query = "SELECT * FROM dbo.TongTai('" + bunifuDatepicker1.Value.Year
                       + "')";
                DataGridView.DataSource = getData(query).Tables[0];
                lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
            }
            if (btn_ANL_GiaoVien.selected == true && btn_GV_TaiDaoTao.selected == true)
            {
                string query = "select * from ThongKeGiaoVienDaoTao('" + bunifuDatepicker1.Value.Year
                       + "')";
                DataGridView.DataSource = getData(query).Tables[0];
                lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
            }
            if (btn_AnLM.selected == true && btn_TKNhanLuc.selected == true)
            {
                string query = "exec TongKeNhanLuc '" + bunifuDatepicker1.Value.Year
                       + "'";
                DataGridView.DataSource = getData(query).Tables[0];
                lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
            }
            if (btn_AnLM.selected == true && btn_TKTaiDaoTao.selected == true)
            {
                string query = "select TenKhoa, SUM(ThucTai) AS ThucTai, SUM(YeuCau) AS YeuCau, SUM(Phantramdatduoc)/ COUNT(TenKhoa) AS[% Tong]FROM ThongKeGiaoVienDaoTao('" + bunifuDatepicker1.Value.Year
                       + "') GROUP BY TenKhoa";
                DataGridView.DataSource = getData(query).Tables[0];
                lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
            }
        }

        private void tbc_MainOfMnc_TabIndexChanged(object sender, EventArgs e)
        {
            lbl_nam.Visible = false;
            bunifuDatepicker1.Visible = false;
            comboBox1.Visible = false;
        }
        private void bunifuFlatButton5_Click(object sender, EventArgs e)
        {
            lbl_nam.Visible = true;
            bunifuDatepicker1.Visible = true;
            comboBox1.Visible = true;
            string query = "SELECT TenKhoa AS [Tên Khoa],TenGiaoVien as [Tên Giáo Viên],ThucTai AS [Thực Tải] ,TaiYeuCau AS [Yêu Cầu],NCKH AS [%NCKH] FROM dbo. ShowNCKH('" + bunifuDatepicker1.Value.Year
                           + "')";
            DataGridView.DataSource = getData(query).Tables[0];
            lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
        }

        private void btn_GV_TaiDaoTao_Click(object sender, EventArgs e)
        {
            lbl_nam.Visible = true;
            bunifuDatepicker1.Visible = true;
            comboBox1.Visible = true;
            string query = "select * from ThongKeGiaoVienDaoTao('" + bunifuDatepicker1.Value.Year
                        + "')";
            DataGridView.DataSource = getData(query).Tables[0];
            lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
        }

        private void btn_GV_Tongtai_Click(object sender, EventArgs e)
        {
            lbl_nam.Visible = true;
            bunifuDatepicker1.Visible = true;
            comboBox1.Visible = true;
            string query = "SELECT * FROM dbo.TongTai('" + bunifuDatepicker1.Value.Year
                        + "')";
            DataGridView.DataSource = getData(query).Tables[0];
            lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
        }

        private void btn_TKNhanLuc_Click(object sender, EventArgs e)
        {
            lbl_nam.Visible = true;
            bunifuDatepicker1.Visible = true;
            comboBox1.Visible = true;
            string query = "exec TongKeNhanLuc '" + bunifuDatepicker1.Value.Year
                        + "'";
            DataGridView.DataSource = getData(query).Tables[0];
            lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;
        }

        private void btn_TKTaiDaoTao_Click(object sender, EventArgs e)
        {
            lbl_nam.Visible = true;
            bunifuDatepicker1.Visible = true;
            comboBox1.Visible = true;
            string query = "select TenKhoa, SUM(ThucTai) AS ThucTai, SUM(YeuCau) AS YeuCau, SUM(Phantramdatduoc)/ COUNT(TenKhoa) AS[% Tong]FROM ThongKeGiaoVienDaoTao('" + bunifuDatepicker1.Value.Year
                        + "') GROUP BY TenKhoa";
            DataGridView.DataSource = getData(query).Tables[0];
            lbl_nam.Text = "Thống kê theo năm " + bunifuDatepicker1.Value.Year;

        }
    }
}
