CREATE DATABASE QUAN_LY_GIAO_VIEN
USE QUAN_LY_GIAO_VIEN

----------------tao bang----
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
-----
CREATE TABLE ChinhQuyen(
	MaChinhQuyen CHAR(20) PRIMARY KEY,
	MaChucVuChinhQuyen CHAR(20),
	MaDonViChinhQuyen CHAR(20)
)
GO
----
CREATE TABLE Dang(
	MaDang CHAR(20) PRIMARY KEY,
	MaDonViDang CHAR(20),
	MaChucVuDang CHAR(20)
)
GO
--------------
CREATE TABLE DonViChinhQuyen(
	MaDonViChinhQuyen CHAR(20) PRIMARY KEY,
	TenDonViChinhQuyen NVARCHAR(200)
)
GO
---------------
CREATE TABLE ChucVuChinhQuyen(
	MaChucVuChinhQuyen CHAR(20) PRIMARY KEY,
	TenChucVuChinhQuyen NVARCHAR(50),
	MaDinhMucMienGiam CHAR(20)
)
GO
---------------
CREATE TABLE DonViDang(
	MaDonViDang CHAR(20) PRIMARY KEY,
	TenDonViDang NVARCHAR(200)
)
GO
-----------------------
CREATE TABLE ChucVuDang(
	MaChucVuDang CHAR(20) PRIMARY KEY,
	TenChucVuDang NVARCHAR(50),
	MaDinhMucMienGiam CHAR(20)
)
GO
--------------------
DROP TABLE GiaoVien_ChinhQuyen
CREATE TABLE GiaoVien_ChinhQuyen(
	MaGiaoVien CHAR(20),
	MaChinhQuyen CHAR(20),
	ThoiGianNhan DATE,
	ThoiGianKetThuc DATE
)
GO
---------------
DROP TABLE GiaoVien_Dang
CREATE TABLE GiaoVien_Dang(
	MaGiaoVien CHAR(20),
	MaDang CHAR(20),
	ThoiGianNhan DATE,
	ThoiGianKetThuc DATE
)
GO
--------------
CREATE TABLE HocVi(
	MaHocVi CHAR(20)PRIMARY KEY,
	TenHocVi NVARCHAR(200)
)
GO
----------------
CREATE TABLE GiaoVien_HocVi(
	MaGiaoVien CHAR(20),
	MaHocVi CHAR(20),
	ThoiGianNhan DATE
)
GO
-----------------------
CREATE TABLE HocHam(
	MaHocHam CHAR(20)PRIMARY KEY,
	TenHocHam NVARCHAR(200),
	MaDinhMucChucDanh CHAR(20)
)
GO
----------------
CREATE TABLE GiaoVien_HocHam(
	MaGiaoVien CHAR(20),
	MaHocHam CHAR(20),
	ThoiGianNhan DATE
)
GO
-------------------------
CREATE TABLE ChucDanh(
	MaChucDanh CHAR(20)PRIMARY KEY,
	TenChucDanh NVARCHAR(200),
	MaDinhMucChucDanh CHAR(20)
)
GO
----------------
CREATE TABLE GiaoVien_ChucDanh(
	MaGiaoVien CHAR(20),
	MaChucDanh CHAR(20),
	ThoiGianNhanBatDau DATE,
	ThoiGianNhanKetThuc DATE
)
GO
-----------------------
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
DROP TABLE dbo.DinhMucGiamDacBiet
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
	ThoiGianBatDau DATE,
	ThoiGianKetThuc DATE

	PRIMARY KEY (MaGiaoVien,MaDinhMucGiamDacBiet)
)
DROP TABLE dbo.GiaoVien_GiamDacBiet

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
-----------------------------------------------
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

CREATE TABLE GiaoVien_NghienCuuKhoaHoc(
  MaGiaoVien CHAR(20),
  MaDeTai CHAR(20),
  ThoiGianBatDau DATE,
  ThoiGianHoanThanh DATE,
  VaiTroTrongNghienCuu INT

)
GO
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
-------------------------------------------------------------------------


SELECT GiaoVien.MaGiaoVien,TenGiaoVien,TenDonViChinhQuyen FROM GiaoVien_ChinhQuyen,ChinhQuyen,DonViChinhQuyen,GiaoVien
WHERE ChinhQuyen.MaChinhQuyen = GiaoVien_ChinhQuyen.MaChinhQuyen
AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen
AND GiaoVien_ChinhQuyen.MaGiaoVien = GiaoVien.MaGiaoVien

---------------------
create table He(
MaHe char(20) primary key,
TenHe nvarchar(200),
Machuongtrinhdaotao char(20)
)

create table Khoa(
MaKhoa char(20) primary key,
TenKhoa nvarchar(200)
)


create table chuongtrinhdaotao(
Machuongtrinhdaotao char(20),
Tenchuongtrinhdaotao nvarchar(200),
primary key(Machuongtrinhdaotao)
)

-- tao lop ----

go
create table Lop(
MaLop char(20) primary key,
TenLop nvarchar(200),
SiSo int,
MaHe char(20), 

)

go
create table HocVien(
MaHocVien char(20) primary key,
TenHocVien nvarchar(200),
MaLop char(20)
)

go
-- tao bo mon -- 
create table BoMon(
MaBoMon char(20) primary key,
TenBoMon nvarchar(200),
MaKhoa char(20), 
)

go
create table HocPhan(
MaHocPhan char(20) primary key,
TenHocPhan nvarchar(200),
SoTinChi int,
SoTiet int,
MaBoMon char(20), 
MaLoaiHinhCon char(20)
)
 
go
create table CacLoaiHinhDaoTao(
MaLoaiHinhDaoTao char(20) primary key,
TenLoaiHinhDaoTao nvarchar(200)
)
go

create table QuyDoiLoaiHinh(
MaLoaiHinhCon char(20) primary key,
TenLoaiHinhCon nvarchar(200),
MaLoaiHinhDaoTao char(20), 
)
go
create table DieuKienLoaiHinh(
DieuKienLoaiHinh char(20) primary key,
DieuKien nvarchar(200),
DonViTinh nvarchar(200),
QuyRaGioChuan float,
MaLoaiHinhCon char(20), 
)


-- tao bang lop hoc --
go
create table LopHoc(
MaLopHoc char(20) ,
TenLopHoc nvarchar(200),
CSN_CN char(20),
HocKy nvarchar(200),
MaLop char(20), 
MaHocPhan char(20), 
MaQuyDoi char(20) NULL, 
primary key (MaLopHoc)
)

go
create table HocPhanChamThi(
MaHocPhanChamThi char(20),
SoBai int,
MaLopHoc char(20) NULL, 
MaQuyDoi char(20) NULL, 
GhiChu nvarchar(200) NULL,
primary key (MaHocPhanChamThi)
)

go 


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
go 


create table GiaoVien_LopHoc(
GiaoVien_LopHoc char(20) primary key,
MaGiaoVien char(20) ,
MaLopHoc  char(20),
ThoiGianBatDau datetime,
ThoiGianKetThuc datetime,
)

go
create table GiaoVien_HocPhanChamThi(
GiaoVien_HocPhanChamThi char(20) primary key,
MaGiaoVien char(20) ,
MaHocPhanChamThi  char(20),
ThoiGianBatDau datetime,
ThoiGianKetThuc datetime,
)

go 

create table GiaoVien_HuongDan(
GiaoVien_HuongDan char(20) primary key,
MaGiaoVien char(20) ,
MaHuongDan  char(20),
ThoiGianBatDau datetime,
ThoiGianKetThuc datetime,
)


go
ALTER TABLE HocVien
ADD CONSTRAINT FK_LopHocVien
FOREIGN KEY (MaLop) REFERENCES Lop(MaLop);

go 


ALTER TABLE HocPhan
ADD CONSTRAINT FK_QuyDoiLoaiHinhHocPhan
FOREIGN KEY (MaLoaiHinhCon) REFERENCES QuyDoiLoaiHinh(MaLoaiHinhCon);

go
ALTER TABLE LopHoc
ADD CONSTRAINT FK_DieuKienLopHoc
FOREIGN KEY (MaQuyDoi) REFERENCES DieuKienLoaiHinh(DieuKienLoaiHinh);

go
ALTER TABLE LopHoc
ADD CONSTRAINT FK_LopLopHoc
FOREIGN KEY (MaLop) REFERENCES Lop(MaLop);

go
ALTER TABLE LopHoc
ADD CONSTRAINT FK_HocPhanLopHoc
FOREIGN KEY (MaHocPhan) REFERENCES HocPhan(MaHocPhan);

go
ALTER TABLE HocPhanChamThi
ADD CONSTRAINT FK_LopHocHocPhanChamThi
FOREIGN KEY (MaLopHoc) REFERENCES LopHoc(MaLopHoc);
go

ALTER TABLE HocPhanChamThi
ADD CONSTRAINT FK_DieuKienHocPhanChamThi
FOREIGN KEY (MaQuyDoi) REFERENCES DieuKienLoaiHinh(DieuKienLoaiHinh);

ALTER TABLE HuongDan
ADD CONSTRAINT FK_HocVienHuongDan
FOREIGN KEY (MaHocVien) REFERENCES HocVien(MaHocVien);

go 
ALTER TABLE HuongDan
ADD CONSTRAINT FK_DieuKienHuongDan
FOREIGN KEY (MaQuyDoi) REFERENCES QuyDoiLoaiHinh(MaLoaiHinhCon);



go 


ALTER TABLE He
ADD CONSTRAINT FK_CTDTHe
FOREIGN KEY (Machuongtrinhdaotao) REFERENCES chuongtrinhdaotao(Machuongtrinhdaotao);
go 

ALTER TABLE BoMon
ADD CONSTRAINT FK_KhoaBoMon
FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa);

go 
ALTER TABLE HocPhan
ADD CONSTRAINT FK_BoMonHocPhan
FOREIGN KEY (MaBoMon) REFERENCES BoMon(MaBoMon);

go 
ALTER TABLE QuyDoiLoaiHinh
ADD CONSTRAINT FK_LoaiHinhDaoTao_QuyDoiLoaiHinh
FOREIGN KEY (MaLoaiHinhDaoTao) REFERENCES CacLoaiHinhDaoTao(MaLoaiHinhDaoTao);

go 
ALTER TABLE DieuKienLoaiHinh
ADD CONSTRAINT FK_QuyDoiLoaiHinh_DieuKienLoaiHinh
FOREIGN KEY (MaLoaiHinhCon) REFERENCES QuyDoiLoaiHinh(MaLoaiHinhCon);


go 
ALTER TABLE GiaoVien_LopHoc
ADD CONSTRAINT FK_GiaoVien_LopHoc
FOREIGN KEY (MaGiaoVien) REFERENCES GiaoVien(MaGiaoVien);

go
ALTER TABLE GiaoVien_LopHoc
ADD CONSTRAINT FK_LopHoc_GiaoVien
FOREIGN KEY (MaLopHoc) REFERENCES LopHoc(MaLopHoc);

-- them khoa phu giao vien cham thi --
go 
ALTER TABLE GiaoVien_HocPhanChamThi
ADD CONSTRAINT FK_GiaoVien_GiaoVienHocPhanChamThi
FOREIGN KEY (MaGiaoVien) REFERENCES GiaoVien(MaGiaoVien);


go
ALTER TABLE GiaoVien_HocPhanChamThi
ADD CONSTRAINT FK_HocPhanChamThi_GiaoVienHocPhanChamThi
FOREIGN KEY (MaHocPhanChamThi) REFERENCES HocPhanChamThi(MaHocPhanChamThi);

-- them khoa phu giao vien huong dan 
go 
ALTER TABLE GiaoVien_HuongDan
ADD CONSTRAINT FK_GiaoVien_HuongDan
FOREIGN KEY (MaGiaoVien) REFERENCES GiaoVien(MaGiaoVien);


go
ALTER TABLE dbo.GiaoVien_HuongDan
ADD CONSTRAINT FK_HuongDan_GiaoVien
FOREIGN KEY (MaHuongDan) REFERENCES HuongDan(MaHuongDan);



-- them key phu cho lop --

ALTER TABLE Lop
ADD CONSTRAINT FK_HeLop
FOREIGN KEY (MaHe) REFERENCES He(MaHe);
