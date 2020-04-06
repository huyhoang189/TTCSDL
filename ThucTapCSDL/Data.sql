CREATE DATABASE Quan_ly_Giao_Vien
go
USE Quan_ly_Giao_Vien
go

--1.Giao Vien
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
--phan 1 
-- 2. Chinh quyen
CREATE TABLE ChinhQuyen(
	MaChinhQuyen CHAR(20),
	MaChucVuChinhQuyen CHAR(20),
	MaDonViChinhQuyen CHAR(20)
)
GO
-- 3. Dang
CREATE TABLE Dang(
	MaDang CHAR(20),
	MaDonViDang CHAR(20),
	MaChucVuDang CHAR(20)
	PRIMARY KEY (MaDang)
)
GO
-- 4. Don Vi chinh quyen
CREATE TABLE DonViChinhQuyen(
	MaDonViChinhQuyen CHAR(20),
	TenDonViChinhQuyen NVARCHAR(50)
	PRIMARY KEY( MaDonViChinhQuyen)
)
GO

-- 5 . Chuc vu chinh quyen
CREATE TABLE ChucVuChinhQuyen(
	MaChucVuChinhQuyen CHAR(20) PRIMARY KEY,
	TenChucVuChinhQuyen NVARCHAR(50),
	MaDinhMucMienGiam CHAR(20)
)
GO
-- 6 - Don Vi Dang
CREATE TABLE DonViDang(
	MaDonViDang CHAR(20) PRIMARY KEY,
	TenDonViDang NVARCHAR(50)
)
GO
-- 7. Chuc vu Dang
CREATE TABLE ChucVuDang(
	MaChucVuDang CHAR(20) PRIMARY KEY,
	TenChucVuDang NVARCHAR(50),
	MaDinhMucMienGiam CHAR(20)

)
GO
-- 8. Giao vien tham gia vao chuc vu chinh quyen
CREATE TABLE GiaoVien_ChinhQuyen(
	MaGiaoVien CHAR(20),
	MaChinhQuyen CHAR(20),
	ThoiGianNhan DATE
	PRIMARY KEY (MaGiaoVien ,MaChinhQuyen)
)
GO
-- 9  giao vien tham gia cong tac ben dang
CREATE TABLE GiaoVien_Dang(
	MaGiaoVien CHAR(20),
	MaDang CHAR(20),
	ThoiGianNhan DATE
	PRIMARY KEY(MaGiaoVien,MaDang)
)
GO
--9. hoc vi
CREATE TABLE HocVi(
	MaHocVi CHAR(20)PRIMARY KEY,
	TenHocVi NVARCHAR(200)
)
GO
--10 . Giao vien co hoc vi
CREATE TABLE GiaoVien_HocVi(
	MaGiaoVien CHAR(20),
	MaHocVi CHAR(20),
	ThoiGianNhan DATE
	PRIMARY KEY(MaGiaoVien , MaHocVi)
)
GO
--11. Hoc ham 
CREATE TABLE HocHam(
	MaHocHam CHAR(20)PRIMARY KEY,
	TenHocHam NVARCHAR(50)
)
GO
--12. Giao vien co hoc ham
CREATE TABLE GiaoVien_HocHam(
	MaGiaoVien CHAR(20),
	MaHocHam CHAR(20),
	ThoiGianNhan DATE
	PRIMARY KEY (MaGiaoVien ,MaHocHam)
)
GO
-- 13. Chuc danh
CREATE TABLE ChucDanh(
	MaChucDanh CHAR(20)PRIMARY KEY,
	TenChucDanh NVARCHAR(50)

)
GO
--14. Giao vien co chuc danh
CREATE TABLE GiaoVien_ChucDanh(
	MaGiaoVien CHAR(20),
	MaChucDanh CHAR(20),
	ThoiGianNhanBatDau DATE,
	ThoiGianNhanKetThuc DATE
	PRIMARY KEY (MaGiaoVien,MaChucDanh)
)
GO
--15. Ngoai ngu
CREATE TABLE NgoaiNgu(
	MaNgoaiNgu CHAR(20)PRIMARY KEY,
	TenNgoaiNgu NVARCHAR(50)
)
GO
--16. Giao vien co cac loai ngoai ngu
CREATE TABLE GiaoVien_NgoaiNgu(
	MaGiaoVien CHAR(20),
	MaNgoaiNgu CHAR(20),
	ThoiGianNhan DATE,
	TrinhDo CHAR(20)
	PRIMARY KEY (MaGiaoVien,MaNgoaiNgu)
)
GO
--17. Huong nghien cuu 
CREATE TABLE HuongNghienCuu(
	MaHuongNghienCuu CHAR(20) PRIMARY KEY,
	TenHuongNghienCuu NVARCHAR(200)
)
GO
--18. Huong nghien cuu cua giao vien trong tung giai doan
CREATE TABLE GiaoVien_HuongNghienCuu(
	MaGiaoVien CHAR(20),
	MaHuongNghienCuu CHAR(20),
	ThoiGianBatDau DATE,
	ThoiGianKetThuc DATE
	PRIMARY KEY (MaGiaoVien,MaHuongNghienCuu)
)
GO
--19. Cac khen thuong ky luat
CREATE TABLE KhenThuongKyLuat(
	MaKhenThuongKyLuat CHAR(20)PRIMARY KEY,
	TenKhenThuongKyLuat NVARCHAR(50),
	Loai NVARCHAR(50)
)
GO
--20. Giao vien duoc khen thuong ky luat
CREATE TABLE GiaoVien_KhenThuongKyLuat(
	MaGiaoVien CHAR(20),
	MaKhenThuongKyLuat CHAR(20),
	TenKhenThuongKyLuatNhan NVARCHAR(200),
	ThoiGianNhan DATE
	PRIMARY KEY (MaGiaoVien,MaKhenThuongKyLuat)
)
GO
--21. Qua trinhf dao tao cua mot giao vien
CREATE TABLE QuaTrinhDaoTao(
	MaGiaoVien CHAR(20),
	MaQuaTrinhDaoTao CHAR(20)
	PRIMARY KEY (MaQuaTrinhDaoTao)
)
GO
--22. Dao tao dai hoc
CREATE TABLE DaoTaoDaiHoc(
	MaDaoTaoDaiHoc CHAR(20)PRIMARY KEY,
	HeDaoTao NVARCHAR(200),
	NoiDaoTao NVARCHAR(200),
	NuocDaoTao NVARCHAR(200),
	NganhDaoTao NVARCHAR(200),
	ThoiGianDaoTao CHAR(10)
)
GO
--23. Dao tao sau dai hoc
CREATE TABLE DaoTaoSauDaiHoc(
	MaDaoTaoSauDaiHoc CHAR(20)PRIMARY KEY,
	LoaiDaoTao NVARCHAR(200),
	NoiDaoTao NVARCHAR(200),
	ThoiGianDaoTao DATE
)
GO
--24. Dao tao khac
CREATE TABLE DaoTaoKhac(
	MaDaoTaoKhac CHAR(20),
	MaDaoTaoSauDaiHoc CHAR(20),
	GhiChu NVARCHAR(200)
)
GO
--25. Qua trinh dao tao dai hoc cua motj giao vien
CREATE TABLE QuaTrinhDaoTao_DaoTaoDaiHoc(
	MaQuaTrinhDaoTao CHAR(20),
	MaDaoTaoDaiHoc CHAR(20),
	NamTotNghiep DATE
)
GO
--26. Qua trinh dao tao sau dai hoc
CREATE TABLE QuaTrinhDaoTao_DaoTaoSauDaiHoc(
	MaQuaTrinhDaoTao CHAR(20),
	MaDaoTaoSauDaiHoc CHAR(20),
	NamTotNghiep DATE,
	TenDeAnTotNghiep NVARCHAR(200)
)
--27. Dinh muc giam dac biet 
GO
CREATE TABLE DinhMucGiamDacBiet(
	MaDinhMucGiamDacBiet CHAR(20)PRIMARY KEY,
	TenDinhMucGiam NVARCHAR(200),
	TyLeGiam FLOAT
)
GO
--28. Dinh muc chuc danh
CREATE TABLE DinhMucChucDanh(
	MaDinhMucChucDanh CHAR(20)PRIMARY KEY,
	QuyDinhChungGiangDay NVARCHAR(200),
	MonTheChatGiaoDucQuocPhong NVARCHAR(200),
	ThoiGianNghienCuu INT,
	ThoiGianChuanNghienCuu INT,
)
GO
--29. Dinh muc mien giam
CREATE TABLE DinhMucMienGiamChucVu(
	MaDinhMucMienGiam CHAR(20)PRIMARY KEY,
	TyLeMienGiam FLOAT,
)
GO
--30. Dinh Muc Giam Dac Biet
CREATE TABLE GiaoVien_GiamDacBiet
(
    MaGiaoVien CHAR(20),
	MaDinhMucMienGiamDacBiet CHAR(20),
	ThoiGianMienGiam DATE
	PRIMARY KEY (MaGiaoVien,MaDinhMucMienGiamDacBiet)
)
--31. Yeu cau dinh muc cua cac muc giam dac biet 

--32. Yeu cau dinh muc cac muc mien giam binh thuoc

--33. Giao vien voi cac yeu cau dinh muc mien giam


--phan nghien cuu khoa hoc
--34. Bai bao 
CREATE TABLE BaiBao(
  MaBaiBao CHAR(20),
  MaLoaiHinhCon CHAR(20),
  TenBaiBao NVARCHAR(200),
  SoLuongTacGia INT,
  ThoiGian DATE
  PRIMARY KEY(MaBaiBao)
)
GO
--35. De tai nghien cuu
CREATE TABLE DeTaiNghienCuu(
  MaDeTai CHAR(20),
  TenDeTai NVARCHAR(200),
  SoLuongThanhVien INT,
  MaLoaiHinhCon CHAR(20)
  PRIMARY KEY (MaDeTai)
)
GO
--36. Bien Soan sach
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
--37. Giao vien tham gia viet bao
CREATE TABLE GiaoVien_BaiBao(
  MaGiaoVien CHAR(20),
  MaBaiBao CHAR(20),
  ThoiGianBatDau DATE,
  ThoiGianHoanThanh DATE,
  VaiTroTrongBaiBao INT
  PRIMARY KEY(MaGiaoVien,MaBaiBao)
)
GO
--38. Giao vien tham gia nghien cuu khoa hoc
CREATE TABLE GiaoVien_NghienCuuKhoaHoc(
  MaGiaoVien CHAR(20),
  MaDeTai CHAR(20),
  ThoiGianBatDau DATE,
  ThoiGianHoanThanh DATE,
  VaiTroTrongNghienCuu INT
  PRIMARY KEY(MaGiaoVien,MaDeTai)
)
GO
--39. giao vien tham gia bien soan sach
CREATE TABLE GiaoVien_BienSoanSach(
  MaGiaoVien CHAR(20),
  MaSach CHAR(20),
  ThoiGianBatDau DATE,
  ThoiGianKetThuc DATE,
  VaiTroTrongBienSoan INT
  PRIMARY KEY (MaGiaoVien,MaSach)
)
GO
--40. Loai hinh chinh cua quy chuan
CREATE TABLE LoaiHinhChinhNCKH(
  MaLoaiHinhChinh CHAR(20),
  TenLoaiHinhChinh NVARCHAR(50)
  PRIMARY KEY(MaLoaiHinhChinh)
)
GO
--41. Loai hinh con trong quy chuan
CREATE TABLE LoaiHinhConNCKH(
  MaLoaiHinhCon CHAR(20),
  TenLoaiHinhCon NVARCHAR(200),
  DonViTinh NVARCHAR(10),
  GioChuan INT ,
  MaLoaiHinhChinh CHAR(20)
  PRIMARY KEY(MaLoaiHinhCon)

)
GO
--42. Du An
CREATE TABLE DuAn(
  MaDuAn CHAR(20),
  TenDuAn NVARCHAR(200),
  MoTa NVARCHAR(200),
  MaCoQuanQuanLy CHAR(20),
  TinhTrang INT -- 1 or 0
  PRIMARY KEY(MaDuAn)
)
GO
--43. Giao vien tham gia du an
CREATE TABLE GiaoVien_DuAn(
  MaGiaoVien CHAR(20),
  MaDuAn CHAR(20),
  ThoiGianBatDau DATE,
  ThoiGianHoanThanh DATE,
  VaiTroTrongDuAn INT -- 1 or 0
  PRIMARY KEY(MaGiaoVien,MaDuAn)
	
)
GO
--44. Giai thuong
CREATE TABLE GiaiThuong(
  MaGiaiThuong CHAR(20),
  TenGiaiThuong NVARCHAR(200),
  PhamVi NVARCHAR(200),
  NoiCap NVARCHAR(200),
  ToChucTraoThuong NVARCHAR(200)
  PRIMARY KEY(MaGiaiThuong)
)
GO
--45.Du an duoc giai thuong
CREATE TABLE DuAn_GiaiThuong(
  MaDuAn CHAR(20),
  MaGiaiThuong CHAR(20),
  ThoigianNhan DATE
  PRIMARY KEY(MaDuAn,MaGiaiThuong)
)
GO
--46. Du an duoc dang ki bang su huu
CREATE TABLE DangKiBangSoHuu(
  MaBangSangChe CHAR(20),
  SoHieu CHAR(20),
  ThoiGianCap DATE,
  PhamVi NVARCHAR(200),
  NoiCap NVARCHAR(200),
  MaDuAn CHAR(20)
  PRIMARY KEY(MaBangSangChe)
)
GO
--47.Du an duoc ap dung thuc tien
CREATE TABLE ApDungThucTien(
  MaApDungThucTien CHAR(20),
  HieuQuaThucTien NVARCHAR(200),
  DiaChiApDung NVARCHAR(200),
  QuyMoApDung NVARCHAR(200),
  HinhThucApDung NVARCHAR(200),
  ThoiGianApDung DATE,
  MaDuAn CHAR(20)
  PRIMARY KEY(MaApDungThucTien)
)
GO

--phan giang day
--48. Hoc vien
CREATE TABLE HocVien
(
     MaHocVien CHAR(20),
	 TenHocVien NVARCHAR(30),
	 PRIMARY KEY (MaHocVien)
)
GO
--49. He
CREATE TABLE He
(
    MaHe CHAR(20),
	TenHe NVARCHAR(20),
	PRIMARY KEY (MaHe)
)
GO
--50. Khoa
CREATE TABLE Khoa
(
    MaKhoa CHAR(20),
	TenKhoa NVARCHAR(20),
	PRIMARY KEY (MaKhoa)
)
GO
--60. Bo Mon
CREATE TABLE BoMon
(
    MaBoMon CHAR(20),
	TenBoMon NVARCHAR(20),
	MaKhoa NVARCHAR(20)
	PRIMARY KEY (MaBoMon)
)
GO
--61. Giao vien co the thuoc nhieu bo mon khac nhau trong khoang thoi gian khac nhau
CREATE TABLE GiaoVien_BoMon
(
    MaGiaoVien NCHAR(20),
	MaBoMon NCHAR(20),
	ThoiGianBatDauCongTac DATE,
	ThoiGianKetThucCongTac DATE
	PRIMARY KEY (MaGiaoVien,MaBoMon)
)
GO
--62. Lop
CREATE TABLE Lop
(
    MaLop CHAR(20),
	TenLop NVARCHAR(20),
	SiSo INT,
	MaHe CHAR(20),
	PRIMARY KEY ( MaLop)
)
GO
--63. Hoc Phan
CREATE TABLE HocPhan
(
     MaHocPhan CHAR(20),
	 TenHocPhan NVARCHAR(20),
	 SoTinChi INT,
	 SoTiet INT,
	 MaBoMon CHAR(20)
	 PRIMARY KEY (MaHocPhan)
)

--64. Loai hinh dao tao
CREATE TABLE CacLoaiHinhDaoTao
(
    MaLoaiHinhDaoTao CHAR(20),
	TenLoaiHinhDaoTao NVARCHAR(20)
	PRIMARY KEY (MaLoaiHinhDaotao)
)
GO
--65. Quy doi ra chuan
CREATE TABLE QuyDoiLoaiHinh
(
    MaLoaiHinhCon CHAR(20),
	TenLoaiHinhCon NVARCHAR(20),
	MaLoaiHinhDaoTao CHAR(20)
	PRIMARY KEY (MaLoaiHinhCon)

)
GO
--66. Dieu Kien Loai Hinh
CREATE TABLE DieuKienLoaiHinh
(
    MaDieuKienLoaiHinh CHAR(20),
	DieuKien NVARCHAR(20),
	DonViTinh NVARCHAR(20),
	QuyRaGioChuan FLOAT,
	MaLoaiHinhCon CHAR(10)
	PRIMARY KEY (MaDieuKienLoaiHinh)
)
GO
--67. Lop Hoc Do Giao vien Giang Giay
CREATE TABLE LopHoc
(
    MaLopHoc CHAR(20),
	TenLopHoc NVARCHAR(20),
	CSN_CN BIT,
	HocKy NVARCHAR(20),
	MaLop CHAR(20),
	MaHocPhan CHAR(20),
	MaLoaiHinhCon CHAR(20)
	PRIMARY KEY ( MaLopHoc)
)
GO
--68. Hoc  Phan Cham thi
CREATE TABLE HocPhanChamThi
(
    MaChamThi CHAR(20),
	SoBai INT,
	MaLopHoc CHAR(20),
	MaLoaiHinhCon CHAR(20)
	PRIMARY KEY(MaChamThi)
)
GO
--69. Huong dan 
CREATE TABLE HuongDan
(
    MaHuongDan CHAR(20),
	TenDeTai_ChuDe NVARCHAR(20),
	ThoiGianBatDau DATE,
	ThoiGianKetThuc DATE,
	MaHocVien CHAR(20),
	MaLoaiHinhCon CHAR(20)
	PRIMARY KEY (MaHuongDan)
)
GO
--70. Giao vien co the day nhieu lop hoc
CREATE TABLE GiaoVien_LopHoc
(
    MaGiaoVien CHAR(20),
	MaLopHoc CHAR(20),
	ThoiGianBatDau DATE,
	ThoiGianKetThuc DATE
	PRIMARY KEY ( MaGiaoVien, MaLopHoc)
)
GO
--70. Giao vien cham thi lop hoc
CREATE TABLE GiaoVien_HocPhanChamThi
(
     MaGiaoVien CHAR(20),
	 MaHocPhanChamThi CHAR(20),
	 ThoiGianCham DATE
	 PRIMARY KEY (MaGiaoVien, MaHocPhanChamThi)
)
GO
--71 Giao vien huong dan nhieu hoc vien
CREATE TABLE GiaoVien_HuongDan
(
    MaGiaoVien CHAR(20),
	MaHuongDan CHAR(20),
	ThoiGianBatDau DATE,
	ThoiGianKetThuc DATE,
	VaiTroHuongDan INT 
    PRIMARY KEY (MaGiaoVien,MaHuongDan)
)
GO

--Tao Khoa Phu Cho Bai
--Khoa Phu Phan 1

--Khoa Phu Phan Nghieen cuu khoa hoc

--Khoa Phu Phan Giang Day

--***Nhap Du lieu

--**test
CREATE DATABASE TestTeach
GO
USE TestTeach
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
DROP TABLE dbo.GiaoVien
INSERT INTO dbo.GiaoVien
(
    MaGiaoVien,
    TenGiaoVien,
    NgaySinh,
    GioiTinh,
    QueQuan,
    DiaChi,
    SDT
)
VALUES
('GV001', N'NGUYEN VAN Q',GETDATE(),N'NAM',N'LANG SON', N'12',''),
('GV002', N'VO VAN B',GETDATE(),N'NU',N'CAO BANG', N'22',''),
('GV003', N'NGUYEN VAN C',GETDATE(),N'NAM',N'HA GIANG', N'33',''),
('GV004', N'BUI THE HOANG',GETDATE(),N'NAM',N'HA BAC', N'22',''),
('GV005', N'DUONG VAN NAM',GETDATE(),N'NAM',N'HA DONG', N'11',''),
('GV006', N'HO THI HONG',GETDATE(),N'NAM',N'HA NAM', N'22',''),
('GV007', N'LE VAN SY',GETDATE(),N'NU',N'HA NOI', N'12','')
GO

--phan 1 
-- 2. Chinh quyen
CREATE TABLE ChinhQuyen(
	MaChinhQuyen CHAR(20),
	MaChucVuChinhQuyen CHAR(20),
	MaDonViChinhQuyen CHAR(20)
)
GO
INSERT INTO dbo.ChinhQuyen
(
    MaChinhQuyen,
    MaChucVuChinhQuyen,
    MaDonViChinhQuyen
)
VALUES
( 'CQ001','CVCQ004','DVCQ006'),
( 'CQ002','CVCQ004','DVCQ007'),
( 'CQ003','CVCQ004','DVCQ008'),
( 'CQ004','CVCQ005','DVCQ006'),
('CQ005','CVCQ005','DVCQ008')
GO


-- 3. Dang
DROP TABLE dbo.Dang
CREATE TABLE Dang(
	MaDang CHAR(20),
	MaDonViDang CHAR(20),
	MaChucVuDang CHAR(20)
	PRIMARY KEY (MaDang)
)
GO
INSERT INTO dbo.Dang
(
    MaDang,
    MaDonViDang,
    MaChucVuDang
)
VALUES
('D001','DVD003','CVD001'),
('D002','DVD003','CVD002'),
('D003','DVD003','CVD003'),
('D004','DVD003','CVD003'),
('D005','DVD003','CVD003'),
('D006','DVD003','CVD003'),
('D007','DVD003','CVD003')
GO


-- 4. Don Vi chinh quyen
CREATE TABLE DonViChinhQuyen(
	MaDonViChinhQuyen CHAR(20),
	TenDonViChinhQuyen NVARCHAR(50)
	PRIMARY KEY( MaDonViChinhQuyen)
)
GO

INSERT INTO dbo.DonViChinhQuyen
(
    MaDonViChinhQuyen,
    TenDonViChinhQuyen
)
VALUES
('DVCQ001',N'DAI DOI 151'),
('DVCQ002',N'DAI DOI 152'),
('DVCQ003',N'DAI DOI 153'),
('DVCQ004',N'DAI DOI 154'),
('DVCQ005',N'DAI DOI 155'),
('DVCQ006',N'BO MON CNPM'),
('DVCQ007',N'BO MON ATTT'),
('DVCQ008',N'BO MON KHMT'),
('DVCQ009',N'BO MON CTM'),
('DVCQ010',N'BO MON KTM')
GO



-- 5 . Chuc vu chinh quyen
SELECT * FROM dbo.ChucVuChinhQuyen
DROP TABLE dbo.ChucVuChinhQuyen
CREATE TABLE ChucVuChinhQuyen(
	MaChucVuChinhQuyen CHAR(20) PRIMARY KEY,
	TenChucVuChinhQuyen NVARCHAR(50),
	MaDinhMucMienGiam CHAR(20)
)
GO
INSERT INTO dbo.ChucVuChinhQuyen
(
    MaChucVuChinhQuyen,
    TenChucVuChinhQuyen,
    MaDinhMucMienGiam
)
VALUES
('CVCQ001',N'GIAM DOC','MGCV001'),
('CVCQ002',N'CHINH UY','MGCV002'),
('CVCQ003',N'CHU NHIEM KHOA','MGCV003'),
('CVCQ004',N'CHU NHIEM BO MON','MGCV004'),
('CVCQ005',N'GIAO VIEN','MGCV010')
GO



-- 6 - Don Vi Dang
CREATE TABLE DonViDang(
	MaDonViDang CHAR(20) PRIMARY KEY,
	TenDonViDang NVARCHAR(50)
)
GO

INSERT INTO dbo.DonViDang
(
    MaDonViDang,
    TenDonViDang
)
VALUES
('DVD001',N'TIEU DOAN 1'),
('DVD002',N'TIEU DOAN 2'),
('DVD003',N'KHOA CONG NGHE THONG TIN'),
('DVD004',N'KHOA VO TUYEN DIEN TU'),
('DVD005',N'KHOA TU DONG HOA'),
('DVD006',N'DAI DOI 152'),
('DVD007',N'DAI DOI 153'),
('DVD008',N'DAI DOI 250')
GO
-- 7. Chuc vu Dang
CREATE TABLE ChucVuDang(
	MaChucVuDang CHAR(20) PRIMARY KEY,
	TenChucVuDang NVARCHAR(50),
	MaDinhMucMienGiam CHAR(20)
)
GO
INSERT INTO dbo.ChucVuDang
(
    MaChucVuDang,
    TenChucVuDang,
    MaDinhMucMienGiam
)
VALUES
('CVD001',N'BI THU CHI BO CO SO','MGCV006'),
('CVD002',N'BI THU DOAN CO SO','MGCV007'),
('CVD003',N'DANG VIEN','MGCV012')
GO
-- 8. Giao vien tham gia vao chuc vu chinh quyen
CREATE TABLE GiaoVien_ChinhQuyen(
	MaGiaoVien CHAR(20),
	MaChinhQuyen CHAR(20),
	ThoiGianNhan DATE
	PRIMARY KEY (MaGiaoVien ,MaChinhQuyen)
)
GO
-- 9  giao vien tham gia cong tac ben dang
CREATE TABLE GiaoVien_Dang(
	MaGiaoVien CHAR(20),
	MaDang CHAR(20),
	ThoiGianNhan DATE
	PRIMARY KEY(MaGiaoVien,MaDang)
)
GO
--9. hoc vi
--11. Hoc ham 
DROP TABLE dbo.DinhMucGiamDacBiet
CREATE TABLE DinhMucGiamDacBiet(
	MaDinhMucGiamDacBiet CHAR(20)PRIMARY KEY,
	TenDinhMucGiam NVARCHAR(200),
	TyLeGiam INT
)
GO
INSERT INTO dbo.DinhMucGiamDacBiet
(
    MaDinhMucGiamDacBiet,
    TenDinhMucGiam,
    TyLeGiam
)
VALUES
('DMGDB001',N'CO CON NHO DUOI 36 THANG',10)
--28. Dinh muc chuc danh
--29. Dinh muc mien giam
DROP TABLE dbo.DinhMucMienGiamChucVu
CREATE TABLE DinhMucMienGiamChucVu(
	MaDinhMucMienGiam CHAR(20)PRIMARY KEY,
	TyLeMienGiamThap INT,
	TyLeMienGiamCao INT,
	Loai INT,--0 is chinh quyen --1 is Dang -- 2 --LOAI KHAC
	TenChucVu NVARCHAR(50)
)
GO


INSERT INTO dbo.DinhMucMienGiamChucVu
(
    MaDinhMucMienGiam,
    TyLeMienGiamThap,
    TyLeMienGiamCao,
    Loai,
    TenChucVu
)
VALUES
('MGCV001',95,0,1,N'GIAM DOC HOC VIEN'),
('MGCV002',85,0,1,N'CHINH UY'),
('MGCV003',25,30,1,N'CHU NHIEM KHOA & TUONG DUONG'),
('MGCV004',20,25,1,N'CHU NHIEM BO MON & TUONG DUONG'),
('MGCV005',10,15,1,N'QUYEN CHU NHIEM'),
('MGCV006',20,25,0,N'BI THU CHI BO CO SO'),
('MGCV007',15,10,0,N'BI THU DOAN CƠ SO'),
('MGCV008',10,15,0,N'CHU NHIEM LOP'),
('MGCV009',50,0,2,N'GIAO VIEN DANG HOC CAO HOC'),
('MGCV010',70,0,2,N'GIAO VIEN'),
('MGCV012',70,0,2,N'DANG VIEN')


--30. Dinh Muc Giam Dac Biet
DROP TABLE dbo.GiaoVien_GiamDacBiet
CREATE TABLE GiaoVien_GiamDacBiet
(
    MaGiaoVien CHAR(20),
	MaDinhMucGiamDacBiet CHAR(20),
	ThoiGianMienGiam DATE,

	PRIMARY KEY (MaGiaoVien,MaDinhMucGiamDacBiet)
)

INSERT INTO dbo.GiaoVien_GiamDacBiet
(
    MaGiaoVien,
    MaDinhMucGiamDacBiet,
    ThoiGianMienGiam
)
VALUES
('GV001','DMGDB001',GETDATE())




INSERT INTO dbo.DonViChinhQuyen
(
    MaDonViChinhQuyen,
    TenDonViChinhQuyen
)
VALUES
('MDVCQ001',N'DAI DOI 151'),
('MDVCQ002',N'DAI DOI 152'),
('MDVCQ003',N'DAI DOI 153'),
('MDVCQ004',N'DAI DOI 154'),
('MDVCQ005',N'DAI DOI 155'),
('MDVCQ006',N'BO MON CNPM'),
('MDVCQ007',N'BO MON ATTT'),
('MDVCQ008',N'BO MON KHMT'),
('MDVCQ009',N'BO MON CTM'),
('MDVCQ010',N'BO MON KTM')
GO


GO




INSERT INTO dbo.DonViDang
(
    MaDonViDang,
    TenDonViDang
)
VALUES
('DVD001',N'TIEU DOAN 1'),
('DVD001',N'TIEU DOAN 2'),
('DVD001',N'KHOA CONG NGHE THONG TIN'),
('DVD001',N'KHOA VO TUYEN DIEN TU'),
('DVD001',N'KHOA TU DONG HOA'),
('DVD001',N'DAI DOI 152'),
('DVD001',N'DAI DOI 153'),
('DVD001',N'DAI DOI 250')
GO

INSERT INTO dbo.ChucVuDang
(
    MaChucVuDang,
    TenChucVuDang,
    MaDinhMucMienGiam
)
VALUES
('', N'','')


INSERT INTO dbo.DinhMucChucDanhChuyenMon
(
    MaDinhMucChucDanh,
    QuyDinhChungGiangDay,
    MonTheChatGiaoDucQuocPhong
)
VALUES
(   'MDMCDCM001',N'',N''),
(   'MDMCDCM002',N'',N''),
(   'MDMCDCM003',N'',N''),
(   'MDMCDCM004',N'',N''),
(   'MDMCDCM005',N'',N''),
(   'MDMCDCM006',N'',N'')
GO



SELECT * FROM dbo.ChucVuChinhQuyen
SELECT * FROM dbo.DonViChinhQuyen
SELECT * FROM dbo.DonViDang

SELECT * FROM dbo.ChucVuDang

SELECT * FROM dbo.Dang,dbo.DonViDang,dbo.ChucVuDang,dbo.DinhMucMienGiamChucVu
WHERE 
 DANG.MaDonViDang = dbo.DonViDang.MaDonViDang 
AND Dang.MaChucVuDang = ChucVuDang.MaChucVuDang
AND ChucVuDang.MaDinhMucMienGiam = DinhMucMienGiamChucVu.MaDinhMucMienGiam

SELECT * FROM dbo.Dang

SELECT * FROM dbo.ChinhQuyen

SELECT * FROM dbo.ChinhQuyen,dbo.DonViChinhQuyen,dbo.ChucVuChinhQuyen
WHERE ChinhQuyen.MaChucVuChinhQuyen = ChucVuChinhQuyen.MaChucVuChinhQuyen AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen

SELECT * FROM dbo.DinhMucMienGiamChucVu,dbo.ChucVuChinhQuyen
WHERE ChucVuChinhQuyen.MaDinhMucMienGiam = DinhMucMienGiamChucVu.MaDinhMucMienGiam

SELECT * FROM dbo.ChinhQuyen
SELECT * FROM dbo.GiaoVien

INSERT INTO dbo.GiaoVien_ChinhQuyen
(
    MaGiaoVien,
    MaChinhQuyen,
    ThoiGianNhan
)
VALUES
('GV001','CQ001',GETDATE()),
('GV002','CQ002',GETDATE()),
('GV003','CQ003',GETDATE()),
('GV004','CQ004',GETDATE()),
('GV005','CQ005',GETDATE()),
('GV006','CQ004',GETDATE()),
('GV007','CQ005',GETDATE())


INSERT INTO dbo.GiaoVien_Dang
(
    MaGiaoVien,
    MaDang,
    ThoiGianNhan
)
VALUES
('GV001','D001',GETDATE()),
('GV002','D002',GETDATE()),
('GV003','D003',GETDATE()),
('GV004','D004',GETDATE()),
('GV005','D005',GETDATE()),
('GV006','D006',GETDATE()),
('GV007','D007',GETDATE())


SELECT * FROM dbo.GiaoVien_ChinhQuyen


--LAY RA MIEN GIAO VE CHUC VU CUA MOT CHUC VU CHINH QUYEN
SELECT 
dbo.GiaoVien.TenGiaoVien,TenChucVuChinhQuyen,TenDonViChinhQuyen , dbo.DinhMucMienGiamChucVu.TyLeMienGiamThap 
FROM dbo.ChinhQuyen,dbo.DonViChinhQuyen,dbo.ChucVuChinhQuyen,dbo.GiaoVien_ChinhQuyen,dbo.GiaoVien,dbo.DinhMucMienGiamChucVu
WHERE 
ChinhQuyen.MaChucVuChinhQuyen = ChucVuChinhQuyen.MaChucVuChinhQuyen 
AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen
AND GiaoVien_ChinhQuyen.MaChinhQuyen = ChinhQuyen.MaChinhQuyen
AND GiaoVien.MaGiaoVien = GiaoVien_ChinhQuyen.MaGiaoVien
AND ChucVuChinhQuyen.MaDinhMucMienGiam= DinhMucMienGiamChucVu.MaDinhMucMienGiam

--LAY RA MIEN GIAP VE CHUC VU DANG

SELECT dbo.GiaoVien.TenGiaoVien , TenChucVuDang, TenDonViDang, dbo.DinhMucMienGiamChucVu.TyLeMienGiamThap FROM dbo.GiaoVien,dbo.GiaoVien_Dang,dbo.Dang,dbo.ChucVuDang,dbo.DonViDang,dbo.DinhMucMienGiamChucVu
WHERE GiaoVien.MaGiaoVien = GiaoVien_Dang.MaGiaoVien
AND Dang.MaDang = GiaoVien_Dang.MaDang
AND Dang.MaChucVuDang = ChucVuDang.MaChucVuDang
AND Dang.MaDonViDang = DonViDang.MaDonViDang
AND ChucVuDang.MaDinhMucMienGiam = DinhMucMienGiamChucVu.MaDinhMucMienGiam



SELECT * FROM dbo.GiaoVien,dbo.GiaoVien_GiamDacBiet,dbo.DinhMucGiamDacBiet
WHERE
GiaoVien.MaGiaoVien = GiaoVien_GiamDacBiet.MaGiaoVien
AND DinhMucGiamDacBiet.MaDinhMucGiamDacBiet= GiaoVien_GiamDacBiet.MaDinhMucGiamDacBiet
SELECT * FROM dbo.GiaoVien,dbo.GiaoVien_ChinhQuyen
WHERE GiaoVien.MaGiaoVien = GiaoVien_ChinhQuyen.MaGiaoVien

