--CREATE DATABASE QUAN_LY_GIAO_VIEN
--USE QUAN_LY_GIAO_VIEN
DROP DATABASE QUAN_LY_GIAO_VIEN
GO
CREATE TABLE GiaoVien(
	MaGiaoVien CHAR(20) PRIMARY KEY,
	TenGiaoVien NVARCHAR(200),
	NgaySinh DATE,
	GioiTinh NVARCHAR(20),
	QueQuan NVARCHAR(200),
	DiaChi NVARCHAR(200),
	SDT CHAR(20)
)
GO
CREATE TABLE ChinhQuyen(
	MaChinhQuyen CHAR(20) PRIMARY KEY,
	MaChucVuChinhQuyen CHAR(20),
	MaDonViChinhQuyen CHAR(20)
)
GO
CREATE TABLE Dang(
	MaDang CHAR(20) PRIMARY KEY,
	MaDonViDang CHAR(20),
	MaChucVuDang CHAR(20)
)
GO
CREATE TABLE DonViChinhQuyen(
	MaDonViChinhQuyen CHAR(20) PRIMARY KEY,
	TenDonViChinhQuyen NVARCHAR(200)
)
GO
CREATE TABLE ChucVuChinhQuyen(
	MaChucVuChinhQuyen CHAR(20) PRIMARY KEY,
	TenChucVuChinhQuyen NVARCHAR(50),
	MaDinhMucMienGiam CHAR(20)
)
GO
CREATE TABLE DonViDang(
	MaDonViDang CHAR(20) PRIMARY KEY,
	TenDonViDang NVARCHAR(200)
)
GO
CREATE TABLE ChucVuDang(
	MaChucVuDang CHAR(20) PRIMARY KEY,
	TenChucVuDang NVARCHAR(50),
	MaDinhMucMienGiam CHAR(20)
)
GO
CREATE TABLE GiaoVien_ChinhQuyen(
	MaGiaoVien CHAR(20),
	MaChinhQuyen CHAR(20),
	ThoiGianNhan DATE
)
GO
CREATE TABLE GiaoVien_Dang(
	MaGiaoVien CHAR(20),
	MaDang CHAR(20),
	ThoiGianNhan DATE
)
GO
CREATE TABLE HocVi(
	MaHocVi CHAR(20)PRIMARY KEY,
	TenHocVi NVARCHAR(200)
)
GO
CREATE TABLE GiaoVien_HocVi(
	MaGiaoVien CHAR(20),
	MaHocVi CHAR(20),
	ThoiGianNhan DATE
)
GO
CREATE TABLE HocHam(
	MaHocHam CHAR(20)PRIMARY KEY,
	TenHocHam NVARCHAR(200),
	MaDinhMucChucDanh CHAR(20)
)
GO
CREATE TABLE GiaoVien_HocHam(
	MaGiaoVien CHAR(20),
	MaHocHam CHAR(20),
	ThoiGianNhan DATE
)
GO
CREATE TABLE ChucDanh(
	MaChucDanh CHAR(20)PRIMARY KEY,
	TenChucDanh NVARCHAR(200),
	MaDinhMucChucDanh CHAR(20)
)
GO
CREATE TABLE GiaoVien_ChucDanh(
	MaGiaoVien CHAR(20),
	MaChucDanh CHAR(20),
	ThoiGianNhanBatDau DATE,
	ThoiGianNhanKetThuc DATE
)
GO
CREATE TABLE NgoaiNgu(
	MaNgoaiNgu CHAR(20)PRIMARY KEY,
	TenNgoaiNgu NVARCHAR(200)
)
GO
CREATE TABLE GiaoVien_NgoaiNgu(
	MaGiaoVien CHAR(20),
	MaNgoaiNgu CHAR(20),
	ThoiGianNhan DATE,
	TrinhDo CHAR(20)
)
GO
CREATE TABLE HuongNghienCuu(
	MaHuongNghienCuu CHAR(20) PRIMARY KEY,
	TenHuongNghienCuu NVARCHAR(200)
)
GO
CREATE TABLE GiaoVien_HuongNghienCuu(
	MaGiaoVien CHAR(20),
	MaHuongNghienCuu CHAR(20),
	ThoiGianBatDau DATE,
	ThoiGianKetThuc DATE
)
GO
CREATE TABLE KhenThuongKyLuat(
	MaKhenThuongKyLuat CHAR(20)PRIMARY KEY,
	TenKhenThuongKyLuat NVARCHAR(200),
	Loai NVARCHAR(200)
)
GO
CREATE TABLE GiaoVien_KhenThuongKyLuat(
	MaGiaoVien CHAR(20),
	MaKhenThuongKyLuat CHAR(20),
	TenKhenThuongKyLuatNhan NVARCHAR(200),
	ThoiGianNhan DATE
)
GO
CREATE TABLE QuaTrinhDaoTao(
	MaGiaoVien CHAR(20),
	MaQuaTrinhDaoTao CHAR(20) PRIMARY KEY
)
GO
CREATE TABLE DaoTaoDaiHoc(
	MaDaoTaoDaiHoc CHAR(20)PRIMARY KEY,
	HeDaoTao NVARCHAR(200),
	NoiDaoTao NVARCHAR(200),
	NuocDaoTao NVARCHAR(200),
	NganhDaoTao NVARCHAR(200),
	ThoiGianDaoTao CHAR(10)
)
GO
CREATE TABLE DaoTaoSauDaiHoc(
	MaDaoTaoSauDaiHoc CHAR(20)PRIMARY KEY,
	LoaiDaoTao NVARCHAR(200),
	NoiDaoTao NVARCHAR(200),
	ThoiGianDaoTao CHAR(10)
)
GO
CREATE TABLE DaoTaoKhac(
	MaDaoTaoKhac CHAR(20),
	MaDaoTaoSauDaiHoc CHAR(20),
	GhiChu NVARCHAR(200)
)
GO
CREATE TABLE QuaTrinhDaoTao_DaoTaoDaiHoc(
	MaQuaTrinhDaoTao CHAR(20),
	MaDaoTaoDaiHoc CHAR(20),
	NamTotNghiep DATE
)
GO
CREATE TABLE QuaTrinhDaoTao_DaoTaoSauDaiHoc(
	MaQuaTrinhDaoTao CHAR(20),
	MaDaoTaoSauDaiHoc CHAR(20),
	NamTotNghiep DATE,
	TenDeAnTotNghiep NVARCHAR(200)
)
GO

CREATE TABLE DinhMucChucDanh(
	MaDinhMucChucDanh CHAR(20)PRIMARY KEY,
	TenChucDanh NVARCHAR(100),
	GioQuyDinhChungGiangDay INT,
	GioMonTheChatGiaoDucQuocPhong INT,
	ThoiGianNghienCuu INT,
	ThoiGianChuanNghienCuu INT,
	
)
GO

CREATE TABLE DinhMucMienGiamChucVu(
	MaDinhMucMienGiam CHAR(20)PRIMARY KEY,
	TyLeMienGiamThap INT,
	TyLeMienGiamCao INT,
	Loai INT,--0 is chinh quyen --1 is Dang -- 2 --LOAI KHAC
	TenChucVu NVARCHAR(100)
)
GO

CREATE TABLE DinhMucGiamDacBiet(
	MaDinhMucGiamDacBiet CHAR(20)PRIMARY KEY,
	TenDinhMucGiam NVARCHAR(200),
	TyLeGiam INT
)
GO


CREATE TABLE GiaoVien_GiamDacBiet
(
    MaGiaoVien CHAR(20),
	MaDinhMucGiamDacBiet CHAR(20),
	ThoiGianMienGiam DATE,

	PRIMARY KEY (MaGiaoVien,MaDinhMucGiamDacBiet)
)




ALTER TABLE dbo.ChinhQuyen ADD CONSTRAINT FK_cq_cvcq FOREIGN KEY(MaChucVuChinhQuyen) REFERENCES dbo.ChucVuChinhQuyen(MaChucVuChinhQuyen)
ALTER TABLE dbo.ChinhQuyen ADD CONSTRAINT FK_cq_dvcq FOREIGN KEY(MaDonViChinhQuyen) REFERENCES dbo.DonViChinhQuyen(MaDonViChinhQuyen)
ALTER TABLE dbo.Dang ADD CONSTRAINT FK_d_cvd FOREIGN KEY (MaChucVuDang) REFERENCES dbo.ChucVuDang(MaChucVuDang)
ALTER TABLE dbo.Dang ADD CONSTRAINT FK_d_dvd FOREIGN KEY (MaDonViDang) REFERENCES dbo.DonViDang(MaDonViDang)
ALTER TABLE dbo.GiaoVien_ChinhQuyen ADD CONSTRAINT FK_gvcq_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_ChinhQuyen ADD CONSTRAINT FK_gvcq_cq FOREIGN KEY(MaChinhQuyen) REFERENCES dbo.ChinhQuyen(MaChinhQuyen)
ALTER TABLE dbo.GiaoVien_Dang ADD CONSTRAINT FK_gvd_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_Dang ADD CONSTRAINT FK_gvd_d FOREIGN KEY(MaDang) REFERENCES dbo.Dang(MaDang)
ALTER TABLE dbo.GiaoVien_HocVi ADD CONSTRAINT FK_gvhv_gv FOREIGN KEY(MaGiaoVien)REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_HocVi ADD CONSTRAINT FK_gvhv_hvi FOREIGN KEY (MaHocVi) REFERENCES dbo.HocVi(MaHocVi)
ALTER TABLE dbo.GiaoVien_HocHam ADD CONSTRAINT FK_gvhh_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_HocHam ADD CONSTRAINT FK_gvhh_hh FOREIGN KEY (MaHocHam) REFERENCES dbo.HocHam(MaHocHam)
ALTER TABLE dbo.GiaoVien_ChucDanh ADD CONSTRAINT FK_gvcd_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_ChucDanh ADD CONSTRAINT FK_gvcd_cd FOREIGN KEY(MaChucDanh) REFERENCES dbo.ChucDanh(MaChucDanh)
ALTER TABLE dbo.GiaoVien_NgoaiNgu ADD CONSTRAINT FK_gvnn_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_NgoaiNgu ADD CONSTRAINT FK_gvnn_nn FOREIGN KEY(MaNgoaiNgu) REFERENCES dbo.NgoaiNgu(MaNgoaiNgu)
ALTER TABLE dbo.GiaoVien_HuongNghienCuu ADD CONSTRAINT FK_gvhnc_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_HuongNghienCuu ADD CONSTRAINT FK_gvhnc_hnc FOREIGN KEY(MaHuongNghienCuu) REFERENCES dbo.HuongNghienCuu(MaHuongNghienCuu)
ALTER TABLE dbo.GiaoVien_KhenThuongKyLuat ADD CONSTRAINT FK_gvktkl_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_KhenThuongKyLuat ADD CONSTRAINT FK_gvktkl_ktkl FOREIGN KEY(MaKhenThuongKyLuat) REFERENCES dbo.KhenThuongKyLuat(MaKhenThuongKyLuat)
ALTER TABLE dbo.QuaTrinhDaoTao ADD CONSTRAINT FK_qtdt_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.DaoTaoKhac ADD CONSTRAINT FK_dtk_dtsdh FOREIGN KEY(MaDaoTaoSauDaiHoc) REFERENCES dbo.DaoTaoSauDaiHoc(MaDaoTaoSauDaiHoc)
ALTER TABLE dbo.QuaTrinhDaoTao_DaoTaoDaiHoc ADD CONSTRAINT FK_qtdtdtdh_qtdt FOREIGN KEY(MaQuaTrinhDaoTao) REFERENCES dbo.QuaTrinhDaoTao(MaQuaTrinhDaoTao)
ALTER TABLE dbo.QuaTrinhDaoTao_DaoTaoDaiHoc ADD CONSTRAINT FK_qtdtdtdh_dtdh FOREIGN KEY(MaDaoTaoDaiHoc) REFERENCES dbo.DaoTaoDaiHoc(MaDaoTaoDaiHoc)
ALTER TABLE dbo.QuaTrinhDaoTao_DaoTaoSauDaiHoc ADD CONSTRAINT FK_qddtdtsdh_qtdt FOREIGN KEY(MaQuaTrinhDaoTao) REFERENCES dbo.QuaTrinhDaoTao(MaQuaTrinhDaoTao)
ALTER TABLE dbo.QuaTrinhDaoTao_DaoTaoSauDaiHoc ADD CONSTRAINT FK_qtdtdtdh_dtsdh FOREIGN KEY(MaDaoTaoSauDaiHoc) REFERENCES dbo.DaoTaoSauDaiHoc(MaDaoTaoSauDaiHoc)
ALTER TABLE dbo.ChucDanh ADD CONSTRAINT FK_cd_dmcd FOREIGN KEY(MaDinhMucChucDanh) REFERENCES dbo.DinhMucChucDanh(MaDinhMucChucDanh)
ALTER TABLE dbo.HocHam ADD CONSTRAINT FK_hh_dmcd FOREIGN KEY(MaDinhMucChucDanh) REFERENCES dbo.DinhMucChucDanh(MaDinhMucChucDanh)
ALTER TABLE dbo.ChucVuChinhQuyen ADD CONSTRAINT FK_cvcq_dmcv FOREIGN KEY(MaDinhMucMienGiam) REFERENCES dbo.DinhMucMienGiamChucVu(MaDinhMucMienGiam)
ALTER TABLE dbo.ChucVuDang ADD CONSTRAINT FK_cvd_dmcv FOREIGN KEY(MaDinhMucMienGiam) REFERENCES dbo.DinhMucMienGiamChucVu(MaDinhMucMienGiam)
ALTER TABLE dbo.GiaoVien_GiamDacBiet ADD CONSTRAINT FK_gv_gdb_mgdb FOREIGN KEY(MaDinhMucGiamDacBiet) REFERENCES dbo.DinhMucGiamDacBiet(MaDinhMucGiamDacBiet)
ALTER TABLE dbo.GiaoVien_GiamDacBiet ADD CONSTRAINT FK_gv_gdb_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)



--------------------------------------------------------------------------------------------------------------------------------


create table HocVien(
MaHocVien char(20) primary key,
TenHocVien nvarchar(200)
)
create table He(
MaHe char(20) primary key,
TenHe nvarchar(200)
)

create table Khoa(
MaKhoa char(20) primary key,
TenKhoa nvarchar(200)
)


create table Lop(
MaLop char(20) primary key,
TenLop nvarchar(200),
SiSo int,
MaHe char(20), 
)


create table BoMon(
MaBoMon char(20) primary key,
TenBoMon nvarchar(200),
MaKhoa char(20), 
)


create table HocPhan(
MaHocPhan char(20) primary key,
TenHocPhan nvarchar(200),
SoTinChi int,
SoTiet int,
MaBoMon char(20), 
)




create table CacLoaiHinhDaoTao(
MaLoaiHinhDaoTao char(20) primary key,
TenLoaiHinhDaoTao nvarchar(200)
)

create table QuyDoiLoaiHinh(
MaLoaiHinhCon char(20) primary key,
TenLoaiHinhCon nvarchar(200),
MaLoaiHinhDaoTao char(20), 
)

create table DieuKienLoaiHinh(
DieuKienLoaiHinh char(20) primary key,
DieuKien nvarchar(200),
DonViTinh nvarchar(200),
QuyRaGioChuan float,
MaLoaiHinhCon char(20), 
)



create table LopHoc(
MaLopHoc char(20) ,
TenLopHoc nvarchar(200),
CSN_CN bit,
HocKy nvarchar(200),
MaLop char(20), 
MaHocPhan char(20), 
MaQuyDoi char(20) NULL, 
primary key (MaLopHoc)
)

ALTER TABLE LopHoc
ADD CONSTRAINT FK_DieuKienLopHoc
FOREIGN KEY (MaQuyDoi) REFERENCES DieuKienLoaiHinh(DieuKienLoaiHinh);
ALTER TABLE LopHoc
ADD CONSTRAINT FK_LopLopHoc
FOREIGN KEY (MaLop) REFERENCES Lop(MaLop);

ALTER TABLE LopHoc
ADD CONSTRAINT FK_HocPhanLopHoc
FOREIGN KEY (MaHocPhan) REFERENCES HocPhan(MaHocPhan);

create table HocPhanChamThi(
MaHocPhanChamThi char(20),
SoBai int,
MaLopHoc char(20) NULL, 
MaQuyDoi char(20) NULL, 
GhiChu nvarchar(200) NULL,
primary key (MaHocPhanChamThi)
)




ALTER TABLE HocPhanChamThi
ADD CONSTRAINT FK_LopHocHocPhanChamThi
FOREIGN KEY (MaLopHoc) REFERENCES LopHoc(MaLopHoc);
ALTER TABLE HocPhanChamThi
ADD CONSTRAINT FK_DieuKienHocPhanChamThi
FOREIGN KEY (MaQuyDoi) REFERENCES DieuKienLoaiHinh(DieuKienLoaiHinh);


create table HuongDan(
MaHuongDan char(20) ,
TenDeTai_ChuDe nvarchar(200),
SoCanBoHuongDan int,
ThoiGianBatDau datetime,
ThoiGianKetThuc datetime,
MaHocVien char(20), 
MaQuyDoi char(20) NULL, 
primary key (MaHuongDan)
)



ALTER TABLE HuongDan
ADD CONSTRAINT FK_HocVienHuongDan
FOREIGN KEY (MaHocVien) REFERENCES HocVien(MaHocVien);
ALTER TABLE HuongDan
ADD CONSTRAINT FK_DieuKienHuongDan
FOREIGN KEY (MaQuyDoi) REFERENCES DieuKienLoaiHinh(DieuKienLoaiHinh);





create table GiaoVien_LopHoc(
GiaoVien_LopHoc char(20) primary key,
MaGiaoVien char(20) ,
MaLopHoc  char(20),
ThoiGianBatDau datetime,
ThoiGianKetThuc datetime,
)




create table GiaoVien_HocPhanChamThi(
GiaoVien_HocPhanChamThi char(20) primary key,
MaGiaoVien char(20) ,
MaHocPhanChamThi  char(20),
ThoiGianBatDau datetime,
ThoiGianKetThuc datetime,
)


create table GiaoVien_HuongDan(
GiaoVien_HuongDan char(20) primary key,
MaGiaoVien char(20) ,
MaHuongDan  char(20),
ThoiGianBatDau datetime,
ThoiGianKetThuc datetime,
)



ALTER TABLE BoMon
ADD CONSTRAINT FK_KhoaBoMon
FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa);

ALTER TABLE HocPhan
ADD CONSTRAINT FK_BoMonHocPhan
FOREIGN KEY (MaBoMon) REFERENCES BoMon(MaBoMon);

ALTER TABLE QuyDoiLoaiHinh
ADD CONSTRAINT FK_LoaiHinhDaoTao_QuyDoiLoaiHinh
FOREIGN KEY (MaLoaiHinhDaoTao) REFERENCES CacLoaiHinhDaoTao(MaLoaiHinhDaoTao);

ALTER TABLE DieuKienLoaiHinh
ADD CONSTRAINT FK_QuyDoiLoaiHinh_DieuKienLoaiHinh
FOREIGN KEY (MaLoaiHinhCon) REFERENCES QuyDoiLoaiHinh(MaLoaiHinhCon);



ALTER TABLE GiaoVien_LopHoc
ADD CONSTRAINT FK_GiaoVien_LopHoc
FOREIGN KEY (MaGiaoVien) REFERENCES GiaoVien(MaGiaoVien);
ALTER TABLE GiaoVien_LopHoc
ADD CONSTRAINT FK_LopHoc_GiaoVien
FOREIGN KEY (MaLopHoc) REFERENCES LopHoc(MaLopHoc);



ALTER TABLE GiaoVien_HocPhanChamThi
ADD CONSTRAINT FK_GiaoVien_GiaoVienHocPhanChamThi
FOREIGN KEY (MaGiaoVien) REFERENCES GiaoVien(MaGiaoVien);

ALTER TABLE GiaoVien_HocPhanChamThi
ADD CONSTRAINT FK_GiaoVienHocPhanChamThi_GiaoVien
FOREIGN KEY (MaHocPhanChamThi) REFERENCES HocPhanChamThi(MaHocPhanChamThi);



ALTER TABLE GiaoVien_HuongDan
ADD CONSTRAINT FK_GiaoVien_HuongDan
FOREIGN KEY (MaGiaoVien) REFERENCES GiaoVien(MaGiaoVien);

ALTER TABLE dbo.GiaoVien_HuongDan
ADD CONSTRAINT FK_HuongDan_GiaoVien
FOREIGN KEY (MaHuongDan) REFERENCES HuongDan(MaHuongDan);





ALTER TABLE Lop
ADD CONSTRAINT FK_HeLop
FOREIGN KEY (MaHe) REFERENCES He(MaHe);




-----------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE BaiBao(
  MaBaiBao CHAR(20),
  MaLoaiHinhCon CHAR(20),
  TenBaiBao NVARCHAR(200),
  SoLuongTacGia INT,
  ThoiGian DATE
  PRIMARY KEY(MaBaiBao)
)
GO

CREATE TABLE DeTaiNghienCuu(
  MaDeTai CHAR(20),
  TenDeTai NVARCHAR(200),
  SoLuongThanhVien INT,
  MaLoaiHinhCon CHAR(20)
  PRIMARY KEY (MaDeTai)
)
GO

CREATE TABLE BienSoanSach(
  MaSach CHAR(20),
  TenSach NVARCHAR(200),
  NoiXuatBan NVARCHAR(200),
  SoLuongThanhVien INT,
  ThoiGianXuatBan DATE,
  SoTrang INT,
  DonViHocTrinh INT,
  MaLoaiHinhCon CHAR(20)
  PRIMARY KEY (MaSach)
)
GO

CREATE TABLE GiaoVien_BaiBao(
  MaGiaoVien CHAR(20),
  MaBaiBao CHAR(20),
  ThoiGianBatDau DATE,
  ThoiGianHoanThanh DATE,
  VaiTroTrongBaiBao INT
)
GO
DROP TABLE GiaoVien_NghienCuuKhoaHoc
CREATE TABLE GiaoVien_NghienCuuKhoaHoc(
  MaGiaoVien CHAR(20),
  MaDeTai CHAR(20),
  ThoiGianBatDau DATE,
  ThoiGianHoanThanh DATE,
  VaiTroTrongNghienCuu INT

)
GO
DROP TABLE dbo.GiaoVien_BienSoanSach
CREATE TABLE GiaoVien_BienSoanSach(
  MaGiaoVien CHAR(20),
  MaSach CHAR(20),
  ThoiGianBatDau DATE,
  ThoiGianKetThuc DATE,
  VaiTroTrongBienSoan INT,
  SoTrangViet INT

)
GO

CREATE TABLE LoaiHinhChinhNCKH(
  MaLoaiHinhChinh CHAR(20),
  TenLoaiHinhChinh NVARCHAR(100)
  PRIMARY KEY(MaLoaiHinhChinh)
)
GO

CREATE TABLE LoaiHinhConNCKH(
  MaLoaiHinhCon CHAR(20) PRIMARY KEY,
  TenLoaiHinhCon NVARCHAR(200),
  DonViTinh NVARCHAR(50),
  GioChuan INT ,
  MaLoaiHinhChinh CHAR(20),
  TyLeChinh INT
)
GO
DROP TABLE dbo.LoaiHinhConNCKH
CREATE TABLE DuAn(
  MaDuAn CHAR(20) PRIMARY KEY,
  TenDuAn NVARCHAR(200),
  MoTa NVARCHAR(200),
  MaCoQuanQuanLy CHAR(20),
  TinhTrang INT -- 1 or 0

)
GO

CREATE TABLE GiaoVien_DuAn(
  MaGiaoVien CHAR(20),
  MaDuAn CHAR(20),
  ThoiGianBatDau DATE,
  ThoiGianHoanThanh DATE,
  VaiTroTrongDuAn INT -- 1 or 0
)
GO

CREATE TABLE GiaiThuong(
  MaGiaiThuong CHAR(20) PRIMARY KEY,
  TenGiaiThuong NVARCHAR(200),
  PhamVi NVARCHAR(200),
  NoiCap NVARCHAR(200),
  ToChucTraoThuong NVARCHAR(200)
)
GO

CREATE TABLE DuAn_GiaiThuong(
  MaDuAn CHAR(20),
  MaGiaiThuong CHAR(20),
  ThoiGianNhan DATE
)
GO

CREATE TABLE DangKiBangSoHuu(
  MaBangSangChe CHAR(20) PRIMARY KEY,
  SoHieu CHAR(20),
  ThoiGianCap DATE,
  PhamVi NVARCHAR(200),
  NoiCap NVARCHAR(200),
  MaDuAn CHAR(20)
)
GO
CREATE TABLE ApDungThucTien(
  MaApDungThucTien CHAR(20) PRIMARY KEY,
  HieuQuaThucTien NVARCHAR(200),
  DiaChiApDung NVARCHAR(200),
  QuyMoApDung NVARCHAR(200),
  HinhThucApDung NVARCHAR(200),
  ThoiGianApDung DATE,
  MaDuAn CHAR(20)
)

ALTER TABLE dbo.GiaoVien_BaiBao ADD CONSTRAINT FK_gvbb_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_BaiBao ADD CONSTRAINT FK_gvbb_bb FOREIGN KEY(MaBaiBao) REFERENCES dbo.BaiBao(MaBaiBao)
ALTER TABLE dbo.GiaoVien_NghienCuuKhoaHoc ADD CONSTRAINT FK_gvnckh_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_NghienCuuKhoaHoc ADD CONSTRAINT FK_gvnckh_nckh FOREIGN KEY(MaDeTai) REFERENCES dbo.DeTaiNghienCuu(MaDeTai)
ALTER TABLE dbo.GiaoVien_BienSoanSach ADD CONSTRAINT FK_gvbss_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_BienSoanSach ADD CONSTRAINT FK_gvbss_bss FOREIGN KEY(MaSach) REFERENCES dbo.BienSoanSach(MaSach)
ALTER TABLE dbo.GiaoVien_DuAn ADD CONSTRAINT FK_gvda_gv FOREIGN KEY(MaGiaoVien) REFERENCES dbo.GiaoVien(MaGiaoVien)
ALTER TABLE dbo.GiaoVien_DuAn ADD CONSTRAINT FK_gvda_da FOREIGN KEY(MaDuAn) REFERENCES dbo.DuAn(MaDuAn)
ALTER TABLE dbo.DuAn_GiaiThuong ADD CONSTRAINT FK_dagt_da FOREIGN KEY(MaDuAn) REFERENCES dbo.DuAn(MaDuAn)
ALTER TABLE dbo.DuAn_GiaiThuong ADD CONSTRAINT FK_dagt_gt FOREIGN KEY(MaGiaiThuong) REFERENCES dbo.GiaiThuong(MaGiaiThuong)
ALTER TABLE dbo.DangKiBangSoHuu ADD CONSTRAINT FK_dkbsh_da FOREIGN KEY(MaDuAn) REFERENCES dbo.DuAn(MaDuAn)
ALTER TABLE dbo.ApDungThucTien ADD CONSTRAINT FK_adtt_da FOREIGN KEY(MaDuAn) REFERENCES dbo.DuAn(MaDuAn)
ALTER TABLE dbo.LoaiHinhConNCKH ADD CONSTRAINT FK_lhcnckhh_lhcnckh FOREIGN KEY(MaLoaiHinhChinh) REFERENCES dbo.LoaiHinhChinhNCKH(MaLoaiHinhChinh)
ALTER TABLE dbo.DeTaiNghienCuu ADD CONSTRAINT FK_dtnc_lhcnckh FOREIGN KEY(MaLoaiHinhCon) REFERENCES dbo.LoaiHinhConNCKH(MaLoaiHinhCon)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--nhap ve bai bao
INSERT INTO dbo.LoaiHinhChinhNCKH
(
    MaLoaiHinhChinh,
    TenLoaiHinhChinh
)
VALUES
('lhcnckh001',N'Bài báo khoa học'),
('lhcnckh002',N'Đề tài nghiên cứu khoa học các cấp'),
('lhcnckh003',N'Biên soạn sách, sách chuyên khảo, giáo trình, tài liệu tham khảo,sách hướng dẫn')
INSERT INTO dbo.LoaiHinhConNCKH
(MaLoaiHinhCon,TenLoaiHinhCon,DonViTinh,GioChuan,MaLoaiHinhChinh,TyLeChinh)
VALUES
('loaihinhcon001',N'Đăng trong toàn văn trong KYHNKH trong nước',N'01 bài báo',100, 'lhcnckh001',0),
('loaihinhcon002',N'Đăng trong toàn văn trong TCKH trong nước có ISSN',N'01 bài báo',150, 'lhcnckh001',0),
('loaihinhcon003',N'Đăng trong toàn văn trong KYHNKH quốc tế',N'01 bài báo',150, 'lhcnckh001',0),
('loaihinhcon004',N'Đăng trong toàn văn trong TCKH quốc tế có ISI',N'01 bài báo',200, 'lhcnckh001',0),
('loaihinhcon005',N'Đề tài, dự án sản xuất thứ cấp Nhà nước',N'01 đề tài',400, 'lhcnckh002',20),
('loaihinhcon006',N'Sách chuyên khảo',N'01 trang tác giả',3, 'lhcnckh003',0),
('loaihinhcon007',N'Giáo trình mới',N'01 dvht hoặc 01 tc',150, 'lhcnckh003',20),
('loaihinhcon008',N'Giáo trình tái bản(có bổ sung, sửa chữa)',N'01 dvht hoặc 01 tc',120, 'lhcnckh003',20),
('loaihinhcon009',N'Tài liệu biên dịch, sách tham khảo',N'01 dvht hoặc 01 tc',100, 'lhcnckh003',20),
('loaihinhcon010',N'Sách hướng dẫn, bài giảng đối mới học phần chưa có giáo trình',N'01 dvht hoặc 01 tc',75, 'lhcnckh003',20)

INSERT INTO dbo.BaiBao
(MaBaiBao, MaLoaiHinhCon,TenBaiBao,SoLuongTacGia,ThoiGian)
VALUES
('bb0001', 'loaihinhcon001', N'A fast learning algorithm for deep belief nets', 3,'2006'),
('bb0002', 'loaihinhcon001', N'Reducing the dimensionality of data with neural networks', 4,'2006'),
('bb0003', 'loaihinhcon001', N'Imagenet classification with deep convolutional neural networks', 1,'2013'),
('bb0004', 'loaihinhcon001', N'Very deep convolutional networks for large-scale image recognition', 6,'2015'),
('bb0005', 'loaihinhcon002', N'Going deeper with convolutions', 2,'2007'),
('bb0006', 'loaihinhcon002', N'Deep residual learning for image recognition', 5,'2015'),
('bb0007', 'loaihinhcon002', N'Deep neural networks for acoustic modeling in speech recognition: The shared views of four research groups.', 6,'2012'),
('bb0008', 'loaihinhcon003', N'Speech recognition with deep recurrent neural networks', 4,'2013'),
('bb0009', 'loaihinhcon003', N'Towards End-To-End Speech Recognition with Recurrent Neural Networks', 4,'2014'),
('bb0010', 'loaihinhcon003', N'Fast and accurate recurrent neural network acoustic models for speech recognition', 3,'2015'),
('bb0011', 'loaihinhcon004', N'Deep speech 2: End-to-end speech recognition in english and mandarin', 2,'2015'),
('bb0012', 'loaihinhcon004', N'Improving neural networks by preventing co-adaptation of feature detectors', 3,'2016'),
('bb0013', 'loaihinhcon004', N'Dropout: a simple way to prevent neural networks from overfitting', 3,'2016'),
('bb0014', 'loaihinhcon004', N'Binarized Neural Networks: Training Neural Networks with Weights and Activations Constrained to+ 1 or−1.', 3,'2016')
---nhap nckh
INSERT INTO dbo.DeTaiNghienCuu
(MaDeTai,TenDeTai,SoLuongThanhVien,MaLoaiHinhCon)
VALUES
('dtnckh0001',N'Ứng dụng công nghệ bảo đảm an ninh, an toàn mạng và bí mật thông tin ở mức cao để phát triển bộ giải pháp an toàn an ninh mạng LAN cho cơ quan nhà nước',5,'loaihinhcon005'),
('dtnckh0002',N'Phân tích ngôn ngữ tự nhiên và trích rút tri thức từ dữ liệu văn bản song ngữ ứng dụng cho dịch máy thống kê',5,'loaihinhcon005'),
('dtnckh0003',N'Nghiên cứu xây dựng phần mềm công cụ để phát triển các ứng dụng thu thập và xử lý số liệu trong các hệ thống giám sát tập trung',5,'loaihinhcon005'),
('dtnckh0004',N'Giải pháp nền tảng cho hệ thống tích hợp dữ liệu lớn và không đồng nhất',5,'loaihinhcon005'),
('dtnckh0005',N'Tăng tốc truyền trực tuyến tệp tin video lớn với định dạng MP4 bằng phương pháp lấy trước thông tin mào đầu',5,'loaihinhcon005'),
('dtnckh0006',N'Kiểm chứng sự tương đương của các mô hình phần mềm',5,'loaihinhcon005'),
('dtnckh0007',N'Cơ sở hình thức và công cụ hỗ trợ cho thao tác mô hình trong phát triển phần mềm hướng mô hình',5,'loaihinhcon005'),
('dtnckh0008',N'Phân tích chương trình và ứng dụng trong kiểm chứng phần mềm',5,'loaihinhcon005'),
('dtnckh0009',N'Các phương pháp nhanh giải các bài toán phân tích mối quan hệ giữa các trình tự cho các tập dữ liệu lớn,',5,'loaihinhcon005'),
('dtnckh0010',N'Xây dựng hệ thống hướng dịch vụ hỗ trợ kiểm lỗi chính tả và phát hiện sao chép văn bản',5,'loaihinhcon005'),
('dtnckh0011',N'Mô hình hóa mức độ ô nhiễm không khí sử dụng dữ liệu ảnh viễn thám và quan trắc đa nguồn, đa thời gian, đa độ phân giải',5,'loaihinhcon005'),
('dtnckh0012',N'Xây dựng hệ thống cung cấp video 360 độ trên bản đồ trực tuyến cho một số đường phố chính của Hà Nội',5,'loaihinhcon005'),
('dtnckh0013',N'Nghiên cứu và phát triển công cụ hỗ trợ việc phát hiện sớm bùng nổ sự kiện trên mạng xã hội Facebook',5,'loaihinhcon005')

----nhap bien soan sách
INSERT INTO dbo.BienSoanSach
( MaSach,TenSach,NoiXuatBan,SoLuongThanhVien,ThoiGianXuatBan,SoTrang,DonViHocTrinh,MaLoaiHinhCon)
VALUES
('sach001',N'Đại số tuyến tính', N'Nhà xuất bản Giáo dục',10,'2017',300,5,'loaihinhcon007'),
('sach002',N'Toán chuyên đề', N'Nhà xuất bản HVKTQS',15,'2015',200,5,'loaihinhcon008'),
('sach003',N'Cơ sở dữ liệu nâng cao', N'Nhà xuất bản HVKTQS',0,'2015',150,6,'loaihinhcon009'),
('sach004',N'Phương pháp phét triển hệ thống thông tin', N'Nhà xuất bản HVKTQS',6,'2018',100,5,'loaihinhcon010')


SELECT * FROM dbo.GiaoVien

----nhap giao vien viet bao
DROP TABLE giaovien_baibao
INSERT INTO dbo.GiaoVien_BaiBao
(MaGiaoVien,MaBaiBao,ThoiGianBatDau,ThoiGianHoanThanh,VaiTroTrongBaiBao)
VALUES
('gv0001','bb0001','2004','2005',1),
('gv0006','bb0001','2004','2005',0),
('gv0007','bb0001','2004','2005',0),
('gv0002','bb0003','2012','2013',1),
('gv0004','bb0003','2012','2013',0),
('gv0005','bb0003','2012','2013',0),
('gv0008','bb0003','2012','2013',0),
('gv0003','bb0009','2012','2013',1),
('gv0008','bb0009','2012','2013',0),
('gv0009','bb0009','2012','2013',0),
('gv0011','bb0009','2012','2013',0),
('gv0013','bb0002','2007','2010',1),
('gv0018','bb0002','2007','2010',0),
('gv0019','bb0002','2007','2010',0),
('gv0011','bb0002','2007','2010',0),
('gv0014','bb0007','2008','2009',1),
('gv0021','bb0007','2008','2009',0),
('gv0020','bb0007','2008','2009',0),
('gv0022','bb0007','2008','2009',0),
('gv0014','bb0008','2008','2009',1),
('gv0015','bb0008','2008','2009',0),
('gv0020','bb0008','2008','2009',0),
('gv0003','bb0008','2008','2009',0)


SELECT TenBaiBao,TenGiaoVien, VaiTroTrongBaiBao FROM dbo.GiaoVien,dbo.GiaoVien_BaiBao,dbo.BaiBao
WHERE
BaiBao.MaBaiBao = GiaoVien_BaiBao.MaBaiBao
AND GiaoVien.MaGiaoVien = GiaoVien_BaiBao.MaGiaoVien

---nhap giao vien nckh
INSERT INTO dbo.GiaoVien_NghienCuuKhoaHoc
(
    MaGiaoVien,
    MaDeTai,
    ThoiGianBatDau,
    ThoiGianHoanThanh,
    VaiTroTrongNghienCuu
)
VALUES
('gv0001','dtnckh0002','2004','2005',1),
('gv0008','dtnckh0002','2004','2005',0),
('gv0010','dtnckh0002','2004','2005',0),
('gv0002','dtnckh0004','2012','2013',1),
('gv0014','dtnckh0004','2012','2013',0),
('gv0015','dtnckh0004','2012','2013',0),
('gv0018','dtnckh0004','2012','2013',0),
('gv0003','dtnckh0001','2012','2013',1),
('gv0012','dtnckh0001','2012','2013',0),
('gv0009','dtnckh0001','2012','2013',0),
('gv0011','dtnckh0001','2012','2013',0),
('gv0005','dtnckh0006','2002','2003',1),
('gv0012','dtnckh0006','2002','2003',0),
('gv0019','dtnckh0006','2002','2003',0),
('gv0021','dtnckh0006','2002','2003',0),
('gv0003','dtnckh0003','2014','2016',1),
('gv0012','dtnckh0003','2014','2016',0),
('gv0009','dtnckh0003','2014','2016',0),
('gv0011','dtnckh0003','2014','2016',0),
('gv0022','dtnckh0007','2012','2013',1),
('gv0021','dtnckh0007','2012','2013',0),
('gv0020','dtnckh0007','2012','2013',0),
('gv0018','dtnckh0007','2012','2013',0),
('gv0013','dtnckh0007','2012','2013',0),
('gv0012','dtnckh0007','2012','2013',0),
('gv0003','dtnckh0013','2014','2016',1),
('gv0012','dtnckh0013','2014','2016',0),
('gv0009','dtnckh0013','2014','2016',0),
('gv0011','dtnckh0013','2014','2016',0)

SELECT * FROM dbo.DeTaiNghienCuu
SELECT TenGiaoVien,TenDeTai,VaiTroTrongNghienCuu FROM dbo.GiaoVien,dbo.GiaoVien_NghienCuuKhoaHoc,dbo.DeTaiNghienCuu
WHERE GiaoVien.MaGiaoVien = GiaoVien_NghienCuuKhoaHoc.MaGiaoVien
AND DeTaiNghienCuu.MaDeTai = GiaoVien_NghienCuuKhoaHoc.MaDeTai


---giao vien bien soan sach
INSERT INTO dbo.GiaoVien_BienSoanSach
(
    MaGiaoVien,
    MaSach,
    ThoiGianBatDau,
    ThoiGianKetThuc,
    VaiTroTrongBienSoan,
	SoTrangViet
)
VALUES
('gv0001','sach001','2004','2007',1,100),
('gv0008','sach001','2004','2007',0,50),
('gv0010','sach001','2004','2007',0,25),
('gv0011','sach001','2004','2007',0,22),
('gv0012','sach001','2004','2007',0,12),
('gv0022','sach001','2004','2007',0,90),
('gv0002','sach002','2012','2013',1,50),
('gv0014','sach002','2012','2013',0,10),
('gv0015','sach002','2012','2013',0,10),
('gv0018','sach002','2012','2013',0,10),
('gv0019','sach002','2012','2013',0,10),
('gv0020','sach002','2012','2013',0,10),
('gv0021','sach002','2012','2013',0,50),
('gv0004','sach002','2012','2013',0,40),
('gv0003','sach003','2012','2018',1,50),
('gv0012','sach003','2012','2018',0,10),
('gv0009','sach003','2012','2018',0,10),
('gv0011','sach003','2012','2018',0,10),
('gv0017','sach003','2012','2018',0,10),
('gv0016','sach003','2012','2018',0,60),
('gv0003','sach004','2012','2018',1,50),
('gv0005','sach004','2012','2018',0,10),
('gv0007','sach004','2012','2018',0,10),
('gv0009','sach004','2012','2018',0,10),
('gv0011','sach004','2012','2018',0,70)


SELECT * FROM dbo.BienSoanSach
SELECT * FROM dbo.ThongKe_BienSoanSach('gv0001')
--- giai thuong
INSERT INTO dbo.GiaiThuong
(
    MaGiaiThuong,
    TenGiaiThuong,
    PhamVi,
    NoiCap,
    ToChucTraoThuong
)
VALUES
('giaithuong001',N'ASOCIO',N'Toàn cầu',N'Nhật Bản',N'Tổ chức Công nghiệp Điện toán châu Á - châu Đại Dương'),
('giaithuong002',N'Công nghệ số Việt Nam',N'Trong nước',N'Việt Nam',N'Hội Truyền thông số Việt Nam'),
('giaithuong003',N'TOP ICT Việt Nam ',N'Trong nước',N'Việt Nam',N'Hội Tin học Việt Nam'),
('giaithuong004',N' Giải thưởng Hồ Chí Minh về khoa học và công nghệ',N'Trong nước',N'Việt Nam',N'Hội đồng Nhà nước')


INSERT INTO dbo.DuAn
(
    MaDuAn,
    TenDuAn,
    MoTa,
    MaCoQuanQuanLy,
    TinhTrang
)
VALUES
('duan001', N'Nghiên cứu xây dựng Hệ thống phục vụ đào tạo nguồn lực an toàn thông tin',N'Cấp nhà nước','null',1),
('duan002', N'Nghiên cứu xây dựng hệ thống mô phỏng huấn luyện',N'Cấp trường','null',1),
('duan003', N'Nghiên cứu xây dựng thuật toán và phần mềm xử lý và nhận dạng ký tự viết tay',N'Câp bộ','null',1),
('duan004', N'Xây dựng hệ thống hỗ trợ học và thi trắc nghiệm',N'Cấp bộ','null',1),
('duan005', N'Xây dựng hệ thống quản lý Khoa học công nghệ tại Học viện Kỹ thuật Quân sự',N'Cấp nhà nước','null',1),
('duan006', N'Một số phương pháp phân cụm dữ liệu sử dụng tập mờ loại hai và ứng dụng',N'Cấp trường','null',1)

----giiao vien du an
INSERT INTO dbo.GiaoVien_DuAn
(
    MaGiaoVien,
    MaDuAn,
    ThoiGianBatDau,
    ThoiGianHoanThanh,
    VaiTroTrongDuAn
)
VALUES
('gv0001','duan001','2012','2014', 1),
('gv0002','duan002','2014','2015', 1),
('gv0003','duan003','2015','2016', 1),
('gv0004','duan004','2016','2017', 1),
('gv0005','duan005','2012','2012', 1),
('gv0006','duan006','2011','2015', 1),
('gv0007','duan006','2011','2015', 0),
('gv0008','duan006','2011','2015', 0)

---du an dang ki so huu
SELECT * FROM dbo.DuAn
INSERT INTO dbo.DangKiBangSoHuu
(
    MaBangSangChe,
    SoHieu,
    ThoiGianCap,
    PhamVi,
    NoiCap,
    MaDuAn
)
VALUES
('bsc0001',  '111111', '2015',N'Trong nước',N'Cục Sở Hữu Trí Tuệ', 'duan001' ),
('bsc0002',  '111112', '2015',N'Trong nước',N'Cục Sở Hữu Trí Tuệ', 'duan002' ),
('bsc0003',  '111113', '2015',N'Trong nước',N'Cục Sở Hữu Trí Tuệ', 'duan003' ),

INSERT INTO dbo.ApDungThucTien
(
    MaApDungThucTien,
    HieuQuaThucTien,
    DiaChiApDung,
    QuyMoApDung,
    HinhThucApDung,
    ThoiGianApDung,
    MaDuAn
)
VALUES
('adtt001', N'Áp dụng vào quá trình thi trắc nghiệm trong các nhà trường quân đội',N'Bộ Quốc phòng', N'Toàn quân',N'Hệ thống',GETDATE(),'duan004')
-------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0001' ,N'Lê Ngọc Dự' ,'1972-1-1',N'Nam' , N'Buôn Mê Thuột' ,N'Cầu Giấy - Hà Nội' , '84982123123')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0002' ,N'Bùi Thanh Hoàng' ,'1972-1-2',N'Nam' , N'Buôn Mê Thuột' ,N'Cầu Giấy - Hà Nội' , '84982123124')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0003' ,N'Võ Huy Hoàng' ,'1972-1-3',N'Nam' , N'Đắc Lắc' ,N'Cầu Giấy - Hà Nội' , '84982123125')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0004' ,N'Nguyễn Mạnh Thiên' ,'1972-1-4',N'Nam' , N'Lào Cai' ,N'Cầu Giấy - Hà Nội' , '84982123126')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0005' ,N'Bùi Mạnh Hoài' ,'1972-1-5',N'Nam' , N'Nghệ An' ,N'Cầu Giấy - Hà Nội' , '84982123127')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0006' ,N'Lữ Thái Học' ,'1972-1-6',N'Nam' , N'Bến Tre' ,N'Cầu Giấy - Hà Nội' , '84982123128')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0007' ,N'Phạm Đăng Khoa' ,'1972-1-7',N'Nam' , N'Phú Yên' ,N'Cầu Giấy - Hà Nội' , '84982123129')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0008' ,N'Nguyễn Trọng Long' ,'1972-2-1',N'Nam' , N'Thanh Hóa' ,N'Cầu Giấy - Hà Nội' , '84982123130')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0009' ,N'Nguyễn Đức Vượng' ,'1972-3-1',N'Nam' , N'Hải Dương' ,N'Cầu Giấy - Hà Nội' , '84982123131')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0010' ,N'Cao Mạnh Quyết' ,'1972-1-12',N'Nam' , N'Buôn Mê Thuột' ,N'Cầu Giấy - Hà Nội' , '84982123132')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0011' ,N'Nguyễn Văn Tuấn' ,'1972-1-15',N'Nam' , N'Hà Nội' ,N'Cầu Giấy - Hà Nội' , '84982123133')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0012' ,N'Hoàng Thị Thủy' ,'1972-6-1',N'Nữ' , N'Đông Anh' ,N'Cầu Giấy - Hà Nội' , '84982123134')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0013' ,N'Hoàng Tấn Phát' ,'1972-4-1',N'Nam' , N'Quảng Bình' ,N'Cầu Giấy - Hà Nội' , '84982123135')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0014' ,N'Nguyễn Tú Ngọc' ,'1972-8-1',N'Nam' , N'Quảng Trị' ,N'Cầu Giấy - Hà Nội' , '84982123136')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0015' ,N'Nguyễn Duy ' ,'1972-12-1',N'Nam' , N'Huế' ,N'Cầu Giấy - Hà Nội' , '84982123137')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0016' ,N'Trần Đăng' ,'1972-11-1',N'Nam' , N'Đồng Nai' ,N'Cầu Giấy - Hà Nội' , '84982123138')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0017' ,N'Nguyễn Thị Ngọc' ,'1972-11-11',N'Nữ' , N'Buôn Mê Thuột' ,N'Cầu Giấy - Hà Nội' , '84982123140')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0018' ,N'Nguyễn Trúc Anh' ,'1972-10-12',N'Nữ' , N'Hà Nội' ,N'Cầu Giấy - Hà Nội' , '84982123141')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0019' ,N'Lê Minh Anh' ,'1972-12-10',N'Nữ' , N'Hà Nội' ,N'Cầu Giấy - Hà Nội' , '84982123142')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0020' ,N'Lê Nguyên' ,'1972-6-10',N'Nam' , N'Hà Nam' ,N'Cầu Giấy - Hà Nội' , '84982123143')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0021' ,N'Lê Công Bá Duy' ,'1972-7-10',N'Nam' , N'Hà Tĩnh' ,N'Cầu Giấy - Hà Nội' , '84982123144')
INSERT INTO dbo.GiaoVien ( MaGiaoVien ,TenGiaoVien ,NgaySinh ,GioiTinh ,QueQuan ,DiaChi ,SDT)VALUES( 'gv0022' ,N'Trần Hoàng' ,'1972-5-1',N'Nam' , N'Hà Nội' ,N'Cầu Giấy - Hà Nội' , '84982123145')


GO


--nhap mien giam chuc vu
INSERT INTO dbo.DinhMucMienGiamChucVu
(MaDinhMucMienGiam,TyLeMienGiamThap,TyLeMienGiamCao,Loai,TenChucVu)
VALUES
('mgcv001',95,0,0,N'Giám đốc'),
('mgcv002',85,0,0,N'Chính ủy'),
('mgcv003',30,0,0,N'Chủ nhiệm khoa và tương đương'),
('mgcv004',20,25,0,N'Phó chủ nhiệm khoa, Chủ nhiệm Bộ môn và tương đương'),
('mgcv005',15,20,0,N'Phó chủ nhiệm bộ môn và Trưởng phòng thí nghiệm'),
('mgcv006',10,15,0,N'Phó phòng thí nghiệm'),
('mgcv007',30,0,1,N'Bí thư Đảng ủy'),
('mgcv008',20,25,1,N'Phó bí thư Đảng ủy và Bí thư chi bộ'),
('mgcv009',15,20,1,N'Bí thư đoàn cơ sở'),
('mgcv010',10,15,0,N'Chủ nhiệm lớp'),
('mgcv011',50,0,2,N'Học viên cao học'),
('mgcv012',70,0,2,N'Nghiên cứu sinh không tập trung'),
('mgcv013',0,0,0,N'Giáo viên'),
('mgcv014',0,0,1,N'Đảng viên')
--mien giam dac biet
--dinh muc ve chuc danh


--nhap don vi cq
INSERT INTO dbo.DonViChinhQuyen( MaDonViChinhQuyen, TenDonViChinhQuyen )VALUES  ( 'dvcq001', N'Khoa công nghệ thông tin' )
INSERT INTO dbo.DonViChinhQuyen( MaDonViChinhQuyen, TenDonViChinhQuyen )VALUES  ( 'dvcq002', N'Khoa kỹ thuật điều khiển' )
INSERT INTO dbo.DonViChinhQuyen( MaDonViChinhQuyen, TenDonViChinhQuyen )VALUES  ( 'dvcq003', N'Khoa Hóa, Lý Kỹ Thuật' )
INSERT INTO dbo.DonViChinhQuyen( MaDonViChinhQuyen, TenDonViChinhQuyen )VALUES  ( 'dvcq004', N'Khoa Vô Tuyến điện tử' )


SELECT * FROM dbo.DonViChinhQuyen
--nhap cvcq
INSERT INTO dbo.ChucVuChinhQuyen (MaChucVuChinhQuyen,TenChucVuChinhQuyen,MaDinhMucMienGiam)
VALUES 
('cvcq001',N'Giám đốc Học viện','mgcv001'),
('cvcq002',N'Chính ủy Học viện','mgcv002'),
('cvcq003',N'Chủ nhiệm Khoa','mgcv003'),
('cvcq004',N'Phó chủ nhiệm Khoa','mgcv004'),
('cvcq005',N'Chủ nhiệm Bộ môn','mgcv004'),
('cvcq006',N'Phó chủ nhiệm bộ môn','mgcv005'),
('cvcq007',N'Trưởng phòng thí nghiệm','mgcv005'),
('cvcq008',N'Phó trưởng phòng thí nghiệm','mgcv006'),
('cvcq009',N'Giáo viên','mgcv013')



-- nhap cq
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq001', 'cvcq003','dvcq001')--chu nhiem khoa
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq002', 'cvcq004','dvcq001')--pho khoa
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq003', 'cvcq009','dvcq001')--giao vien


--nhap gv_cq
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0001', 'cq001', '1990-1-1')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0002', 'cq002', '1990-2-1')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0003', 'cq003', '1990-3-1')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0004', 'cq003', '1990-4-1')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0005', 'cq003', '1990-5-1')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0006', 'cq003', '1990-6-1')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0007', 'cq003', '1990-7-1')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0008', 'cq003', '1990-8-1')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0009', 'cq003', '1990-9-1')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0010', 'cq003', '1990-1-2')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0011', 'cq003', '1990-1-3')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0012', 'cq003', '1990-1-4')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0013', 'cq003', '1990-1-5')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0014', 'cq003', '1990-1-6')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0015', 'cq003', '1990-1-7')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0016', 'cq003', '1990-1-8')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0017', 'cq003', '1990-1-9')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0018', 'cq003', '1990-1-10')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0019', 'cq003', '1990-1-4')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0020', 'cq003', '1990-1-4')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0021', 'cq003', '1990-1-4')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0022', 'cq003', '1990-1-4')

GO
--nhap dvd
INSERT INTO dbo.DonViDang( MaDonViDang, TenDonViDang )VALUES  ( 'dvd001', N'Đảng bộ khoa CNTT')
INSERT INTO dbo.DonViDang( MaDonViDang, TenDonViDang )VALUES  ( 'dvd002', N'Đảng bộ khoa KTDK')
INSERT INTO dbo.DonViDang( MaDonViDang, TenDonViDang )VALUES  ( 'dvd003', N'Đảng bộ khoa HLKT')
INSERT INTO dbo.DonViDang( MaDonViDang, TenDonViDang )VALUES  ( 'dvd004', N'Đảng bộ khoa VTDT')

--nhap cvd

INSERT INTO dbo.ChucVuDang( MaChucVuDang, TenChucVuDang,MaDinhMucMienGiam )
VALUES 
('cvd001',N'Bí thư đảng ủy','mgcv007'),
('cvd002',N'Phó Bí thư đảng ủy','mgcv008'),
('cvd003',N'Bí thư chi bộ','mgcv008'),
('cvd004',N'Bí thư đoàn cơ sở','mgcv009'),
('cvd005',N'Đảng viên','mgcv014')


--nhap dang
------------khoa cntt
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd001','dvd001', 'cvd001')--bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd002','dvd001', 'cvd002')--pho bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd003','dvd001', 'cvd005')--dang vien
-------------khoa ktdk
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd001','dvd002', 'cvd001')--bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd002','dvd002', 'cvd002')--pho bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd003','dvd002', 'cvd005')--dang vien
------------------------khoa hlkt
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd001','dvd003', 'cvd001')--bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd002','dvd003', 'cvd002')--pho bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd003','dvd003', 'cvd005')--dang vien
----------khoa vtdt
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd001','dvd004', 'cvd001')--bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd002','dvd004', 'cvd002')--pho bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd003','dvd004', 'cvd005')--dang vien 


--nhap gv_d
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0001', 'd001', '1990-2-2')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0002', 'd002', '1990-3-2')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0003', 'd003', '1990-4-2')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0004', 'd003', '1990-5-2')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0005', 'd003', '1990-6-2')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0006', 'd003', '1990-7-2')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0007', 'd003', '1990-8-2')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0008', 'd003', '1990-9-2')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0009', 'd003', '1990-10-2')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0010', 'd003', '1990-11-2')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0011', 'd003', '1990-2-21')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0012', 'd003', '1990-3-21')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0013', 'd003', '1990-4-21')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0014', 'd003', '1990-5-22')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0015', 'd003', '1990-6-23')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0016', 'd003', '1990-7-24')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0017', 'd003', '1990-8-22')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0018', 'd003', '1990-9-25')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0019', 'd003', '1990-10-26')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0020', 'd003', '1990-11-28')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0021', 'd003', '1990-11-21')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0022', 'd003', '1990-11-20')

GO
--nhap hoc vi
INSERT INTO dbo.HocVi( MaHocVi, TenHocVi )VALUES  ( 'hocvi001', N'Tiến sĩ')
INSERT INTO dbo.HocVi( MaHocVi, TenHocVi )VALUES  ( 'hocvi002', N'Thạc sĩ')
INSERT INTO dbo.HocVi( MaHocVi, TenHocVi )VALUES  ( 'hocvi003', N'Kỹ sư')
INSERT INTO dbo.HocVi( MaHocVi, TenHocVi )VALUES  ( 'hocvi004', N'Cử nhân')

--nhap gv--hocvi
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0001', 'hocvi001', '1990-3-13')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0002', 'hocvi001', '1990-3-23')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0003', 'hocvi001', '1990-3-4')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0004', 'hocvi001', '1990-3-5')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0005', 'hocvi002', '1990-3-6')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0006', 'hocvi002', '1990-3-7')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0007', 'hocvi002', '1990-3-8')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0008', 'hocvi003', '1990-3-9')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0009', 'hocvi003', '1990-1-3')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0010', 'hocvi003', '1990-2-3')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0011', 'hocvi003', '1990-3-3')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0012', 'hocvi003', '1990-4-3')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0013', 'hocvi003', '1990-5-3')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0014', 'hocvi003', '1990-6-3')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0015', 'hocvi003', '1990-7-3')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0016', 'hocvi003', '1990-8-3')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0017', 'hocvi004', '1990-9-3')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0018', 'hocvi004', '1990-1-2')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0019', 'hocvi004', '1990-2-5')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0020', 'hocvi004', '1990-1-30')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0021', 'hocvi004', '1990-1-8')
INSERT INTO dbo.GiaoVien_HocVi ( MaGiaoVien, MaHocVi, ThoiGianNhan )VALUES  ( 'gv0022', 'hocvi004', '1990-1-12')


GO

---nhap bang dinh muc chuc danh
INSERT INTO dbo.DinhMucChucDanh
(MaDinhMucChucDanh,TenChucDanh,GioQuyDinhChungGiangDay,GioMonTheChatGiaoDucQuocPhong,ThoiGianNghienCuu,ThoiGianChuanNghienCuu)
VALUES
('dmcd001',N'Giáo sư và giảng viên cao cấp',360,500,700,280),
('dmcd002',N'Phó giao sư và giảng viên chinh',320,460,600,210),
('dmcd003',N'Giáo viên',280,420,500,150),
('dmcd004',N'Trợ giảng',0,0,0,0)
--nhap hoc ham
INSERT INTO dbo.HocHam
(MaHocHam,TenHocHam,MaDinhMucChucDanh)
VALUES
('hocham001',N'Giáo sư','dmcd001'),
('hocham002',N'Phó Giáo sư','dmcd002'),
('hocham003',N'Giảng viên chính','dmcd002'),
('hocham004',N'Giảng viên','dmcd003'),
('hocham005',N'Trợ giảng','dmcd004')
--nhap gv-hocham

INSERT INTO dbo.GiaoVien_HocHam ( MaGiaoVien, MaHocHam, ThoiGianNhan ) VALUES  ( 'gv0001', 'hocham001', '1991-4-4')
INSERT INTO dbo.GiaoVien_HocHam ( MaGiaoVien, MaHocHam, ThoiGianNhan ) VALUES  ( 'gv0002', 'hocham002', '1993-4-4')
INSERT INTO dbo.GiaoVien_HocHam ( MaGiaoVien, MaHocHam, ThoiGianNhan ) VALUES  ( 'gv0003', 'hocham002', '1993-4-4')
INSERT INTO dbo.GiaoVien_HocHam ( MaGiaoVien, MaHocHam, ThoiGianNhan ) VALUES  ( 'gv0004', 'hocham002', '1993-4-4')
GO
--nhap chuc danh
INSERT INTO dbo.ChucDanh( MaChucDanh, TenChucDanh,MaDinhMucChucDanh )
VALUES  
('cd001',N'Giáo sư','dmcd001'),
('cd002',N'Phó Giáo sư','dmcd002'),
('cd003',N'Giảng viên chính','dmcd002'),
('cd004',N'Giảng viên','dmcd003'),
('cd005',N'Trợ giảng','dmcd004')

--nhap gv_cd
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0001' ,'cd001' ,'1992-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0002' ,'cd002' ,'1992-10-10' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0003' ,'cd002' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0004' ,'cd002' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0005' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0006' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0007' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0008' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0009' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0010' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0011' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0012' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0013' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0014' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0015' ,'cd003' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0016' ,'cd004' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0017' ,'cd004' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0018' ,'cd004' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0019' ,'cd004' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0020' ,'cd004' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0021' ,'cd004' ,'1990-1-1' ,'1995-5-5' )
INSERT INTO dbo.GiaoVien_ChucDanh( MaGiaoVien ,MaChucDanh ,ThoiGianNhanBatDau ,ThoiGianNhanKetThuc)VALUES  ( 'gv0022' ,'cd004' ,'1990-1-1' ,'1995-5-5' )

GO
--nhap ngoai ngu
INSERT INTO dbo.NgoaiNgu( MaNgoaiNgu, TenNgoaiNgu ) VALUES  ( 'nn001', N'Tiếng anh'  )
INSERT INTO dbo.NgoaiNgu( MaNgoaiNgu, TenNgoaiNgu ) VALUES  ( 'nn002', N'Tiếng nga'  )
INSERT INTO dbo.NgoaiNgu( MaNgoaiNgu, TenNgoaiNgu ) VALUES  ( 'nn003', N'Tiếng trung'  )
INSERT INTO dbo.NgoaiNgu( MaNgoaiNgu, TenNgoaiNgu ) VALUES  ( 'nn004', N'Tiếng hàn'  )

--nhap gv_nn
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0001' , 'nn001' ,  '1990-7-8' , 'B2')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0002' , 'nn001' ,  '1990-7-8' , 'B2')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0003' , 'nn001' ,  '1990-7-8' , 'B2')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0004' , 'nn001' ,  '1990-7-8' , 'B2')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0005' , 'nn001' ,  '1990-7-8' , 'B2')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0006' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0007' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0008' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0009' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0010' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0011' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0012' , 'nn002' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0013' , 'nn002' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0014' , 'nn002' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0015' , 'nn002' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0016' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0017' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0018' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0019' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0020' , 'nn001' ,  '1990-7-8' , 'B1')
INSERT INTO dbo.GiaoVien_NgoaiNgu( MaGiaoVien ,MaNgoaiNgu , ThoiGianNhan ,TrinhDo )VALUES  ( 'gv0021' , 'nn001' ,  '1990-7-8' , 'B1')

GO
--nhap huong nghien cuu
INSERT INTO dbo.HuongNghienCuu( MaHuongNghienCuu, TenHuongNghienCuu )VALUES  ( 'hnc001',N'An ninh thông tin')
INSERT INTO dbo.HuongNghienCuu( MaHuongNghienCuu, TenHuongNghienCuu )VALUES  ( 'hnc002',N'Bảo mật thông tin')

--nhap gv_hnc

INSERT INTO dbo.GiaoVien_HuongNghienCuu( MaGiaoVien ,MaHuongNghienCuu ,ThoiGianBatDau ,ThoiGianKetThuc)VALUES  ( 'gv0001' , 'hnc001' ,'1995-1-1','1998-2-2') 
INSERT INTO dbo.GiaoVien_HuongNghienCuu( MaGiaoVien ,MaHuongNghienCuu ,ThoiGianBatDau ,ThoiGianKetThuc)VALUES  ( 'gv0002' , 'hnc002' ,'1995-1-1','1998-2-2') 
INSERT INTO dbo.GiaoVien_HuongNghienCuu( MaGiaoVien ,MaHuongNghienCuu ,ThoiGianBatDau ,ThoiGianKetThuc)VALUES  ( 'gv0003' , 'hnc001' ,'1995-1-1','1998-2-2') 
INSERT INTO dbo.GiaoVien_HuongNghienCuu( MaGiaoVien ,MaHuongNghienCuu ,ThoiGianBatDau ,ThoiGianKetThuc)VALUES  ( 'gv0004' , 'hnc002' ,'1995-1-1','1998-2-2') 
INSERT INTO dbo.GiaoVien_HuongNghienCuu( MaGiaoVien ,MaHuongNghienCuu ,ThoiGianBatDau ,ThoiGianKetThuc)VALUES  ( 'gv0005' , 'hnc001' ,'1995-1-1','1998-2-2')

GO
--nhap khen thuong ky luat
INSERT INTO dbo.KhenThuongKyLuat( MaKhenThuongKyLuat, TenKhenThuongKyLuat, Loai )
VALUES  
( 'ktkl001',N'Bằng khen', N'Khen thưởng' ),
( 'ktkl002',N'Giấy khen', N'Khen thưởng' ),
( 'ktkl003',N'Khiển trách', N'Kỷ luật'),
( 'ktkl004',N'Cảnh cáo', N'Kỷ luật' ) 
--nhap gv-htkl
INSERT INTO dbo.GiaoVien_KhenThuongKyLuat
        ( MaGiaoVien ,
          MaKhenThuongKyLuat ,
          TenKhenThuongKyLuatNhan ,
          ThoiGianNhan
        )
VALUES  ( 'gv0001' ,'ktkl001' , N'Bằng khen về thi đua quyết thắng' ,'1998-1-1'),
( 'gv0002' ,'ktkl002' , N'Giấy khen về thi đua quyết thắng' ,'1998-1-1'),
( 'gv0008' ,'ktkl003' , N'Khiển trách về vi phạm quy định lễ tiết tác phong' ,'1998-1-1')

GO
--nhap qua trinh dao tao
INSERT INTO dbo.DaoTaoDaiHoc
        ( MaDaoTaoDaiHoc ,
          HeDaoTao ,
          NoiDaoTao ,
          NuocDaoTao ,
          NganhDaoTao ,
          ThoiGianDaoTao
        )
VALUES  ( 'dtdh001' , N'Kỹ sư' , N'HVKTQS' , N'Việt Nam' ,  N'CNTT' , '5 năm'),
( 'dtdh002' , N'Cử nhân' , N'HVKTQS' , N'Việt Nam' ,  N'CNTT' , '4 năm'),
( 'dtdh003' , N'Kỹ sư' , N'Maxcovar' , N'Nga' ,  N'CNTT' , '7 năm'),
( 'dtdh004' , N'Kỹ sư' , N'Bắc kinh' , N'Trung Quốc' ,  N'CNTT' , '7 năm')

INSERT INTO dbo.DaoTaoSauDaiHoc
        ( MaDaoTaoSauDaiHoc ,
          LoaiDaoTao ,
          NoiDaoTao ,
          ThoiGianDaoTao
        )
VALUES  ( 'dtsdh001' ,  N'Cao học' , N'Việt Nam' ,'2 năm'),
( 'dtsdh002' ,  N'Thạc sỹ' , N'Việt Nam' ,'3 năm'),
( 'dtsdh003' ,  N'Tiến sĩ' , N'Việt Nam' ,'4 năm')

INSERT INTO dbo.QuaTrinhDaoTao
        ( MaGiaoVien, MaQuaTrinhDaoTao )
VALUES  ( 'gv0001','qtdt001'),
( 'gv0002','qtdt002'),
( 'gv0003','qtdt003'),
( 'gv0004','qtdt004'),
( 'gv0005','qtdt005'),
( 'gv0006','qtdt006'),
( 'gv0007','qtdt007'),
( 'gv0008','qtdt008'),
( 'gv0009','qtdt009'),
( 'gv0010','qtdt010'),
( 'gv0011','qtdt011'),
( 'gv0012','qtdt012'),
( 'gv0013','qtdt013'),
( 'gv0014','qtdt014'),
( 'gv0015','qtdt015'),
( 'gv0016','qtdt016'),
( 'gv0017','qtdt017'),
( 'gv0018','qtdt018'),
( 'gv0019','qtdt019'),
( 'gv0020','qtdt020'),
( 'gv0021','qtdt021'),
( 'gv0022','qtdt022')

GO
--nhap qtdt_dtdh
INSERT INTO dbo.QuaTrinhDaoTao_DaoTaoDaiHoc
        ( MaQuaTrinhDaoTao ,
          MaDaoTaoDaiHoc ,
          NamTotNghiep
        )
VALUES  ( 'qtdt001' , 'dtdh001' , '1988-1-1'),
( 'qtdt002' , 'dtdh001' , '1988-1-2'),
( 'qtdt003' , 'dtdh001' , '1988-1-3'),
( 'qtdt004' , 'dtdh001' , '1988-1-4'),
( 'qtdt005' , 'dtdh001' , '1988-1-1'),
( 'qtdt006' , 'dtdh001' , '1988-1-1'),
( 'qtdt007' , 'dtdh001' , '1988-2-3'),
( 'qtdt008' , 'dtdh001' , '1988-2-2'),
( 'qtdt009' , 'dtdh001' , '1988-4-4'),
( 'qtdt010' , 'dtdh001' , '1988-4-5'),
( 'qtdt011' , 'dtdh001' , '1988-4-7'),
( 'qtdt012' , 'dtdh001' , '1988-5-7'),
( 'qtdt013' , 'dtdh001' , '1988-5-7'),
( 'qtdt014' , 'dtdh001' , '1988-5-7'),
( 'qtdt015' , 'dtdh001' , '1988-5-7'),
( 'qtdt016' , 'dtdh001' , '1988-7-7'),
( 'qtdt017' , 'dtdh001' , '1988-7-7')

INSERT INTO dbo.QuaTrinhDaoTao_DaoTaoSauDaiHoc
        ( MaQuaTrinhDaoTao ,
          MaDaoTaoSauDaiHoc ,
          NamTotNghiep ,
          TenDeAnTotNghiep
        )
VALUES  ( 'qtdt001' , 'dtsdh003' , '1999-1-1' ,  N'Bảo mật thông tin')

GO


INSERT INTO dbo.DinhMucGiamDacBiet
(
    MaDinhMucGiamDacBiet,
    TenDinhMucGiam,
    TyLeGiam
)
VALUES
('dmgdb001',N'Có con nho hơn 36 thang',10)

INSERT INTO dbo.GiaoVien_GiamDacBiet
(
    MaGiaoVien,
    MaDinhMucGiamDacBiet,
    ThoiGianMienGiam
)
VALUES
('gv0017','dmgdb001',GETDATE()),
('gv0019','dmgdb001',GETDATE())
SELECT * FROM dbo.GiaoVien

---------------------------------------------------------------------------------------------------

insert into HocVien(MaHocVien, TenHocVien) values 
	('hv001', N'Nguyễn Mạnh Thiên'),
	('hv002', N'Phạm Văn Đan'),
	('hv003', N'Võ Huy Hoàng'),
	('hv004', N'Nguyễn Trung Thành'),
	('hv005', N'Bùi Thanh Anh Hoàng'),
	('hv006', N'Hoàng Thị Thu Thủy'),
	('hv007', N'Nguyễn Đức Thiên Trường'),
	('hv009', N'Lê Ngọc Dương'),
	('hv010', N'Đặng Xuân Mạnh'),
	('hv011', N'Cao Minh Thường')



insert into He(MaHe, TenHe) values 
	('he01', N'Tiểu đoàn 1'),
	('he02', N'Tiểu đoàn 2'),
	('he03', N'Tiểu đoàn 3'),
	('he04', N'Tiểu đoàn 4'),
	('he05', N'Hệ 1'),
	('he06', N'Hệ 2')

insert into CacLoaiHinhDaoTao(MaLoaiHinhDaoTao, TenLoaiHinhDaoTao) 
values ('lhdt01', N'Giờ lên lớp'),
('lhdt02', N'Hướng dẫn đồ án'),
('lhdt03', N'Chấm Thi và nghiệm thu, phản biện đề tài')

insert into Khoa(MaKhoa, TenKhoa) values
('khoa01', N'Công nghệ thông tin'),
('khoa02', N'Kỹ thuật điều khiển'),
('khoa03', N'Mac-Lenin'),
('khoa04', N'Hóa Lý kỹ thuật'),
('khoa05', N'Ngoại ngữ'),
('khoa06', N'Viện Công trình đặc biệt')


insert into Lop(MaLop, TenLop, SiSo, MaHe) values
('lop01', N'An ninh hệ thống thông tin', 10, 'he01'),
('lop02', N'Công nghệ thông tin', 74, 'he01'),
('lop03', N'Đảm bảo an toàn thông tin', 49, 'he02'),
('lop04', N'Vũ khí',104, 'he02'),
('lop05', N'Oto', 84, 'he03'),
('lop06', N'Pháo tàu', 26, 'he03'),
('lop07', N'Điện tàu', 99, 'he04'),
('lop08', N'Tên lửa phòng không', 160, 'he04'),
('lop09', N'Thông tin', 75, 'he05'),
('lop10', N'Kỹ thuật vật liệu', 77, 'he05'),
('lop11', N'Tác chiến điện tử', 50, 'he06'),
('lop12', N'Hóa học', 24, 'he01'),
('lop13', N'Dịa tin học', 85, 'he02'),
('lop14', N'Hải quân', 127, 'he01')



insert into BoMon(MaBoMon, TenBoMon, MaKhoa) values
('bm01', N'An toàn thông tin',  'khoa01'),
('bm02', N'Hệ thống thông tin',  'khoa01'),
('bm03', N'Công nghệ mạng',  'khoa01'),
('bm04', N'Công nghệ phần mềm',  'khoa01'),
('bm05', N'Vô tuyến điện tử',  'khoa02'),
('bm06', N'Điều khiển tự động',  'khoa02'),
('bm07', N'Tư tưởng Hồ Chí Minh',  'khoa03'),
('bm08', N'Công tác Đảng',  'khoa03'),
('bm09', N'Triết học Mac-Lênin',  'khoa03'),
('bm10', N'Vật lý',  'khoa04'),
('bm11', N'Hóa học',  'khoa04'),
('bm12', N'Tiếng anh',  'khoa05'),
('bm13', N'An toàn thông tin',  'khoa06'),
('bm14', N'Vật liệu xây dựng',  'khoa06'),
('bm15', N'Tiếng nhật',  'khoa05'),
('bm16', N'cầu đường',  'khoa06'),
('bm17', N'Xây dựng dân dụng',  'khoa06')



insert into HocPhan(MaHocPhan, TenHocPhan, SoTinChi, SoTiet, MaBoMon) values
('hp01', N'Bảo đảm an toàn thông tin', 3, 50, 'bm01'),
('hp02', N'Mạng máy tính', 3, 50, 'bm01'),
('hp03', N'Đạo đức học', 3, 54, 'bm01'),
('hp04', N'Tư tưởng Hồ Chí Minh', 4, 76, 'bm02'),
('hp05', N'Triết học 1', 2, 65, 'bm03'),
('hp06', N'Triết học 2', 1, 54, 'bm03'),
('hp07', N'Cơ sở dữ liệu', 1, 34, 'bm05'),
('hp08', N'Xác xuất thông kê', 4, 65, 'bm07'),
('hp09', N'Lập trình 1', 2, 54, 'bm09'),
('hp10', N'Lập trình 2', 1, 23, 'bm08'),
('hp11', N'Vô tuyến điện tử', 2, 54, 'bm08'),
('hp12', N'Siêu cao tần', 4, 35, 'bm10'),
('hp13', N'Ăng ten', 2, 54, 'bm12'),
('hp14', N'Điện tử tương tự', 4, 76, 'bm15'),
('hp15', N'Lý thuyết mạch', 1, 65, 'bm15'),
('hp16', N'Lập trình hợp ngữ', 2, 63, 'bm12'),
('hp17', N'Đại số tuyến tính', 5, 63, 'bm13'),
('hp18', N'Giải tích 1', 4, 65, 'bm05'),
('hp19', N'Giải tích 2', 2, 63, 'bm01'),
('hp20', N'Vật lý 1', 1, 74, 'bm05'),
('hp21', N'Vật lý 2', 5, 36, 'bm02'),
('hp22', N'vật lý 3', 2, 64, 'bm04'),
('hp23', N'Giải tích 3', 5, 85, 'bm06'),
('hp24', N'Toán chuyền đề', 1, 67, 'bm13'),
('hp25', N'Thu phát', 3, 56, 'bm13'),
('hp26', N'Tiếng anh a1', 2, 76, 'bm14'),
('hp27', N'Tiếng anh a2', 3, 76, 'bm17'),
('hp28', N'Tiếng nga', 1, 65, 'bm16'),
('hp29', N'Tiếng pháp', 3, 84, 'bm17'),
('hp30', N'Tiếng nhật', 2, 86, 'bm15'),
('hp31', N'Lịch sử Đảng', 1, 58, 'bm11'),
('hp32', N'Dân tộc học', 3, 76, 'bm02'),
('hp33', N'Tâm lý', 4, 45, 'bm05'),
('hp34', N'Giáo dục', 1, 32, 'bm06')





insert into LopHoc(MaLopHoc, TenLopHoc, CSN_CN, HocKy, MaLop, MaHocPhan, MaQuyDoi) values
('lh01', N'Công nghệ thông tin', 0, N'Kỳ 2 năm 2015-2016', 'lop01', 'hp01', NULL),
('lh02', N'Công nghệ thông tin 2', 1, N'Kỳ 2 năm 2015-2016', 'lop02', 'hp02', NULL),
('lh03', N'Hệ thống thông tin', 0, N'Kỳ 2 năm 2015-2016', 'lop05', 'hp04', NULL),
('lh04', N'Điều khiển tự động', 1, N'Kỳ 2 năm 2015-2016', 'lop12', 'hp12', NULL),
('lh05', N'Công nghệ hóa', 0, N'Kỳ 2 năm 2015-2016', 'lop13', 'hp22', NULL),
('lh06', N'Lý thuyết hệ điều hành', 0, N'Kỳ 2 năm 2015-2016', 'lop12', 'hp14', NULL),
('lh07', N'Công tác đảng', 1, N'Kỳ 2 năm 2015-2016', 'lop11', 'hp16', NULL),
('lh08', N'Điều lệnh', 0, N'Kỳ 2 năm 2015-2016', 'lop12', 'hp08', NULL),
('lh09', N'Tổng hợp', 1, N'Kỳ 2 năm 2015-2016', 'lop07', 'hp17', NULL),
('lh10', N'Siêu cao tần', 0, N'Kỳ 2 năm 2015-2016', 'lop08', 'hp32', NULL)



insert into HocPhanChamThi(MaHocPhanChamThi, GhiChu, SoBai, MaLopHoc, MaQuyDoi) values
('hpct01', N'Công nghệ thông tin', 23, 'lh01', NULL),
('hpct02', N'Vật lý', 54, 'lh03', NULL),
('hpct03', N'Thi đại học môn toán', 167, NULL, NULL),
('hpct04', N'Giải tích', 124, 'lh01', NULL),
('hpct05', N'Thi giữa kỳ', 12, 'lh01', NULL),
('hpct06', N'Thi cuối kỳ', 46, 'lh03', NULL),
('hpct07', N'Phúc tra', 65, 'lh01', NULL),
('hpct08', N'Học sinh giỏi lý', 76, NULL, NULL),
('hpct09', N'Công nghệ số', 26, 'lh09', NULL),
('hpct10', N'An toàn thông tin', 13, 'lh10', NULL)



insert into HuongDan(MaHuongDan, TenDeTai_ChuDe, SoCanBoHuongDan, ThoiGianBatDau, ThoiGianKetThuc, MaHocVien, MaQuyDoi ) values
('hd01', N'Nhận diện khuân mặt', 5, '2017-2-2', '2017-8-1', 'hv002', NULL),
('hd02', N'Phóng xạ mặt trời', 5, '2014-11-5', '2015-5-23', 'hv005', NULL),
('hd03', N'An toàn mạng xã hội', 5, '2016-5-6', '2017-2-6', 'hv003', NULL),
('hd04', N'Toán học trong quân sự', 5, '2018-3-30', '2018-5-4', 'hv010', NULL),
('hd05', N'Điện hạt nhân', 5, '2017-8-3', '2017-10-12', 'hv003', NULL),
('hd06', N'Thiên hà 42-62', 5, '2010-6-12', '2011-3-21', 'hv006', NULL),
('hd07', N'Đạo đức trong đời sống', 5, '2012-2-22', '2013-7-26', 'hv007', NULL),
('hd08', N'Mạng máy tính', 5, '2014-10-26', '2015-3-12', 'hv004', NULL),
('hd09', N'Mã hóa- số hóa', 5, '2016-7-15', '2016-11-24', 'hv009', NULL),
('hd10', N'Thiết bị IOT', 5, '2017-4-1', '2017-6-4', 'hv011', NULL),
('hd11', N'Ý thức học tập', 5, '2012-1-24', '2012-3-8', 'hv010', NULL),
('hd12', N'Tác phong mang mặc', 5, '2014-2-5', '2014-2-18', 'hv003', NULL)


insert into GiaoVien_LopHoc(GiaoVien_LopHoc, MaGiaoVien, MaLopHoc, ThoiGianBatDau, ThoiGianKetThuc) values
('gvlh01', 'gv0011', 'lh01', '2012-1-3', '2013-3-6'),
('gvlh02', 'gv0017', 'lh02', '2014-3-4', '2015-10-1'),
('gvlh03', 'gv0014', 'lh10', '2016-8-1', '2017-2-28'),
('gvlh04', 'gv0012', 'lh10', '2015-11-11', '2016-7-19'),
('gvlh05', 'gv0009', 'lh05', '2014-1-23', '2015-4-7'),
('gvlh06', 'gv0006', 'lh07', '2012-12-12', '2013-7-5'),
('gvlh07', 'gv0016', 'lh03', '2017-10-17', '2018-2-22'),
('gvlh08', 'gv0019', 'lh01', '2014-5-29', '2015-12-12'),
('gvlh09', 'gv0016', 'lh02', '2012-2-20', '2013-3-14'),
('gvlh10', 'gv0003', 'lh06', '2016-4-10', '2017-2-11')


insert into GiaoVien_HocPhanChamThi(GiaoVien_HocPhanChamThi, MaGiaoVien, MaHocPhanChamThi, ThoiGianBatDau, ThoiGianKetThuc) values
('gvhpct01', 'gv0012', 'hpct06', '2013-3-5', '2013-3-6'),
('gvhpct02', 'gv0011', 'hpct08', '2015-10-20', '2015-11-1'),
('gvhpct03', 'gv0015', 'hpct10', '2017-2-19', '2017-2-22'),
('gvhpct04', 'gv0017', 'hpct10', '2016-11-11', '2016-11-19'),
('gvhpct05', 'gv0004', 'hpct03', '2015-7-23', '2015-8-7'),
('gvhpct06', 'gv0006', 'hpct01', '2013-5-12', '2013-6-5'),
('gvhpct07', 'gv0013', 'hpct03', '2018-1-17', '2018-1-22'),
('gvhpct08', 'gv0018', 'hpct06', '2015-1-29', '2015-2-12'),
('gvhpct09', 'gv0016', 'hpct04', '2013-1-20', '2013-2-14'),
('gvhpct10', 'gv0002', 'hpct01', '2017-3-10', '2017-3-11')



insert into GiaoVien_HuongDan(GiaoVien_HuongDan, MaGiaoVien, MaHuongDan, ThoiGianBatDau, ThoiGianKetThuc) values
('gvhd01', 'gv0011', 'hd01', '2012-1-3', '2013-3-6'),
('gvhd02', 'gv0017', 'hd06', '2013-3-4', '2015-10-1'),
('gvhd03', 'gv0014', 'hd05', '2014-8-1', '2017-2-28'),
('gvhd04', 'gv0012', 'hd02', '2011-11-11', '2016-7-19'),
('gvhd05', 'gv0009', 'hd04', '2014-1-23', '2015-4-7'),
('gvhd06', 'gv0006', 'hd08', '2012-12-12', '2013-7-5'),
('gvhd07', 'gv0016', 'hd04', '2011-10-17', '2018-2-22'),
('gvhd08', 'gv0019', 'hd06', '2011-5-29', '2015-12-12'),
('gvhd09', 'gv0016', 'hd02', '2012-2-20', '2013-3-14'),
('gvhd10', 'gv0003', 'hd10', '2016-4-10', '2017-2-11')




insert into QuyDoiLoaiHinh(MaLoaiHinhCon, TenLoaiHinhCon, MaLoaiHinhDaoTao)
values ('qdlh01', N'Giảng dạy lý thuyết', 'lhdt01'),
('qdlh02', N'Hướng dẫn bài tập, bài kiểm tra, thí nghiệm, thực hành, thảo luận', 'lhdt01'),
('qdlh03', N'Dạy ngoại ngữ', 'lhdt01'),
('qdlh04', N'Dạy vẽ kỹ thuật', 'lhdt01'),
('qdlh05', N'Dạy phụ đạo', 'lhdt01'),
('qdlh06', N'Dạy thể dục thể thao và giáo dục thể chất', 'lhdt01'),
('qdlh07', N'Đồ án môn cơ sở, tiểu luận các môn khoa học xã hội và nhân văn', 'lhdt02'),
('qdlh08', N'Đồ án môn học chuyên nghành', 'lhdt02'),
('qdlh09', N'Đồ án (Luân văn) tốt nghiệp', 'lhdt02'),
('qdlh10', N'Tiểu luận các lớp ngắn hạn', 'lhdt02'),
('qdlh11', N'Thi vấn đáp môn học', 'lhdt03'),
('qdlh12', N'Thi viết', 'lhdt03'),
('qdlh13', N'Thi tốt nghiệp', 'lhdt03'),
('qdlh14', N'Chấm đồ án, bài tập lớn', 'lhdt03'),
('qdlh15', N'Chấm thi tuyển sinh đại học', 'lhdt03'),
('qdlh16', N'Tham gia hội đồng bảo vệ đồ án tốt nghiệp đại học', 'lhdt03'),
('qdlh17', N'Sửa đổi, bổ sung ngân hành đề thi kết thúc học phần', 'lhdt03'),
('qdlh18', N'Tham gia hội đồng đánh giá nghiệm thu đề tài nghiên cứu hóa học của học viên', 'lhdt03')

insert into DieuKienLoaiHinh(DieuKienLoaiHinh ,DieuKien, DonViTinh, QuyRaGioChuan, MaLoaiHinhCon)
values ('dklh01', N'0-75', N'Học viên', 1.0, 'qdlh01'),
('dklh02', N'76-100', N'Học viên', 1.1, 'qdlh01'),
('dklh03', N'101-1000', N'Học viên', 1.2, 'qdlh01'),
('dklh04', N'', N'Tiết', 0.5, 'qdlh02'),
('dklh05', N'Cơ bản, cơ sở, ngành', N'Tiết', 0.8, 'qdlh03'),
('dklh06', N'Chuyên nghành', N'Tiết', 1.0, 'qdlh03'),
('dklh07', N'', N'Tiết', 0.75, 'qdlh04'),
('dklh08', N'10', N'Phần trăm số tiết', 1.0, 'qdlh05'),
('dklh09', N'Giảng dạy lý thuyết trên lớp, giảng dạy kỹ thuật ở sân bãi', N'Tiết', 1.2, 'qdlh06'),
('dklh10', N'Bồi dưỡng cán sự thể dục thể thao', N'Tiết', 1.0, 'qdlh06'),
('dklh11', N'Hướng dẫn ngoại khóa, khiểm tra sức khỏe kiểm tra rèn luyện thể lực, tổ chức thi trong Học viện hoặc dẫn đội thi đấu ngoài Học viện', N'Tiết', 2.5, 'qdlh06'),
('dklh12', N'Trọng tài chính bóng đá', N'Trận', 3.0, 'qdlh06'),
('dklh13', N'Trọng tài chính bóng rổ, bóng chuyền', N'Trận', 1.2, 'qdlh06'),
('dklh14', N'Trọng tài chính bóng bàn', N'Trận', 1.0, 'qdlh06'),
('dklh15', N'Trọng tài phụ, thư ký bóng đá', N'Trận', 1.5, 'qdlh06'),
('dklh16', N'Trọng tài phụ, thư ký bóng rổ, bóng chuyền', N'Trận', 1.0, 'qdlh06'),
('dklh17', N'Trọng tài phụ, thư ký bóng bàn', N'Trận', 0.5, 'qdlh06'),
('dklh18', N'1-15', N'Học viên', 1.5, 'qdlh07'),
('dklh19', N'16-1000', N'Học viên', 0.75, 'qdlh07'),
('dklh20', N'1-15', N'Học viên', 2.0, 'qdlh08'),
('dklh21', N'16-1000', N'Học viên', 1.0, 'qdlh08'),
('dklh22', N'', N'Đồ án', 15.0, 'qdlh09'),
('dklh23', N'', N'Tiểu luận', 4.0, 'qdlh10'),
('dklh24', N'', N'Học viên', 0.333333, 'qdlh11'),
('dklh25', N'', N'Học viên', 0.25, 'qdlh12'),
('dklh26', N'', N'Học viên', 0.5, 'qdlh13'),
('dklh27', N'Bài tập lớn, bài tập', N'BTL', 0.33333, 'qdlh14'),
('dklh28', N'Đồ án môn cơ sở, tiểu luận môn khoa học xã hội và nhân văn', N'DA(TL)', 0.5, 'qdlh14'),
('dklh29', N'Đồ án môn học chuyên ngành', N'BTL', 0.66666, 'qdlh14'),
('dklh30', N'Đồ án tốt nghiệp đại học', N'BTL', 5.0, 'qdlh14'),
('dklh31', N'', N'BTL', 0.2, 'qdlh15'),
('dklh32', N'', N'Buổi', 2.0, 'qdlh16'),
('dklh33', N'', N'Học phần', 15.0, 'qdlh17'),
('dklh34', N'Chủ tịch', N'Đề tài', 0.666666, 'qdlh18'),
('dklh35', N'Thư ký', N'Đề tài', 0.666666, 'qdlh18')



------------tinh ra mien giam cua mot giao vien
--truy van
SELECT * FROM dbo.GiaoVien

SELECT 
dbo.GiaoVien.TenGiaoVien,TenChucVuChinhQuyen,TenDonViChinhQuyen , dbo.DinhMucMienGiamChucVu.TyLeMienGiamThap 
FROM dbo.ChinhQuyen,dbo.DonViChinhQuyen,dbo.ChucVuChinhQuyen,dbo.GiaoVien_ChinhQuyen,dbo.GiaoVien,dbo.DinhMucMienGiamChucVu
WHERE 
ChinhQuyen.MaChucVuChinhQuyen = ChucVuChinhQuyen.MaChucVuChinhQuyen 
AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen
AND GiaoVien_ChinhQuyen.MaChinhQuyen = ChinhQuyen.MaChinhQuyen
AND GiaoVien.MaGiaoVien = GiaoVien_ChinhQuyen.MaGiaoVien
AND ChucVuChinhQuyen.MaDinhMucMienGiam= DinhMucMienGiamChucVu.MaDinhMucMienGiam


SELECT dbo.GiaoVien.TenGiaoVien , TenChucVuDang, TenDonViDang, dbo.DinhMucMienGiamChucVu.TyLeMienGiamThap,ThoiGianNhan FROM dbo.GiaoVien,dbo.GiaoVien_Dang,dbo.Dang,dbo.ChucVuDang,dbo.DonViDang,dbo.DinhMucMienGiamChucVu
WHERE GiaoVien.MaGiaoVien = GiaoVien_Dang.MaGiaoVien
AND Dang.MaDang = GiaoVien_Dang.MaDang
AND Dang.MaChucVuDang = ChucVuDang.MaChucVuDang
AND Dang.MaDonViDang = DonViDang.MaDonViDang
AND ChucVuDang.MaDinhMucMienGiam = DinhMucMienGiamChucVu.MaDinhMucMienGiam
AND GiaoVien.MaGiaoVien = 'gv0001'
SELECT * FROM dbo.GiaoVien,dbo.GiaoVien_GiamDacBiet,dbo.DinhMucGiamDacBiet
WHERE
GiaoVien.MaGiaoVien = GiaoVien_GiamDacBiet.MaGiaoVien
AND DinhMucGiamDacBiet.MaDinhMucGiamDacBiet= GiaoVien_GiamDacBiet.MaDinhMucGiamDacBiet
SELECT TenGiaoVien, ChucDanh.TenChucDanh , GioQuyDinhChungGiangDay,GioMonTheChatGiaoDucQuocPhong,ThoiGianNghienCuu,ThoiGianChuanNghienCuu FROM dbo.GiaoVien,dbo.GiaoVien_ChucDanh, dbo.ChucDanh,dbo.DinhMucChucDanh
WHERE dbo.GiaoVien.MaGiaoVien = GiaoVien_ChucDanh.MaGiaoVien
AND ChucDanh.MaChucDanh = GiaoVien_ChucDanh.MaChucDanh
AND ChucDanh.MaDinhMucChucDanh = DinhMucChucDanh.MaDinhMucChucDanh
SELECT * FROM dbo.DinhMucMienGiamChucVu
SELECT * FROM dbo.DinhMucGiamDacBiet
ALTER TABLE dbo.GiaoVien_ChinhQuyen ADD ThoiGianKetThuc DATE
ALTER TABLE dbo.GiaoVien_Dang ADD ThoiGianKetThuc DATE

------kiem tra trong khoang thoi gian nào thì trả về vị trí công tac trong nam

-----mien giam ve chuc vu
CREATE FUNCTION ThongKe_MGCVD(@magiaovien CHAR(20), @ThoiGian Date)
RETURNS @tb_MGCVD TABLE(
	 MaChucVu  CHAR(20),
	 TenChucVu nvarchar(50),
	 TenDonVi nvarchar(50),
	 TyLeMienGiam int,
	 ThoiGian Date
)
AS
BEGIN
    DECLARE @v_MaDang CHAR(20), @v_ThoiGianNhan DATE
	DECLARE CURSOR_Dang CURSOR FOR
	SELECT MaDang,ThoiGianNhan FROM dbo.GiaoVien_Dang
	WHERE MaGiaoVien = @magiaovien
	AND @ThoiGian > ThoiGianNhan
	OPEN CURSOR_Dang
	FETCH NEXT FROM CURSOR_Dang INTO @v_MaDang,@v_ThoiGianNhan
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    BEGIN
	        DECLARE @TenChucVu NVARCHAR(50),@TenDonVi NVARCHAR(50),@MaMienGiam CHAR(20),@TyLeMienGiam INT,
					@MaDonVi CHAR(20), @SoThanhVienTrongDonVi INT,@MaChucVu CHAR(20)
			-----Machucvu + ten chuc vu
			SELECT @TenChucVu = TenChucVuDang,@TenDonVi = TenDonViDang ,@MaMienGiam = MaDinhMucMienGiam,@MaDonVi= Dang.MaDonViDang,@MaChucVu =ChucVuDang.MaChucVuDang
			FROM dbo.Dang,dbo.DonViDang,dbo.ChucVuDang
			WHERE ChucVuDang.MaChucVuDang = Dang.MaChucVuDang
			AND Dang.MaDonViDang = DonViDang.MaDonViDang
			AND MaDang = @v_MaDang
			------ty le mien giam-------
			SELECT @SoThanhVienTrongDonVi = COUNT(MaDonViDang) FROM dbo.GiaoVien_Dang,dbo.Dang
			WHERE Dang.MaDang = GiaoVien_Dang.MaDang
			AND MaDonViDang = @MaDonVi
			GROUP BY MaDonViDang
			IF(@SoThanhVienTrongDonVi < 40) 
				BEGIN
				    SELECT @TyLeMienGiam = TyLeMienGiamThap FROM dbo.DinhMucMienGiamChucVu
					WHERE MaDinhMucMienGiam = @MaMienGiam
				END
			ELSE 
				BEGIN
					SELECT @TyLeMienGiam = TyLeMienGiamCao FROM dbo.DinhMucMienGiamChucVu
					WHERE MaDinhMucMienGiam = @MaMienGiam
				END
			----------------
			INSERT INTO @tb_MGCVD	(MaChucVu,TenChucVu,TenDonVi,TyLeMienGiam,ThoiGian)
			VALUES (@MaChucVu,@TenChucVu,@TenDonVi,@TyLeMienGiam,@v_ThoiGianNhan)
	    END
		FETCH NEXT FROM CURSOR_Dang INTO @v_MaDang,@v_ThoiGianNhan
	END
	DEALLOCATE CURSOR_Dang
	RETURN
END


SELECT * FROM ThongKe_MGCVD('gv0002','2015')

-------------Tinh mien giam về chức vụ----------------------------------
CREATE FUNCTION ThongKe_MGCVCQ(@magiaovien CHAR(20), @ThoiGian Date)
RETURNS @tb_MGCVCQ TABLE(
	 MaChucVu  CHAR(20),
	 TenChucVu nvarchar(50),
	 TenDonVi nvarchar(50),
	 TyLeMienGiam int,
	 ThoiGian Date
)
AS
BEGIN
    DECLARE @v_MaChinhQuyen CHAR(20), @v_ThoiGianNhan DATE
	DECLARE CURSOR_ChinhQuyen CURSOR FOR
	SELECT MaChinhQuyen,ThoiGianNhan FROM dbo.GiaoVien_ChinhQuyen
	WHERE MaGiaoVien = @magiaovien
	AND @ThoiGian > ThoiGianNhan
	OPEN CURSOR_ChinhQuyen
	FETCH NEXT FROM CURSOR_ChinhQuyen INTO @v_MaChinhQuyen,@v_ThoiGianNhan
	WHILE @@FETCH_STATUS = 0
	BEGIN
		BEGIN
		    DECLARE @TenChucVu NVARCHAR(50),@TenDonVi NVARCHAR(50),@MaMienGiam CHAR(20),@TyLeMienGiam INT,
					@MaDonVi CHAR(20), @SoThanhVienTrongDonVi INT,@MaChucVu CHAR(20)
			-----Machucvu + ten chuc vu-------
			SELECT @MaChucVu = ChinhQuyen.MaChucVuChinhQuyen, @TenChucVu = TenChucVuChinhQuyen, @TenDonVi = TenDonViChinhQuyen , @MaMienGiam = MaDinhMucMienGiam
			FROM dbo.ChinhQuyen,dbo.DonViChinhQuyen,dbo.ChucVuChinhQuyen
			WHERE MaChinhQuyen = @v_MaChinhQuyen
			AND ChinhQuyen.MaChucVuChinhQuyen = ChucVuChinhQuyen.MaChucVuChinhQuyen
			AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen
			--------------set ty le mien giam -----
			SELECT @SoThanhVienTrongDonVi = COUNT(MaDonViChinhQuyen) FROM dbo.GiaoVien_ChinhQuyen,dbo.ChinhQuyen
			WHERE ChinhQuyen.MaChinhQuyen = GiaoVien_ChinhQuyen.MaChinhQuyen
			AND ChinhQuyen.MaChinhQuyen = @v_MaChinhQuyen
			GROUP BY MaDonViChinhQuyen
			IF(@SoThanhVienTrongDonVi < 40) 
				BEGIN
				    SELECT @TyLeMienGiam = TyLeMienGiamThap FROM dbo.DinhMucMienGiamChucVu
					WHERE MaDinhMucMienGiam = @MaMienGiam
				END
			ELSE 
				BEGIN
					SELECT @TyLeMienGiam = TyLeMienGiamCao FROM dbo.DinhMucMienGiamChucVu
					WHERE MaDinhMucMienGiam = @MaMienGiam
				END
			INSERT INTO @tb_MGCVCQ	(MaChucVu,TenChucVu,TenDonVi,TyLeMienGiam,ThoiGian)
			VALUES (@MaChucVu,@TenChucVu,@TenDonVi,@TyLeMienGiam,@v_ThoiGianNhan)
		END
		FETCH NEXT FROM CURSOR_ChinhQuyen INTO @v_MaChinhQuyen,@v_ThoiGianNhan
	END
	DEALLOCATE CURSOR_ChinhQuyen
	RETURN
END

DROP FUNCTION ThongKe_MGCVCQ
SELECT * FROM ThongKe_MGCVCQ('gv0002','2015')

-------tinh tong so mien giam cua 1 giao vien trong nam ----
-------tinh so dinh muc giao duc va dinh muc khoa hoc cua giao vien 
------------------ham-----------------------

-----------------------Ham Thong ke bai bao cua 1 giao vien
CREATE FUNCTION ThongKe_BaiBao(@magiaovien CHAR(20))
RETURNS @tb_TaiBaiBao TABLE(
	MaBaiBao CHAR(20),
	TenBaiBao NVARCHAR(200),
	TenLoaiHinhCon NVARCHAR(200),
	VaiTroTrongBaiBao NVARCHAR(50),
	SoTacGia INT,
	SoGioChuan FLOAT,
	ThoiGianBatDau date,
	ThoiGianKetThuc date
) AS
BEGIN
	DECLARE @v_MaGiaoVien CHAR(20 ), @v_MaBaiBao CHAR(20),@v_MaLoaiHinhCon CHAR(20),@v_VaiTroTrongBaiBao INT ,@v_ThoiGianBatDau DATE,@v_ThoiGianKetThuc DATE
	DECLARE Cursor_BaiBao CURSOR FOR
	SELECT GiaoVien.MaGiaoVien AS MaGiaoVien, BaiBao.MaBaiBao AS MaBaiBao,MaLoaiHinhCon,VaiTroTrongBaiBao,ThoiGianBatDau,ThoiGianHoanThanh FROM dbo.GiaoVien,dbo.GiaoVien_BaiBao,dbo.BaiBao
	WHERE BaiBao.MaBaiBao = GiaoVien_BaiBao.MaBaiBao
	AND GiaoVien.MaGiaoVien = GiaoVien_BaiBao.MaGiaoVien
	AND GiaoVien.MaGiaoVien = @magiaovien

	OPEN Cursor_BaiBao
	FETCH NEXT FROM Cursor_BaiBao INTO @v_MaGiaoVien,@v_MaBaiBao,@v_MaLoaiHinhCon,@v_VaiTroTrongBaiBao,@v_ThoiGianBatDau,@v_ThoiGianKetThuc
	WHILE @@FETCH_STATUS = 0
	BEGIN
		BEGIN
			DECLARE @Tongchuan INT,@Sothanhvien INT, @Sogiochuan FLOAT,@TenBaiBao NVARCHAR(200),@TenLoaiHinhCon NVARCHAR(50),@VaiTro NVARCHAR(50)
			---dua ra cac thong so
			SELECT @Sothanhvien = COUNT(dbo.GiaoVien_BaiBao.MaBaiBao)  FROM dbo.GiaoVien_BaiBao
			WHERE MaBaiBao = @v_MaBaiBao
			GROUP BY dbo.GiaoVien_BaiBao.MaBaiBao
			SELECT @Tongchuan = GioChuan FROM dbo.LoaiHinhConNCKH
			WHERE MaLoaiHinhCon = @v_MaLoaiHinhCon
			SET @Sogiochuan = @Tongchuan / @Sothanhvien
			---set ten bai bao
			SELECT @TenBaiBao  = TenBaiBao FROM dbo.BaiBao
			WHERE MaBaiBao = @v_MaBaiBao
			----set ten loai hinh con
			SELECT @TenLoaiHinhCon = TenLoaiHinhCon FROM dbo.LoaiHinhConNCKH
			WHERE MaLoaiHinhCon = @v_MaLoaiHinhCon
			-----vai tro cua bai bao
			IF(@v_VaiTroTrongBaiBao = 1) SET @VaiTro = N'Chủ nhiệm'
			ELSE SET @VaiTro = N'Thành viên'
			-----
			INSERT INTO @tb_TaiBaiBao
			(MaBaiBao,TenBaiBao,TenLoaiHinhCon,VaiTroTrongBaiBao,SoTacGia,SoGioChuan,ThoiGianBatDau,ThoiGianKetThuc)
			VALUES	(@v_MaBaiBao,@TenBaiBao,@TenLoaiHinhCon,@VaiTro,@Sothanhvien,@Sogiochuan,@v_ThoiGianBatDau,@v_ThoiGianKetThuc)
		END
		FETCH NEXT FROM Cursor_BaiBao INTO @v_MaGiaoVien,@v_MaBaiBao,@v_MaLoaiHinhCon,@v_VaiTroTrongBaiBao,@v_ThoiGianBatDau,@v_ThoiGianKetThuc
	END
	CLOSE Cursor_BaiBao
	DEALLOCATE Cursor_BaiBao 
	RETURN
END
DROP FUNCTION ThongKe_BaiBao

SELECT TenBaiBao,TenLoaiHinhCon AS Loai,VaiTroTrongBaiBao AS VaiTro,SoGioChuan AS GioChuan FROM ThongKe_BaiBao('gv0001')
-------------------------Ham thong ke de tai nghien cua cua mot giao vien
CREATE FUNCTION ThongKe_DeTai(@magiaovienNCKH CHAR(20))
RETURNS @tb_TaiNCKH TABLE(
		MaDeTai CHAR(20),
		TenDeTai NVARCHAR(200),
		TenLoaiHinhCon NVARCHAR(200),
		VaiTroTrongNghienCuu NVARCHAR(50),
		SoThanhVien INT,
		SoGioChuan FLOAT,
		ThoiGianBatDau date,
		ThoiGianKetThuc date
	)
AS
BEGIN
    DECLARE @v_MagiaoVien CHAR(20), @v_MaDeTai CHAR(20), @v_MaLoaiHinhCon CHAR(20),@v_VaiTroTrongNghienCuu INT,@v_ThoiGianBatDau DATE,@v_ThoiGianKetThuc DATE
	DECLARE Cursor_NCKH CURSOR FOR
	SELECT MaGiaoVien,DeTaiNghienCuu.MaDeTai,MaLoaiHinhCon,VaiTroTrongNghienCuu,ThoiGianBatDau,ThoiGianHoanThanh FROM dbo.GiaoVien_NghienCuuKhoaHoc,dbo.DeTaiNghienCuu
	WHERE DeTaiNghienCuu.MaDeTai = GiaoVien_NghienCuuKhoaHoc.MaDeTai
	AND MaGiaoVien = @magiaovienNCKH
	OPEN Cursor_NCKH
	FETCH NEXT FROM Cursor_NCKH INTO @v_MaGiaoVien,@v_MaDeTai,@v_MaLoaiHinhCon,@v_VaiTroTrongNghienCuu,@v_ThoiGianBatDau,@v_ThoiGianKetThuc
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    BEGIN
	        DECLARE @TongChuan INT,@SoThanhVien INT , @SoGioChuan FLOAT , @TyLeChinh INT,
					@TenDeTai NVARCHAR(200),@VaiTro NVARCHAR(50), @TenLoaiHinhCon NVARCHAR(50)
			---dua ra cac thong so
			SELECT @SoThanhVien = COUNT(MaDeTai) FROM dbo.GiaoVien_NghienCuuKhoaHoc
			WHERE MaDeTai =  @v_MaDeTai
			GROUP BY MaDeTai
			----
			SELECT @TongChuan = GioChuan, @TyLeChinh = TyLeChinh FROM dbo.LoaiHinhConNCKH
			WHERE MaLoaiHinhCon = @v_MaLoaiHinhCon
			--- gio chuan cua mot giao vien
			IF(@TyLeChinh = 0)
				BEGIN
				    SET @SoGioChuan = @TongChuan / @SoThanhVien
				END
			ELSE 
				BEGIN
				    IF(@v_VaiTroTrongNghienCuu = 1)
						BEGIN
						     SET @SoGioChuan = (@TongChuan * @TyLeChinh) / 100 + ((@TongChuan * (100 - @TyLeChinh))/100)/@SoThanhVien 
							 SET @VaiTro =N'Chủ nhiệm đề tài'
						END 
					ELSE
						BEGIN
						    SET @SoGioChuan = ((@TongChuan * (100 - @TyLeChinh))/100)/@SoThanhVien 
							 SET @VaiTro =N'Thành viên tham gia' 
						END	
				END
			----set ten de tai
			SELECT @TenDeTai = TenDeTai FROM dbo.DeTaiNghienCuu
			WHERE MaDeTai = @v_MaDeTai
			---set ten loai hinh con
			SELECT @TenLoaiHinhCon = TenLoaiHinhCon FROM dbo.LoaiHinhConNCKH
			WHERE MaLoaiHinhCon = @v_MaLoaiHinhCon
			-----
			INSERT INTO @tb_TaiNCKH
			(MaDeTai,TenDeTai,TenLoaiHinhCon,VaiTroTrongNghienCuu,SoThanhVien, SoGioChuan,ThoiGianBatDau,ThoiGianKetThuc)
			VALUES (@v_MaDeTai,@TenDeTai,@TenLoaiHinhCon,@VaiTro,@SoThanhVien,@SoGioChuan,@v_ThoiGianBatDau,@v_ThoiGianKetThuc)
	    END
		FETCH NEXT FROM Cursor_NCKH INTO @v_MaGiaoVien,@v_MaDeTai,@v_MaLoaiHinhCon,@v_VaiTroTrongNghienCuu,@v_ThoiGianBatDau,@v_ThoiGianKetThuc
	END
	CLOSE Cursor_NCKH
	DEALLOCATE Cursor_NCKH
	RETURN
END
DROP FUNCTION ThongKe_Detai
SELECT TenDeTai,TenLoaiHinhCon , VaiTroTrongNghienCuu,SoThanhVien,SoGioChuan FROM ThongKe_Detai('gv0001')

SELECT * FROM dbo.GiaoVien_BaiBao
------------------------Thong ke ra cac sach mot giao vien bien soan
CREATE FUNCTION ThongKe_BienSoanSach(@magiaovienSach CHAR(20))
RETURNS @tb_TaiSach TABLE(
		MaSach CHAR(20),
		TenSach NVARCHAR(200),
		TenLoaiHinhCon NVARCHAR(200),
		VaiTroTrongBienSoan NVARCHAR(50),
		SoThanhVien INT,
		SoGioChuan FLOAT,
		ThoiGianBatDau date,
		ThoiGianKetThuc date

	)
AS
BEGIN
	DECLARE @v_MagiaoVien CHAR(20), @v_MaSach CHAR(20), @v_MaLoaiHinhCon CHAR(20),@v_VaiTroTrongBienSoan INT,@v_SoTrangViet INT , @v_ThoiGianBaiDau DATE,@v_ThoiGianKetThuc DATE
	DECLARE Cursor_Sach CURSOR FOR
	SELECT MaGiaoVien,BienSoanSach.MaSach,MaLoaiHinhCon,VaiTroTrongBienSoan, SoTrangViet,ThoiGianBatDau,ThoiGianKetThuc FROM dbo.GiaoVien_BienSoanSach,dbo.BienSoanSach
	WHERE BienSoanSach.MaSach = GiaoVien_BienSoanSach.MaSach
	AND MaGiaoVien = @magiaovienSach
	OPEN Cursor_Sach
	FETCH NEXT FROM Cursor_Sach INTO @v_MaGiaoVien,@v_MaSach,@v_MaLoaiHinhCon,@v_VaiTroTrongBienSoan,@v_SoTrangViet,@v_ThoiGianBaiDau,@v_ThoiGianKetThuc
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    BEGIN
	        DECLARE @TongChuan INT,@SoThanhVien INT , @SoGioChuan FLOAT , @TyLeChinh INT,
					@TenSach NVARCHAR(200),@VaiTro NVARCHAR(50), @TenLoaiHinhCon NVARCHAR(50),
					@DonViTinh NVARCHAR(50), @SoTrang INT
			---set ten va so trang
			SELECT @TenSach = TenSach,@SoTrang = SoTrang FROM dbo.BienSoanSach
			WHERE MaSach = @v_MaSach
			--------dua ra cac thong so
			SELECT @SoThanhVien = COUNT(MaSach) FROM dbo.GiaoVien_BienSoanSach
			WHERE MaSach = @v_MaSach
			GROUP BY MaSach	
			----
			SELECT @TongChuan = GioChuan, @TyLeChinh = TyLeChinh FROM dbo.LoaiHinhConNCKH
			WHERE MaLoaiHinhCon = @v_MaLoaiHinhCon
			--- gio chuan cua mot giao vien
			IF(@TyLeChinh = 0)
				BEGIN
				    SET @SoGioChuan = @v_SoTrangViet * @TongChuan
					IF(@v_VaiTroTrongBienSoan = 1)  SET @VaiTro =N'Tác giả chính'
					ELSE SET @VaiTro =N'Thành Viên Tham Gia'
				END
			ELSE 
				BEGIN
				    IF(@v_VaiTroTrongBienSoan = 1)
						BEGIN
						     SET @SoGioChuan = (@TongChuan * @TyLeChinh) / 100 + ((@TongChuan * (100 - @TyLeChinh))/100)/@SoThanhVien 
							 SET @VaiTro =N'Tác giả chính'
						END 
					ELSE
						BEGIN
						    SET @SoGioChuan = ((@TongChuan * (100 - @TyLeChinh))/100)/@SoThanhVien 
							 SET @VaiTro =N'Thành viên tham gia' 
						END	
				END
		
			---set ten loai hinh con
			SELECT @TenLoaiHinhCon = TenLoaiHinhCon FROM dbo.LoaiHinhConNCKH
			WHERE MaLoaiHinhCon = @v_MaLoaiHinhCon
			-----
			INSERT INTO @tb_TaiSach
			(MaSach,TenSach,TenLoaiHinhCon,VaiTroTrongBienSoan,SoThanhVien,SoGioChuan,ThoiGianBatDau,ThoiGianKetThuc)
			VALUES
			(@v_MaSach,@TenSach,@TenLoaiHinhCon,@VaiTro,@SoThanhVien,@SoGioChuan,@v_ThoiGianBaiDau,@v_ThoiGianKetThuc)
	    END
		FETCH NEXT FROM Cursor_Sach INTO @v_MaGiaoVien,@v_MaSach,@v_MaLoaiHinhCon,@v_VaiTroTrongBienSoan,@v_SoTrangViet,@v_ThoiGianBaiDau,@v_ThoiGianKetThuc
	END
	CLOSE Cursor_Sach
	DEALLOCATE Cursor_Sach   
	RETURN
END
DROP FUNCTION dbo.ThongKe_BienSoanSach
SELECT TenSach,TenLoaiHinhCon,VaiTroTrongBienSoan AS VaiTro,SoThanhVien,SoGioChuan AS GioChuan FROM ThongKe_BienSoanSach('gv0005') 

-------------------------------tra ve tong tai cua giao vien do----------------
CREATE FUNCTION Tong(@magiaovien CHAR(20))
RETURNS INTEGER
AS
BEGIN
    DECLARE @Sum INT, @Sum_bb INT,@Sum_dt INT, @Sum_s INT
	SET @Sum = 0
	SET @Sum_bb = 0
	SET @Sum_dt = 0
	SET @Sum_s = 0
	SELECT @Sum_bb = SUM(SoGioChuan) FROM dbo.ThongKe_BaiBao(@magiaovien)
	SELECT @Sum_dt = SUM(SoGioChuan) FROM dbo.ThongKe_DeTai(@magiaovien)
	SELECT @Sum_s = SUM(SoGioChuan) FROM dbo.ThongKe_BienSoanSach(@magiaovien)
	IF(@Sum_bb IS NULL)  SET @Sum_bb = 0
	IF(@Sum_dt IS NULL) SET @Sum_dt = 0
	IF(@Sum_s IS NULL) SET @Sum_s = 0
	SET @Sum = @Sum_bb + @Sum_dt + @Sum_s
	RETURN @Sum
END
DROP FUNCTION dbo.Tong

PRINT  dbo.Tong('gV0005')

SELECT	TenDonViChinhQuyen,TenGiaoVien, dbo.Tong(GiaoVien.MaGiaoVien) FROM dbo.GiaoVien,dbo.GiaoVien_ChinhQuyen,dbo.ChinhQuyen,dbo.DonViChinhQuyen
WHERE GiaoVien.MaGiaoVien = GiaoVien_ChinhQuyen.MaGiaoVien
AND ChinhQuyen.MaChinhQuyen = GiaoVien_ChinhQuyen.MaChinhQuyen
AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen


CREATE PROCEDURE TongTaiNCKH
AS 
BEGIN
    SELECT	TenDonViChinhQuyen AS [Tên đơn vị], SUM(dbo.Tong(GiaoVien.MaGiaoVien)) AS [Số giờ chuẩn đã thực hiện]  FROM dbo.GiaoVien,dbo.GiaoVien_ChinhQuyen,dbo.ChinhQuyen,dbo.DonViChinhQuyen
	WHERE GiaoVien.MaGiaoVien = GiaoVien_ChinhQuyen.MaGiaoVien
	AND ChinhQuyen.MaChinhQuyen = GiaoVien_ChinhQuyen.MaChinhQuyen
	AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen
GROUP BY TenDonViChinhQuyen
END
DROP PROCEDURE TongTaiNCKH
EXEC TongTaiNCKH

SELECT * FROM dbo.DonViChinhQuyen

------dua ra tai giang day va tai nghien cuu khoa hoc cua mot giao vien
DROP DATABASE QUAN_LY_GIAO_VIEN