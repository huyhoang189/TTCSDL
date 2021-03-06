USE [master]
GO
/****** Object:  Database [QUAN_LY_GIAO_VIEN]    Script Date: 6/30/2019 2:17:16 PM ******/
CREATE DATABASE [QUAN_LY_GIAO_VIEN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QUAN_LY_GIAO_VIEN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QUAN_LY_GIAO_VIEN.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QUAN_LY_GIAO_VIEN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QUAN_LY_GIAO_VIEN_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QUAN_LY_GIAO_VIEN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET ARITHABORT OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET RECOVERY FULL 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET  MULTI_USER 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QUAN_LY_GIAO_VIEN', N'ON'
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET QUERY_STORE = OFF
GO
USE [QUAN_LY_GIAO_VIEN]
GO
/****** Object:  UserDefinedFunction [dbo].[GiangDay]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GiangDay](@MaGiaoVien char(20), @starttime DATETIME, @endtime DATE)
returns @rtntable TABLE 
(
    ID int IDENTITY(1,1) NOT NULL,
	Tenchuongtrinhdaotao nvarchar(200),
    TenHocPhan nvarchar(200),
	SiSo nvarchar(200),
	CSN_CN nvarchar(200),
	He nvarchar(200),
	Lop nvarchar(200),
	SoTC int ,
	SoTiet int,
	GioChuan float,
	GhiChu nvarchar(200) NULL
)
as
BEGIN
	-- chon ra cac mon hoc cua giao vien trong thoi gian do -- 
	--

	declare @LopHoc table
	(
		ID int IDENTITY(1,1) NOT NULL,
		MaLopHoc char(20) ,
		TenLopHoc nvarchar(200),
		CSN_CN char(20),
		HocKy nvarchar(200),
		MaLop char(20), 
		MaHocPhan char(20),
		MaDieuKien char(20)
	)


	insert into @LopHoc
	select LopHoc.MaLopHoc as MaLopHoc, TenLopHoc, CSN_CN, HocKy, MaLop, MaHocPhan, MaQuyDoi as MaDieuKien from GiaoVien_LopHoc, LopHoc where GiaoVien_LopHoc.MaGiaoVien = @MaGiaoVien and GiaoVien_LopHoc.MaLopHoc=LopHoc.MaLopHoc and ThoiGianBatDau >= @starttime and ThoiGianKetThuc <= @endtime


	-- tinh chuan ---
	insert @rtntable
	select Tenchuongtrinhdaotao,TenHocPhan, DieuKien as SiSo, CSN_CN, TenHe as He, TenLop as Lop, SoTinChi as SoTC, SoTiet , QuyRaGioChuan*SoTiet as GioChuan , '' as GhiChu from 
	(select *, dbo.QuyDoiDieuKien(lophoc.MaDieuKien, DieuKien,  SiSo) as chec, lophoc.MaDieuKien as DK from 
	(select MaLopHoc, Loptt.MaLop as MaLop, MaHe , MaLoaiHinhCon as LoaiHinh,  SiSo, TenHocPhan, TenLop, SoTinChi, SoTiet,  TenLopHoc, CSN_CN, HocKy , MaDieuKien
	from @LopHoc Loptt,Lop,HocPhan  where Loptt.MaLop= Lop.MaLop and Loptt.MaHocPhan=HocPhan.MaHocPhan)  lophoc, DieuKienLoaiHinh
	 where  LoaiHinh = DieuKienLoaiHinh.MaLoaiHinhCon) tachhe, He , chuongtrinhdaotao
	 where tachhe.MaHe = He.MaHe and He.Machuongtrinhdaotao = chuongtrinhdaotao.Machuongtrinhdaotao and chec = 1 

	 return

END

GO
/****** Object:  UserDefinedFunction [dbo].[magv_thuoc_khoa]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[magv_thuoc_khoa] (@makhoa CHAR(20),@ngay DATE) 
RETURNS  @GV_KHOA TABLE ( magv CHAR(20)) 
AS
BEGIN
	
	INSERT INTO @GV_KHOA( magv )
	SELECT MaGiaoVien FROM dbo.GiaoVien_Khoa WHERE MaKhoa=@makhoa
	AND ThoiGianBatDau<@ngay AND( ThoiGianKetThuc IS NULL OR ThoiGianKetThuc>@ngay)
	
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[MienGiam]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[MienGiam] (@magiaovien CHAR(20),@time DATE)
RETURNS INTEGER
AS
BEGIN
    DECLARE @v_GiamCVCQ INT ,@v_GiamCVD INT, @v_GiamDB INT , @v_Sum INT
	SELECT @v_GiamCVCQ = TyLeMienGiam  FROM dbo.ThongKe_MGCVCQ(@magiaovien,@time)
	SELECT @v_GiamCVD = TyLeMienGiam  FROM dbo.ThongKe_MGCVD(@magiaovien,@time)
	SELECT @v_GiamDB = TyLeGiam FROM dbo.GiaoVien_GiamDacBiet,dbo.DinhMucGiamDacBiet
	WHERE DinhMucGiamDacBiet.MaDinhMucGiamDacBiet = GiaoVien_GiamDacBiet.MaDinhMucGiamDacBiet
	AND MaGiaoVien = @magiaovien
	AND ThoiGianBatDau <= @time 
	AND ThoiGianKetThuc >= @time 
	IF(@v_GiamCVCQ IS NULL OR @v_GiamCVCQ = '') SET @v_GiamCVCQ = 0
	IF(@v_GiamCVD IS NULL OR @v_GiamCVD ='') SET @v_GiamCVD = 0
	IF(@v_GiamDB IS NULL OR @v_GiamDB ='') SET @v_GiamDB = 0
	IF(@v_Sum IS NULL OR @v_Sum ='') SET @v_Sum = 0
	IF(@v_GiamCVCQ > @v_GiamCVD) SET @v_Sum = @v_Sum + @v_GiamCVCQ
	ELSE SET @v_Sum = @v_Sum + @v_GiamCVD
	SET @v_Sum = @v_Sum + @v_GiamDB
	RETURN @v_Sum
END
GO
/****** Object:  UserDefinedFunction [dbo].[MIENGIAM_GIAOVIEN]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[MIENGIAM_GIAOVIEN] (@time date )
RETURNS @tb_miengiam TABLE (
	MagiaoVien CHAR(20),
	TyLeGiam Int
)
AS
BEGIN
	DECLARE @tb_temp TABLE (
		MaGiaoVien CHAR(20),
		chinhquyen INT,
		dang INT,
		db INT,
		tong INT NULL
	)
	INSERT INTO @tb_temp (MaGiaoVien,chinhquyen,dang,db)
	SELECT X.MaGiaoVien,X.chinhquyen,X.dang,Y.db FROM 	(SELECT A.MaGiaoVien,chinhquyen,dang FROM (SELECT MaGiaoVien,TyLeGiam AS chinhquyen  FROM THONGKE_MIENGIAMCHINHQUYEN()
					WHERE @time BETWEEN ThoiGianNhan AND ThoiGianKetThuc) AS A,
					(SELECT MaGiaoVien,TyLeGiam AS dang FROM THONGKE_MIENGIAMDANG()
					WHERE @time BETWEEN ThoiGianNhan AND ThoiGianKetThuc) AS B
					WHERE A.MaGiaoVien = B. MaGiaoVien) AS X	
	LEFT JOIN (
		SELECT C.MaGiaoVien,C.TyLeGiam AS db FROM (
			SELECT MaGiaoVien,A.TyLeGiam,ThoiGianBatDau,ThoiGianKetThuc FROM dbo.GiaoVien_GiamDacBiet
			JOIN (SELECT TyLeGiam,MaDinhMucGiamDacBiet FROM dbo.DinhMucGiamDacBiet) AS A
			ON A.MaDinhMucGiamDacBiet = GiaoVien_GiamDacBiet.MaDinhMucGiamDacBiet
		) AS C
		WHERE @time BETWEEN c.ThoiGianBatDau AND c.ThoiGianKetThuc
	) AS Y
	ON Y.MaGiaoVien = X.MaGiaoVien
	UPDATE @tb_temp SET db = 0 WHERE db IS NULL
	UPDATE @tb_temp SET tong = 0 WHERE tong IS NULL
	UPDATE @tb_temp SET tong = chinhquyen + db WHERE chinhquyen >= dang
	UPDATE @tb_temp SET tong = dang + db WHERE chinhquyen <= dang
	
	INSERT INTO @tb_miengiam (MaGiaoVien,TyLeGiam)
	SELECT MaGiaoVien,tong FROM @tb_temp
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[QuyDoiDieuKien]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[QuyDoiDieuKien](@MaDieuKien char(20), @DieuKien nvarchar(200), @SiSo int) 
RETURNS int AS 
BEGIN 
	declare @pos int , @temp nvarchar(200)
	declare @min int 
	declare @max int 

	if not ((@MaDieuKien is null) or (@MaDieuKien = ''))
	begin 
		select @temp= DieuKien from DieuKienLoaiHinh where DieuKienLoaiHinh.DieuKienLoaiHinh = @MaDieuKien
		if (@temp = @DieuKien) return 1;
		else return 0;
	end

	if  Charindex('-', @DieuKien) <=0 
	begin
 
		return 1
	end
	SELECT @pos  = CHARINDEX('-', @DieuKien)  
	set @temp = SUBSTRING(@DieuKien, 1, @pos-1)
	if ISNUMERIC(@temp) = 1
	SELECT @min = @temp
	else return 0

	SELECT @temp = SUBSTRING(@DieuKien, @pos+1, LEN(@DieuKien)-@pos+1)

	if ISNUMERIC(@temp) = 1
	SELECT @max = @temp
	else return 0
	if @SiSo >= @min and @SiSo <= @max
	return 1
	RETURN 0
END

GO
/****** Object:  UserDefinedFunction [dbo].[ShowNCKH]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ShowNCKH](@time date)
RETURNS @tb_info TABLE (
	TenKhoa nvarchar(50),
	MaGiaoVien CHAR(20),
	TenGiaoVien nvarchar(200),
	ThucTai int,
	TaiYeuCau int,
	NCKH int
)
AS
BEGIN
    DECLARE @v_magiaovien CHAR(20),@v_tengiaovien NVARCHAR(200)
	DECLARE cursor_GV CURSOR FOR
	SELECT MaGiaoVien,TenGiaoVien FROM dbo.GiaoVien
	OPEN cursor_GV
	FETCH NEXT FROM cursor_GV INTO @v_magiaovien,@v_tengiaovien
	WHILE @@FETCH_STATUS = 0
	BEGIN
		BEGIN
		    DECLARE @ThucTai int,@TaiYeuCau INT , @NCKH INT,@TenKhoa NVARCHAR(50)
			SELECT @TenKhoa = TenKhoa FROM dbo.GiaoVien,dbo.Khoa,dbo.GiaoVien_Khoa
			WHERE GiaoVien.MaGiaoVien = GiaoVien_Khoa.MaGiaoVien
			AND GiaoVien_Khoa.MaKhoa =Khoa.MaKhoa
			AND GiaoVien.MaGiaoVien = @v_magiaovien
			SELECT @ThucTai = ThucTai,@TaiYeuCau = TaiYeuCau , @NCKH = NCKH FROM dbo.TongTaiNCKH_GV(@v_magiaovien,@time)
			INSERT INTO @tb_info(TenKhoa,MaGiaoVien,TenGiaoVien,ThucTai,TaiYeuCau,NCKH)
			VALUES(@TenKhoa,@v_magiaovien,@v_tengiaovien,@ThucTai,@TaiYeuCau,@NCKH)
		END
	    FETCH NEXT FROM cursor_GV INTO @v_magiaovien,@v_tengiaovien
	END
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[ThongKe_BaiBao]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ThongKe_BaiBao](@magiaovien CHAR(20))
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
GO
/****** Object:  UserDefinedFunction [dbo].[ThongKe_BienSoanSach]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ThongKe_BienSoanSach](@magiaovienSach CHAR(20))
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
GO
/****** Object:  UserDefinedFunction [dbo].[ThongKe_DeTai]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ThongKe_DeTai](@magiaovienNCKH CHAR(20))
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
GO
/****** Object:  UserDefinedFunction [dbo].[ThongKe_MGCVCQ]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ThongKe_MGCVCQ](@magiaovien CHAR(20), @ThoiGian Date)
RETURNS @tb_MGCVCQ TABLE(
	 MaChucVu  CHAR(20),
	 TenChucVu nvarchar(50),
	 TenDonVi nvarchar(50),
	 TyLeMienGiam int,
	 ThoiGian Date
)
AS
BEGIN
    DECLARE @v_MaChinhQuyen CHAR(20), @v_ThoiGianNhan DATE,@v_ThoiGianKetThuc DATE
	DECLARE CURSOR_ChinhQuyen CURSOR FOR
	SELECT MaChinhQuyen,ThoiGianNhan,ThoiGianKetThuc FROM dbo.GiaoVien_ChinhQuyen
	WHERE MaGiaoVien = @magiaovien
	AND @ThoiGian > ThoiGianNhan
	OPEN CURSOR_ChinhQuyen
	FETCH NEXT FROM CURSOR_ChinhQuyen INTO @v_MaChinhQuyen,@v_ThoiGianNhan,@v_ThoiGianKetThuc
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
			IF(@v_ThoiGianKetThuc IS null)
				BEGIN
					INSERT INTO @tb_MGCVCQ	(MaChucVu,TenChucVu,TenDonVi,TyLeMienGiam,ThoiGian)
					VALUES (@MaChucVu,@TenChucVu,@TenDonVi,@TyLeMienGiam,@v_ThoiGianNhan)
				END
			ELSE
				IF(@v_ThoiGianKetThuc > @ThoiGian)
					BEGIN
					    INSERT INTO @tb_MGCVCQ	(MaChucVu,TenChucVu,TenDonVi,TyLeMienGiam,ThoiGian)
						VALUES (@MaChucVu,@TenChucVu,@TenDonVi,@TyLeMienGiam,@v_ThoiGianNhan)
					END
					
		END
		FETCH NEXT FROM CURSOR_ChinhQuyen INTO @v_MaChinhQuyen,@v_ThoiGianNhan,@v_ThoiGianKetThuc
	END
	DEALLOCATE CURSOR_ChinhQuyen
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[ThongKe_MGCVD]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----mien giam ve chuc vu
CREATE FUNCTION [dbo].[ThongKe_MGCVD](@magiaovien CHAR(20), @ThoiGian Date)
RETURNS @tb_MGCVD TABLE(
	 MaChucVu  CHAR(20),
	 TenChucVu nvarchar(50),
	 TenDonVi nvarchar(50),
	 TyLeMienGiam int,
	 ThoiGian Date
)
AS
BEGIN
    DECLARE @v_MaDang CHAR(20), @v_ThoiGianNhan DATE,@v_ThoiGianKetThuc DATE
	DECLARE CURSOR_Dang CURSOR FOR
	SELECT MaDang,ThoiGianNhan,ThoiGianKetThuc FROM dbo.GiaoVien_Dang
	WHERE MaGiaoVien = @magiaovien
	AND @ThoiGian > ThoiGianNhan
	OPEN CURSOR_Dang
	FETCH NEXT FROM CURSOR_Dang INTO @v_MaDang,@v_ThoiGianNhan,@v_ThoiGianKetThuc
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
			IF(@v_ThoiGianKetThuc IS null)
				BEGIN
					INSERT INTO @tb_MGCVD	(MaChucVu,TenChucVu,TenDonVi,TyLeMienGiam,ThoiGian)
					VALUES (@MaChucVu,@TenChucVu,@TenDonVi,@TyLeMienGiam,@v_ThoiGianNhan)
				END
			ELSE
				IF(@v_ThoiGianKetThuc > @ThoiGian)
					BEGIN
					    INSERT INTO @tb_MGCVD	(MaChucVu,TenChucVu,TenDonVi,TyLeMienGiam,ThoiGian)
						VALUES (@MaChucVu,@TenChucVu,@TenDonVi,@TyLeMienGiam,@v_ThoiGianNhan)
					END
					
			----------------
	    END
		FETCH NEXT FROM CURSOR_Dang INTO @v_MaDang,@v_ThoiGianNhan,@v_ThoiGianKetThuc
	END
	DEALLOCATE CURSOR_Dang
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[THONGKE_MIENGIAMCHINHQUYEN]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[THONGKE_MIENGIAMCHINHQUYEN]()
RETURNS @tb_MienGiamChinhQuyen TABLE (
	MaGiaoVien CHAR(20),
	MaChucVuChinhQuyen CHAR(20),
	MaDonViChinhQuyen CHAR(20),
	TyLeGiam CHAR(20),
	ThoiGianNhan date,
	ThoiGianKetThuc date
)
AS 
BEGIN
	DECLARE @tb_temp TABLE(
		MaGiaoVien CHAR(20),
		MaChucVuChinhQuyen  CHAR(20),
		MaChinhQuyen CHAR(20),
		TyLeGiamThap INT,
		TyLeGiamCao INT,
		ThoiGianNhan date,
		ThoiGianKetThuc DATE,
		MaDonViChinhQuyen CHAR(20),
        TyleMienGiam INT NULL,
		SoThanhVien INT null
	)

	INSERT INTO @tb_temp (MaGiaoVien,MaChucVuChinhQuyen,MaChinhQuyen,TyLeGiamThap,TyLeGiamCao,ThoiGianNhan,ThoiGianKetThuc,MaDonViChinhQuyen,SoThanhVien)
	SELECT X.*,Y.SoThanhVien FROM (
		SELECT MaGiaoVien,C.MaChucVuChinhQuyen,C.MaChinhQuyen,C.TyLeMienGiamThap,C.TyLeMienGiamCao,ThoiGianNhan,ThoiGianKetThuc,C.MaDonViChinhQuyen FROM dbo.GiaoVien_ChinhQuyen
		JOIN(		
			SELECT X.MaChinhQuyen,B.MaChucVuChinhQuyen,B.TyLeMienGiamThap,B.TyLeMienGiamCao,X.MaDonViChinhQuyen FROM (SELECT ChinhQuyen.MaDonViChinhQuyen,MaChinhQuyen,MaChucVuChinhQuyen FROM dbo.ChinhQuyen,dbo.DonViChinhQuyen WHERE DonViChinhQuyen.MaDonViChinhQuyen = ChinhQuyen.MaDonViChinhQuyen) AS X
			JOIN (
				SELECT MaChucVuChinhQuyen,A.MaDinhMucMienGiam,A.TyLeMienGiamThap,A.TyLeMienGiamCao FROM dbo.ChucVuChinhQuyen
				JOIN (SELECT MaDinhMucMienGiam,TyLeMienGiamThap,TyLeMienGiamCao FROM dbo.DinhMucMienGiamChucVu) AS A
				ON A.MaDinhMucMienGiam = dbo.ChucVuChinhQuyen.MaDinhMucMienGiam
			) AS B
			ON X.MaChucVuChinhQuyen = B.MaChucVuChinhQuyen
		) AS C
		ON C.MaChinhQuyen = GiaoVien_ChinhQuyen.MaChinhQuyen ) AS X
	JOIN (
		SELECT ChinhQuyen.MaDonViChinhQuyen,COUNT(ChinhQuyen.MaDonViChinhQuyen) AS SoThanhVien FROM dbo.ChinhQuyen,dbo.DonViChinhQuyen,dbo.GiaoVien_ChinhQuyen
		WHERE ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen AND GiaoVien_ChinhQuyen.MaChinhQuyen = ChinhQuyen.MaChinhQuyen
		GROUP BY ChinhQuyen.MaDonViChinhQuyen	
	 ) AS Y
	 ON Y.MaDonViChinhQuyen = X.MaDonViChinhQuyen
     

	 UPDATE @tb_temp  SET TyleMienGiam = TyLeGiamThap WHERE SoThanhVien < 40
	 UPDATE @tb_temp  SET TyleMienGiam = TyLeGiamCao WHERE SoThanhVien > 40
	 UPDATE @tb_temp SET ThoiGianKetThuc = GETDATE() WHERE ThoiGianKetThuc IS NULL

	INSERT INTO  @tb_MienGiamChinhQuyen(MaGiaoVien,MaChucVuChinhQuyen,MaDonViChinhQuyen,ThoiGianNhan,ThoiGianKetThuc,TyleGiam)
	SELECT MaGiaoVien,MaChucVuChinhQuyen,MaDonViChinhQuyen,ThoiGianNhan,ThoiGianKetThuc,TyleMienGiam FROM @tb_temp
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[THONGKE_MIENGIAMDANG]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[THONGKE_MIENGIAMDANG]()
RETURNS @tb_MienGiamDang TABLE (
	MaGiaoVien CHAR(20),
	MaChucVuDang  CHAR(20),
	MaDonViDang CHAR(20),
	TyLeGiam CHAR(20),
	ThoiGianNhan date,
	ThoiGianKetThuc date
)
AS 
BEGIN
	DECLARE @tb_temp TABLE(
		MaGiaoVien CHAR(20),
		MaChucVuDang  CHAR(20),
		MaDang CHAR(20),
		TyLeGiamThap INT,
		TyLeGiamCao INT,
		ThoiGianNhan date,
		ThoiGianKetThuc DATE,
		MaDonViDang CHAR(20),
        TyleMienGiam INT NULL,
		SoThanhVien INT null
	)

	INSERT INTO @tb_temp (MaGiaoVien,MaChucVuDang,MaDang,TyLeGiamThap,TyLeGiamCao,ThoiGianNhan,ThoiGianKetThuc,MaDonViDang,SoThanhVien)
	SELECT X.*,Y.SoThanhVien FROM (
		SELECT MaGiaoVien,C.MaChucVuDang,C.MaDang,C.TyLeMienGiamThap,C.TyLeMienGiamCao,ThoiGianNhan,ThoiGianKetThuc,C.MaDonViDang FROM dbo.GiaoVien_Dang
		JOIN(		
			SELECT MaDang,B.MaChucVuDang,B.TyLeMienGiamThap,B.TyLeMienGiamCao,X.MaDonViDang FROM (SELECT Dang.MaDonViDang,MaDang,MaChucVuDang FROM dbo.Dang,dbo.DonViDang WHERE Dang.MaDonViDang = DonViDang.MaDonViDang) AS X
			JOIN (
				SELECT MaChucVuDang,A.MaDinhMucMienGiam,A.TyLeMienGiamThap,A.TyLeMienGiamCao FROM dbo.ChucVuDang
				JOIN (SELECT MaDinhMucMienGiam,TyLeMienGiamThap,TyLeMienGiamCao FROM dbo.DinhMucMienGiamChucVu) AS A
				ON A.MaDinhMucMienGiam = ChucVuDang.MaDinhMucMienGiam
			) AS B
			ON B.MaChucVuDang = X.MaChucVuDang
		) AS C
		ON C.MaDang = GiaoVien_Dang.MaDang) AS X
	JOIN (
		SELECT Dang.MaDonViDang,COUNT(Dang.MaDonViDang) AS SoThanhVien FROM dbo.Dang,dbo.DonViDang,dbo.GiaoVien_Dang
		WHERE Dang.MaDonViDang= DonViDang.MaDonViDang AND Dang.MaDang = GiaoVien_Dang.MaDang
		GROUP BY Dang.MaDonViDang	
	 ) AS Y
	 ON Y.MaDonViDang = X.MaDonViDang
     

	 UPDATE @tb_temp  SET TyleMienGiam = TyLeGiamThap WHERE SoThanhVien < 40
	 UPDATE @tb_temp  SET TyleMienGiam = TyLeGiamCao WHERE SoThanhVien > 40
	  UPDATE @tb_temp SET ThoiGianKetThuc = GETDATE() WHERE ThoiGianKetThuc IS NULL

	INSERT INTO  @tb_MienGiamDang(MaGiaoVien,MaChucVuDang,MaDonViDang,ThoiGianNhan,ThoiGianKetThuc,TyleGiam)
	SELECT MaGiaoVien,MaChucVuDang,MaDonViDang,ThoiGianNhan,ThoiGianKetThuc,TyleMienGiam FROM @tb_temp
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[ThongKeGiaoVienDaoTao]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	create function [dbo].[ThongKeGiaoVienDaoTao](@time date)
	returns @temp table
	(
		TenKhoa nvarchar(200),
		MagiaoVien char(20),
		Tengiaovien nvarchar(200),
		ThucTai INT ,
		YeuCau INT ,
		Phantramdatduoc INT 

	)
	as 
	
	begin 
		--declare @time date
	
		insert into @temp 
		select  X.TenKhoa , c.MaGiaoVien as MaGiaoVien, c.TenGiaoVien, dbo.TongGiangDayTheoNam(a.MaGiaoVien, @time) as TaiThuc,  0.01 * (100-TyLeGiam)*ChuanGiangDay as YeuCau , 0.0 as GD from ((MIENGIAM_GIAOVIEN(@time) a 
		INNER join TinhDinhMucChucDanh(@time) b on a.MaGiaoVien = b.MaGiaoVien ) 
		INNER join GiaoVien c on a.MagiaoVien = c.MaGiaoVien)
		INNER JOIN (
			SELECT TenKhoa,MaGiaoVien FROM dbo.Khoa,dbo.GiaoVien_Khoa
			WHERE dbo.Khoa.MaKhoa = GiaoVien_Khoa.MaKhoa
		) AS X ON X.MagiaoVien = c.MaGiaoVien
	
		update @temp set Phantramdatduoc = ThucTai * 100 /YeuCau
		return 
	end
GO
/****** Object:  UserDefinedFunction [dbo].[TinhChamThi]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  function  [dbo].[TinhChamThi] (@MaGiaoVien char(20), @starttime DATETIME, @endtime DATE)
returns  @rtntablechamthi TABLE 
(
    ID int IDENTITY(1,1) NOT NULL,
	TenLoaiHocPhan nvarchar(200),
	TenHocPhan nvarchar(200),
	TenLop nvarchar(200),
	SoBai int,
	SoGio float, 
	GhiChu nvarchar(200) NULL
)
as
BEGIN
	-- chon ra cac mon hoc cua giao vien trong thoi gian do -- 
--		declare @MaGiaoVien char(20), @starttime datetime , @endtime datetime 
--	set @MaGiaoVien = 'gv0011'
--	set @starttime = '2000-1-1'
--	set @endtime = '3000-1-1'

	declare  @ChamThi table
	(
		ID int IDENTITY(1,1) NOT NULL,
		MaHocPhanChamThi char(20),
		SoBai int, 
		MaLopHoc char(20),
		MaQuyDoi char(20) NULL, 
		GhiChu nvarchar(200) NULL
	)

	insert  @ChamThi
	select HocPhanChamThi.MaHocPhanChamThi, SoBai, MaLopHoc, MaQuyDoi, GhiChu from GiaoVien_HocPhanChamThi, HocPhanChamThi where GiaoVien_HocPhanChamThi.MaGiaoVien = @MaGiaoVien and GiaoVien_HocPhanChamThi.MaHocPhanChamThi=HocPhanChamThi.MaHocPhanChamThi and ThoiGianBatDau >= @starttime and ThoiGianKetThuc <= @endtime

	
	-- tinh lop vao hoc phan ---


	declare @ChamThi_Lop_HP table
	(
		ID int IDENTITY(1,1) NOT NULL,
		MaHocPhanChamThi char(20),
		SoBai int, 
		MaLop char(20),
		MaHocPhan char(20),
		MaQuyDoi char(20) NULL, 
		GhiChu nvarchar(200) NULL
	)

	insert @ChamThi_Lop_HP
	select CT.MaHocPhanChamThi, SoBai, MaLop, MaHocPhan, CT.MaQuyDoi, GhiChu from  @ChamThi CT, LopHoc where 
	CT.MaLopHoc = LopHoc.MaLopHoc

	-- tinh gio chuan -- 

	declare  @ChamThi_GioChuan table
	(
		ID int IDENTITY(1,1) NOT NULL,
		MaLoaiHinhCon char(20),
		TenHocPhan nvarchar(200),
		TenLop nvarchar(200),
		SoBai int,
		SoGio float, 
		GhiChu nvarchar(200) NULL
	)
	insert @ChamThi_GioChuan
	select  MaLoaiHinhCon, TenHocPhan, TenLop, SoBai, SoBai*QuyRaGioChuan as SoGio , DieuKien as GhiChu from	
	(select MaHocPhanChamThi,SoBai, TenLop, TenHocPhan, MaQuyDoi from @ChamThi_Lop_HP CTLHP, Lop, HocPhan where CTLHP.MaLop = Lop.MaLop and CTLHP.MaHocPhan = HocPhan.MaHocPhan) ChamThi_Lop, DieuKienLoaiHinh 
	where DieuKienLoaiHinh.DieuKienLoaiHinh = ChamThi_Lop.MaQuyDoi

	-- tinh loai hoc phan thi  -- 
	insert @rtntablechamthi
	select  QuyDoiLoaiHinh.TenLoaiHinhCon, TenHocPhan, TenLop, SoBai, SoGio ,GhiChu from @ChamThi_GioChuan CTGC, QuyDoiLoaiHinh where CTGC.MaLoaiHinhCon = QuyDoiLoaiHinh.MaLoaiHinhCon
	return
END
GO
/****** Object:  UserDefinedFunction [dbo].[TinhDinhMucChucDanh]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[TinhDinhMucChucDanh](@time date)
RETURNS @tb_temp TABLE(
	MaGiaoVien CHAR(20),
	ChuanGiangDay INT ,
	ChuanNghienCuu INT,
	ThoiGianBatDau DATE,
	ThoiGianKetThuc DATE
)
AS
BEGIN
	INSERT INTO @tb_temp
	SELECT MaGiaoVien,B.ChuanGiangDay,B.ChuanNghienCuu,ThoiGianNhanBatDau,ThoiGianNhanKetThuc FROM dbo.GiaoVien_ChucDanh
	JOIN (
		SELECT MaChucDanh,A.MaDinhMucChucDanh,A.ChuanGiangDay,A.ChuanNghienCuu FROM dbo.ChucDanh
		JOIN (
			SELECT MaDinhMucChucDanh,GioQuyDinhChungGiangDay AS ChuanGiangDay,ThoiGianChuanNghienCuu AS ChuanNghienCuu FROM dbo.DinhMucChucDanh
		) AS A
		ON A.MaDinhMucChucDanh = ChucDanh.MaDinhMucChucDanh
	) AS B
	ON B.MaChucDanh = GiaoVien_ChucDanh.MaChucDanh

	UPDATE @tb_temp SET ThoiGianKetThuc = GETDATE() WHERE ThoiGianKetThuc IS NULL 
	DELETE FROM @tb_temp  WHERE @time NOT BETWEEN ThoiGianBatDau AND  ThoiGianKetThuc
	return
END 
GO
/****** Object:  UserDefinedFunction [dbo].[TinhHuongDan]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function  [dbo].[TinhHuongDan] (@MaGiaoVien char(20), @starttime DATETIME, @endtime DATE)
returns  @rtntablehuongdan table 
		(
			ID int IDENTITY(1,1) NOT NULL,
			TenLoaiHinh nvarchar(200),
			TenHV nvarchar(200), 
			TenLop nvarchar(200),
			TenHe nvarchar(200),
			SoCanBoHD int,
			GioChuan float , 
			GhiChu nvarchar(200) NULL
)
as
BEGIN
	-- chon ra cac mon hoc cua giao vien trong thoi gian do -- 
		---declare @MaGiaoVien char(20), @starttime datetime , @endtime datetime 
	--set @MaGiaoVien = 'gv0011'
	--set @starttime = '2000-1-1'
	--set @endtime = '3000-1-1'

	declare  @HuongDan table
	(
		ID int IDENTITY(1,1) NOT NULL,
		MaHuongDan char(20),
		TenDeTai nvarchar(200),
		SoCanBoHuongDan int,
		MaHocVien char(20),
		MaQuyDoi char(20) NULL, 
		GhiChu nvarchar(200) NULL
	)

	insert @HuongDan
	select HuongDan.MaHuongDan,TenDeTai_ChuDe, SoCanBoHuongDan, MaHocVien, MaQuyDoi, '' as GhiChu  from GiaoVien_HuongDan, HuongDan where GiaoVien_HuongDan.MaGiaoVien = @MaGiaoVien and GiaoVien_HuongDan.MaHuongDan = HuongDan.MaHuongDan and GiaoVien_HuongDan.ThoiGianBatDau >= @starttime and GiaoVien_HuongDan.ThoiGianKetThuc <= @endtime

	-- tinh lop vao hoc phan ---
	declare  @HuongDan_Ten_Lop_He table
	(
		ID int IDENTITY(1,1) NOT NULL,
		MaHuongDan char(20),
		TenHV nvarchar(200), 
		TenLop nvarchar(200),
		TenHe nvarchar(200),
		SoCanBoHD int,
		MaQuyDoi char(20) NULL, 
		GhiChu nvarchar(200) NULL
	)
	insert @HuongDan_Ten_Lop_He
	select HD.MaHuongDan, TenHocVien, TenLop, TenHe, SoCanBoHuongDan ,MaQuyDoi, GhiChu from  @HuongDan HD, HocVien, Lop, He where 
	HD.MaHocVien = HocVien.MaHocVien and HocVien.MaLop = Lop.MaLop and Lop.MaHe = He.MaHe
	

	-- tinh quy ra gio -- 

	declare @HuongDan_Quy_SL table 
	(
		ID int IDENTITY(1,1) NOT NULL,
		MaQuyDoi char(20),
		SLSV int,
		Tille float
		
	)
	insert @HuongDan_Quy_SL
	select MaQuyDoi, COUNT(*)as SLSV , 0.0 from @HuongDan_Ten_Lop_He HDTLH group by MaQuyDoi 

	declare @HuongDan_Quy_Gio_Chuan table 
	(
		ID int IDENTITY(1,1) NOT NULL,
		MaQuyDoi char(20),
		QuyChuan float,
		chec int
	)
	insert @HuongDan_Quy_Gio_Chuan
	select MaQuyDoi, DieuKienLoaiHinh.QuyRaGioChuan, dbo.QuyDoiDieuKien('', DieuKien, SLSV) as ckec from @HuongDan_Quy_SL HDQSL, DieuKienLoaiHinh where HDQSL.MaQuyDoi = DieuKienLoaiHinh.MaLoaiHinhCon
	delete from @HuongDan_Quy_Gio_Chuan where chec = 0
	
	-- tinh gio chuan -- 

	
		declare @HuongDan_GioChuan table
		(

			TenLoaiHinh nvarchar(200),
			TenHV nvarchar(200), 
			TenLop nvarchar(200),
			TenHe nvarchar(200),
			SoCanBoHD int,
			GioChuan float , 
			GhiChu nvarchar(200) NULL
		)
		insert @HuongDan_GioChuan
		select TenLoaiHinhCon, TenHV, TenLop, TenHe, SoCanBoHD, HDQG.QuyChuan as GioChuan, '' as GhiChu  from @HuongDan_Quy_Gio_Chuan HDQG, @HuongDan_Ten_Lop_He HDTLH, QuyDoiLoaiHinh where HDQG.MaQuyDoi = HDQG.MaQuyDoi and QuyDoiLoaiHinh.MaLoaiHinhCon= HDQG.MaQuyDoi
		
		insert @rtntablehuongdan
		select * from @HuongDan_GioChuan
		return

END

GO
/****** Object:  UserDefinedFunction [dbo].[TinhSoLuongHocHamTheoKhoa]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[TinhSoLuongHocHamTheoKhoa](@MaKhoa char(20), @Date datetime)
RETURNS @temp2  TABLE (
TenKhoa NVARCHAR(200),
TenHocVi NVARCHAR(200),
SoLuong INT)
as
begin
	DECLARE @temp TABLE (
	TenKhoa NVARCHAR(200),
	TenHocVi NVARCHAR(200),
	SoLuong INT)


	INSERT INTO @temp 
	SELECT TenKhoa,tenhh,COUNT(tenhh) AS "sl"
	FROM dbo.Khoa,dbo.GiaoVien_Khoa, (SELECT * FROM dbo.magv_thuoc_khoa(@MaKhoa,@Date)) AS a, (SELECT * FROM magv_tenhh(@Date))AS b
	WHERE Khoa.MaKhoa=dbo.GiaoVien_Khoa.MaKhoa AND dbo.GiaoVien_Khoa.MaGiaoVien=a.magv AND a.magv=b.magv
	GROUP BY TenKhoa,tenhh


	INSERT INTO @temp2
	SELECT * FROM @temp

	INSERT INTO @temp2
	SELECT TenKhoa, N'Tổng', SUM(SoLuong)
	FROM @temp 
	GROUP BY TenKhoa


	return
END
GO
/****** Object:  UserDefinedFunction [dbo].[TongGD]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[TongGD](@magv char(20), @time datetime )
returns float
as 
begin
	declare @ANS float
	set @ANS = 0
	select @ANS = @ANS + GioChuan from  TinhHuongDan(@magv, '1900-1-1', @time)
	select @ANS = @ANS + SoGio from  TinhChamThi(@magv, '1900-1-1', @time)
	select @ANS = @ANS + GioChuan from  GiangDay(@magv, '1900-1-1', @time)
	return @ANS
end
GO
/****** Object:  UserDefinedFunction [dbo].[TongGiangDayTheoNam]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[TongGiangDayTheoNam](@magv char(20), @time date )
returns float
as 
begin
	
	declare @timeend date
	set @timeend =  DATEADD(year,1,  @time)
	set @timeend = DATEadd(day,-1,  @timeend)
	declare @ANS float
	set @ANS = 0
	select @ANS = @ANS + GioChuan from  TinhHuongDan(@magv, @time,@timeend)
	select @ANS = @ANS + SoGio from  TinhChamThi(@magv, @time,@timeend)
	select @ANS = @ANS + GioChuan from  GiangDay(@magv, @time,@timeend)
	
	return @ANS
end 
GO
/****** Object:  UserDefinedFunction [dbo].[TongTaiNCKH_GV]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[TongTaiNCKH_GV](@magiaovien CHAR(20),@time date )
RETURNS @tb_TaiNCKH TABLE(
	ThucTai int,
	TaiYeuCau int,
	NCKH int
)
AS
BEGIN
	DECLARE @Sum INT, @Sum_bb INT,@Sum_dt INT, @Sum_s INT,@YeuCau INT,@ThoiGianChuan INT,@NCKH INT
	SET @Sum = 0
	SET @Sum_bb = 0
	SET @Sum_dt = 0
	SET @Sum_s = 0
	-----------------Tinh Tong tai ---
	SELECT @Sum_bb = SUM(SoGioChuan)FROM ThongKe_BaiBao(@magiaovien)
	WHERE CAST(ThoiGianBatDau AS DATE) <= CAST(@time AS DATE)
	AND CAST(ThoiGianKetThuc AS DATE) >= CAST(@time AS DATE)
	-------------------
	SELECT @Sum_dt = SUM(SoGioChuan) FROM dbo.ThongKe_DeTai(@magiaovien)
	WHERE CAST(ThoiGianBatDau AS DATE) <= CAST(@time AS DATE)
	AND CAST(ThoiGianKetThuc AS DATE) >= CAST(@time AS DATE)
	------------------
	SELECT @Sum_s = SUM(SoGioChuan) FROM dbo.ThongKe_BienSoanSach(@magiaovien)
	WHERE CAST(ThoiGianBatDau AS DATE) <= CAST(@time AS DATE)
	AND CAST(ThoiGianKetThuc AS DATE) >= CAST(@time AS DATE)
	IF(@Sum_bb IS NULL)  SET @Sum_bb = 0
	IF(@Sum_dt IS NULL) SET @Sum_dt = 0
	IF(@Sum_s IS NULL) SET @Sum_s = 0
	SET @Sum = @Sum_bb + @Sum_dt + @Sum_s
	-----------------------
	
	SELECT @ThoiGianChuan = ThoiGianChuanNghienCuu FROM
	(
		SELECT  MaGiaoVien,TenChucDanh,MaDinhMucChucDanh 
		FROM dbo.GiaoVien_ChucDanh, dbo.ChucDanh
		WHERE dbo.GiaoVien_ChucDanh.MaChucDanh = dbo.ChucDanh.MaChucDanh 
		AND dbo.GiaoVien_ChucDanh.ThoiGianNhanBatDau<@time
		AND (dbo.GiaoVien_ChucDanh.ThoiGianNhanKetThuc IS NULL OR dbo.GiaoVien_ChucDanh.ThoiGianNhanKetThuc > @time)
		AND @magiaovien = MaGiaoVien
	) AS a, dbo.DinhMucChucDanh
	WHERE DinhMucChucDanh.MaDinhMucChucDanh = a.MaDinhMucChucDanh
	SET @YeuCau = @ThoiGianChuan - ( @ThoiGianChuan * dbo.MienGiam(@magiaovien,@time) /100)
	SELECT @NCKH = @Sum * 100 / @YeuCau
	INSERT INTO @tb_TaiNCKH(ThucTai,TaiYeuCau,NCKH)
	VALUES(@Sum,@YeuCau,@NCKH)
	RETURN
END
GO
/****** Object:  Table [dbo].[ApDungThucTien]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApDungThucTien](
	[MaApDungThucTien] [char](20) NOT NULL,
	[HieuQuaThucTien] [nvarchar](200) NULL,
	[DiaChiApDung] [nvarchar](200) NULL,
	[QuyMoApDung] [nvarchar](200) NULL,
	[HinhThucApDung] [nvarchar](200) NULL,
	[ThoiGianApDung] [date] NULL,
	[MaDuAn] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaApDungThucTien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BaiBao]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaiBao](
	[MaBaiBao] [char](20) NOT NULL,
	[MaLoaiHinhCon] [char](20) NULL,
	[TenBaiBao] [nvarchar](200) NULL,
	[SoLuongTacGia] [int] NULL,
	[ThoiGian] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBaiBao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BienSoanSach]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BienSoanSach](
	[MaSach] [char](20) NOT NULL,
	[TenSach] [nvarchar](200) NULL,
	[NoiXuatBan] [nvarchar](200) NULL,
	[SoLuongThanhVien] [int] NULL,
	[ThoiGianXuatBan] [date] NULL,
	[SoTrang] [int] NULL,
	[DonViHocTrinh] [int] NULL,
	[MaLoaiHinhCon] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BoMon]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BoMon](
	[MaBoMon] [char](20) NOT NULL,
	[TenBoMon] [nvarchar](200) NULL,
	[MaKhoa] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBoMon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CacLoaiHinhDaoTao]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CacLoaiHinhDaoTao](
	[MaLoaiHinhDaoTao] [char](20) NOT NULL,
	[TenLoaiHinhDaoTao] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiHinhDaoTao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChinhQuyen]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChinhQuyen](
	[MaChinhQuyen] [char](20) NOT NULL,
	[MaChucVuChinhQuyen] [char](20) NULL,
	[MaDonViChinhQuyen] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChinhQuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChucDanh]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucDanh](
	[MaChucDanh] [char](20) NOT NULL,
	[TenChucDanh] [nvarchar](200) NULL,
	[MaDinhMucChucDanh] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChucDanh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChucVuChinhQuyen]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVuChinhQuyen](
	[MaChucVuChinhQuyen] [char](20) NOT NULL,
	[TenChucVuChinhQuyen] [nvarchar](50) NULL,
	[MaDinhMucMienGiam] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChucVuChinhQuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChucVuDang]    Script Date: 6/30/2019 2:17:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVuDang](
	[MaChucVuDang] [char](20) NOT NULL,
	[TenChucVuDang] [nvarchar](50) NULL,
	[MaDinhMucMienGiam] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChucVuDang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[chuongtrinhdaotao]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chuongtrinhdaotao](
	[Machuongtrinhdaotao] [char](20) NOT NULL,
	[Tenchuongtrinhdaotao] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Machuongtrinhdaotao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dang]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dang](
	[MaDang] [char](20) NOT NULL,
	[MaDonViDang] [char](20) NULL,
	[MaChucVuDang] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DangKiBangSoHuu]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DangKiBangSoHuu](
	[MaBangSangChe] [char](20) NOT NULL,
	[SoHieu] [char](20) NULL,
	[ThoiGianCap] [date] NULL,
	[PhamVi] [nvarchar](200) NULL,
	[NoiCap] [nvarchar](200) NULL,
	[MaDuAn] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBangSangChe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DaoTaoDaiHoc]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DaoTaoDaiHoc](
	[MaDaoTaoDaiHoc] [char](20) NOT NULL,
	[HeDaoTao] [nvarchar](200) NULL,
	[NoiDaoTao] [nvarchar](200) NULL,
	[NuocDaoTao] [nvarchar](200) NULL,
	[NganhDaoTao] [nvarchar](200) NULL,
	[ThoiGianDaoTao] [char](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDaoTaoDaiHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DaoTaoKhac]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DaoTaoKhac](
	[MaDaoTaoKhac] [char](20) NULL,
	[MaDaoTaoSauDaiHoc] [char](20) NULL,
	[GhiChu] [nvarchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DaoTaoSauDaiHoc]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DaoTaoSauDaiHoc](
	[MaDaoTaoSauDaiHoc] [char](20) NOT NULL,
	[LoaiDaoTao] [nvarchar](200) NULL,
	[NoiDaoTao] [nvarchar](200) NULL,
	[ThoiGianDaoTao] [char](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDaoTaoSauDaiHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeTaiNghienCuu]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeTaiNghienCuu](
	[MaDeTai] [char](20) NOT NULL,
	[TenDeTai] [nvarchar](200) NULL,
	[SoLuongThanhVien] [int] NULL,
	[MaLoaiHinhCon] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDeTai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DieuKienLoaiHinh]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DieuKienLoaiHinh](
	[DieuKienLoaiHinh] [char](20) NOT NULL,
	[DieuKien] [nvarchar](200) NULL,
	[DonViTinh] [nvarchar](200) NULL,
	[QuyRaGioChuan] [float] NULL,
	[MaLoaiHinhCon] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[DieuKienLoaiHinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DinhMucChucDanh]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucChucDanh](
	[MaDinhMucChucDanh] [char](20) NOT NULL,
	[TenChucDanh] [nvarchar](100) NULL,
	[GioQuyDinhChungGiangDay] [int] NULL,
	[GioMonTheChatGiaoDucQuocPhong] [int] NULL,
	[ThoiGianNghienCuu] [int] NULL,
	[ThoiGianChuanNghienCuu] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDinhMucChucDanh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DinhMucGiamDacBiet]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucGiamDacBiet](
	[MaDinhMucGiamDacBiet] [char](20) NOT NULL,
	[TenDinhMucGiam] [nvarchar](200) NULL,
	[TyLeGiam] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDinhMucGiamDacBiet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DinhMucMienGiamChucVu]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucMienGiamChucVu](
	[MaDinhMucMienGiam] [char](20) NOT NULL,
	[TyLeMienGiamThap] [int] NULL,
	[TyLeMienGiamCao] [int] NULL,
	[Loai] [int] NULL,
	[TenChucVu] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDinhMucMienGiam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonViChinhQuyen]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonViChinhQuyen](
	[MaDonViChinhQuyen] [char](20) NOT NULL,
	[TenDonViChinhQuyen] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDonViChinhQuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonViDang]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonViDang](
	[MaDonViDang] [char](20) NOT NULL,
	[TenDonViDang] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDonViDang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DuAn]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DuAn](
	[MaDuAn] [char](20) NOT NULL,
	[TenDuAn] [nvarchar](200) NULL,
	[MoTa] [nvarchar](200) NULL,
	[MaCoQuanQuanLy] [char](20) NULL,
	[TinhTrang] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDuAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DuAn_GiaiThuong]    Script Date: 6/30/2019 2:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DuAn_GiaiThuong](
	[MaDuAn] [char](20) NULL,
	[MaGiaiThuong] [char](20) NULL,
	[ThoiGianNhan] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaiThuong]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaiThuong](
	[MaGiaiThuong] [char](20) NOT NULL,
	[TenGiaiThuong] [nvarchar](200) NULL,
	[PhamVi] [nvarchar](200) NULL,
	[NoiCap] [nvarchar](200) NULL,
	[ToChucTraoThuong] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaGiaiThuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien](
	[MaGiaoVien] [char](20) NOT NULL,
	[TenGiaoVien] [nvarchar](200) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [nvarchar](20) NULL,
	[QueQuan] [nvarchar](200) NULL,
	[DiaChi] [nvarchar](200) NULL,
	[SDT] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaGiaoVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_BaiBao]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_BaiBao](
	[MaGiaoVien] [char](20) NULL,
	[MaBaiBao] [char](20) NULL,
	[ThoiGianBatDau] [date] NULL,
	[ThoiGianHoanThanh] [date] NULL,
	[VaiTroTrongBaiBao] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_BienSoanSach]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_BienSoanSach](
	[MaGiaoVien] [char](20) NULL,
	[MaSach] [char](20) NULL,
	[ThoiGianBatDau] [date] NULL,
	[ThoiGianKetThuc] [date] NULL,
	[VaiTroTrongBienSoan] [int] NULL,
	[SoTrangViet] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_ChinhQuyen]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_ChinhQuyen](
	[MaGiaoVien] [char](20) NULL,
	[MaChinhQuyen] [char](20) NULL,
	[ThoiGianNhan] [date] NULL,
	[ThoiGianKetThuc] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_ChucDanh]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_ChucDanh](
	[MaGiaoVien] [char](20) NULL,
	[MaChucDanh] [char](20) NULL,
	[ThoiGianNhanBatDau] [date] NULL,
	[ThoiGianNhanKetThuc] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_Dang]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_Dang](
	[MaGiaoVien] [char](20) NULL,
	[MaDang] [char](20) NULL,
	[ThoiGianNhan] [date] NULL,
	[ThoiGianKetThuc] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_DuAn]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_DuAn](
	[MaGiaoVien] [char](20) NULL,
	[MaDuAn] [char](20) NULL,
	[ThoiGianBatDau] [date] NULL,
	[ThoiGianHoanThanh] [date] NULL,
	[VaiTroTrongDuAn] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_GiamDacBiet]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_GiamDacBiet](
	[MaGiaoVien] [char](20) NOT NULL,
	[MaDinhMucGiamDacBiet] [char](20) NOT NULL,
	[ThoiGianBatDau] [date] NULL,
	[ThoiGianKetThuc] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaGiaoVien] ASC,
	[MaDinhMucGiamDacBiet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_HocHam]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_HocHam](
	[MaGiaoVien] [char](20) NULL,
	[MaHocHam] [char](20) NULL,
	[ThoiGianNhan] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_HocPhanChamThi]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_HocPhanChamThi](
	[GiaoVien_HocPhanChamThi] [char](20) NOT NULL,
	[MaGiaoVien] [char](20) NULL,
	[MaHocPhanChamThi] [char](20) NULL,
	[ThoiGianBatDau] [datetime] NULL,
	[ThoiGianKetThuc] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[GiaoVien_HocPhanChamThi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_HocVi]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_HocVi](
	[MaGiaoVien] [char](20) NULL,
	[MaHocVi] [char](20) NULL,
	[ThoiGianNhan] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_HuongDan]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_HuongDan](
	[GiaoVien_HuongDan] [char](20) NOT NULL,
	[MaGiaoVien] [char](20) NULL,
	[MaHuongDan] [char](20) NULL,
	[ThoiGianBatDau] [datetime] NULL,
	[ThoiGianKetThuc] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[GiaoVien_HuongDan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_HuongNghienCuu]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_HuongNghienCuu](
	[MaGiaoVien] [char](20) NULL,
	[MaHuongNghienCuu] [char](20) NULL,
	[ThoiGianBatDau] [date] NULL,
	[ThoiGianKetThuc] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_KhenThuongKyLuat]    Script Date: 6/30/2019 2:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_KhenThuongKyLuat](
	[MaGiaoVien] [char](20) NULL,
	[MaKhenThuongKyLuat] [char](20) NULL,
	[TenKhenThuongKyLuatNhan] [nvarchar](200) NULL,
	[ThoiGianNhan] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_Khoa]    Script Date: 6/30/2019 2:17:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_Khoa](
	[MaGiaoVien] [char](20) NULL,
	[MaKhoa] [char](20) NULL,
	[ThoiGianBatDau] [date] NULL,
	[ThoiGianKetThuc] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_LopHoc]    Script Date: 6/30/2019 2:17:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_LopHoc](
	[GiaoVien_LopHoc] [char](20) NOT NULL,
	[MaGiaoVien] [char](20) NULL,
	[MaLopHoc] [char](20) NULL,
	[ThoiGianBatDau] [datetime] NULL,
	[ThoiGianKetThuc] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[GiaoVien_LopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_NghienCuuKhoaHoc]    Script Date: 6/30/2019 2:17:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_NghienCuuKhoaHoc](
	[MaGiaoVien] [char](20) NULL,
	[MaDeTai] [char](20) NULL,
	[ThoiGianBatDau] [date] NULL,
	[ThoiGianHoanThanh] [date] NULL,
	[VaiTroTrongNghienCuu] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_NgoaiNgu]    Script Date: 6/30/2019 2:17:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_NgoaiNgu](
	[MaGiaoVien] [char](20) NULL,
	[MaNgoaiNgu] [char](20) NULL,
	[ThoiGianNhan] [date] NULL,
	[TrinhDo] [char](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[He]    Script Date: 6/30/2019 2:17:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[He](
	[MaHe] [char](20) NOT NULL,
	[TenHe] [nvarchar](200) NULL,
	[Machuongtrinhdaotao] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocHam]    Script Date: 6/30/2019 2:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocHam](
	[MaHocHam] [char](20) NOT NULL,
	[TenHocHam] [nvarchar](200) NULL,
	[MaDinhMucChucDanh] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHocHam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocPhan]    Script Date: 6/30/2019 2:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocPhan](
	[MaHocPhan] [char](20) NOT NULL,
	[TenHocPhan] [nvarchar](200) NULL,
	[SoTinChi] [int] NULL,
	[SoTiet] [int] NULL,
	[MaBoMon] [char](20) NULL,
	[MaLoaiHinhCon] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHocPhan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocPhanChamThi]    Script Date: 6/30/2019 2:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocPhanChamThi](
	[MaHocPhanChamThi] [char](20) NOT NULL,
	[SoBai] [int] NULL,
	[MaLopHoc] [char](20) NULL,
	[MaQuyDoi] [char](20) NULL,
	[GhiChu] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHocPhanChamThi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocVi]    Script Date: 6/30/2019 2:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocVi](
	[MaHocVi] [char](20) NOT NULL,
	[TenHocVi] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHocVi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocVien]    Script Date: 6/30/2019 2:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocVien](
	[MaHocVien] [char](20) NOT NULL,
	[TenHocVien] [nvarchar](200) NULL,
	[MaLop] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHocVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HuongDan]    Script Date: 6/30/2019 2:17:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HuongDan](
	[MaHuongDan] [char](20) NOT NULL,
	[TenDeTai_ChuDe] [nvarchar](200) NULL,
	[SoCanBoHuongDan] [int] NULL,
	[ThoiGianBatDau] [datetime] NULL,
	[ThoiGianKetThuc] [datetime] NULL,
	[MaHocVien] [char](20) NULL,
	[MaQuyDoi] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHuongDan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HuongNghienCuu]    Script Date: 6/30/2019 2:17:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HuongNghienCuu](
	[MaHuongNghienCuu] [char](20) NOT NULL,
	[TenHuongNghienCuu] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHuongNghienCuu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhenThuongKyLuat]    Script Date: 6/30/2019 2:17:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhenThuongKyLuat](
	[MaKhenThuongKyLuat] [char](20) NOT NULL,
	[TenKhenThuongKyLuat] [nvarchar](200) NULL,
	[Loai] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKhenThuongKyLuat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 6/30/2019 2:17:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[MaKhoa] [char](20) NOT NULL,
	[TenKhoa] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiHinhChinhNCKH]    Script Date: 6/30/2019 2:17:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiHinhChinhNCKH](
	[MaLoaiHinhChinh] [char](20) NOT NULL,
	[TenLoaiHinhChinh] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiHinhChinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiHinhConNCKH]    Script Date: 6/30/2019 2:17:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiHinhConNCKH](
	[MaLoaiHinhCon] [char](20) NOT NULL,
	[TenLoaiHinhCon] [nvarchar](200) NULL,
	[DonViTinh] [nvarchar](50) NULL,
	[GioChuan] [int] NULL,
	[MaLoaiHinhChinh] [char](20) NULL,
	[TyLeChinh] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiHinhCon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lop]    Script Date: 6/30/2019 2:17:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lop](
	[MaLop] [char](20) NOT NULL,
	[TenLop] [nvarchar](200) NULL,
	[SiSo] [int] NULL,
	[MaHe] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopHoc]    Script Date: 6/30/2019 2:17:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopHoc](
	[MaLopHoc] [char](20) NOT NULL,
	[TenLopHoc] [nvarchar](200) NULL,
	[CSN_CN] [char](20) NULL,
	[HocKy] [nvarchar](200) NULL,
	[MaLop] [char](20) NULL,
	[MaHocPhan] [char](20) NULL,
	[MaQuyDoi] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NgoaiNgu]    Script Date: 6/30/2019 2:17:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NgoaiNgu](
	[MaNgoaiNgu] [char](20) NOT NULL,
	[TenNgoaiNgu] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNgoaiNgu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuaTrinhDaoTao]    Script Date: 6/30/2019 2:17:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuaTrinhDaoTao](
	[MaGiaoVien] [char](20) NULL,
	[MaQuaTrinhDaoTao] [char](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaQuaTrinhDaoTao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc]    Script Date: 6/30/2019 2:17:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc](
	[MaQuaTrinhDaoTao] [char](20) NULL,
	[MaDaoTaoDaiHoc] [char](20) NULL,
	[NamTotNghiep] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuaTrinhDaoTao_DaoTaoSauDaiHoc]    Script Date: 6/30/2019 2:17:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuaTrinhDaoTao_DaoTaoSauDaiHoc](
	[MaQuaTrinhDaoTao] [char](20) NULL,
	[MaDaoTaoSauDaiHoc] [char](20) NULL,
	[NamTotNghiep] [date] NULL,
	[TenDeAnTotNghiep] [nvarchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuyDoiLoaiHinh]    Script Date: 6/30/2019 2:17:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuyDoiLoaiHinh](
	[MaLoaiHinhCon] [char](20) NOT NULL,
	[TenLoaiHinhCon] [nvarchar](200) NULL,
	[MaLoaiHinhDaoTao] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiHinhCon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ApDungThucTien] ([MaApDungThucTien], [HieuQuaThucTien], [DiaChiApDung], [QuyMoApDung], [HinhThucApDung], [ThoiGianApDung], [MaDuAn]) VALUES (N'adtt001             ', N'Áp dụng vào quá trình thi trắc nghiệm trong các nhà trường quân đội', N'Bộ Quốc phòng', N'Toàn quân', N'Hệ thống', CAST(N'2019-06-22' AS Date), N'duan004             ')
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0001              ', N'loaihinhcon001      ', N'A fast learning algorithm for deep belief nets', 3, CAST(N'2006-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0002              ', N'loaihinhcon001      ', N'Reducing the dimensionality of data with neural networks', 4, CAST(N'2006-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0003              ', N'loaihinhcon001      ', N'Imagenet classification with deep convolutional neural networks', 1, CAST(N'2013-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0004              ', N'loaihinhcon001      ', N'Very deep convolutional networks for large-scale image recognition', 6, CAST(N'2015-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0005              ', N'loaihinhcon002      ', N'Going deeper with convolutions', 2, CAST(N'2007-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0006              ', N'loaihinhcon002      ', N'Deep residual learning for image recognition', 5, CAST(N'2015-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0007              ', N'loaihinhcon002      ', N'Deep neural networks for acoustic modeling in speech recognition: The shared views of four research groups.', 6, CAST(N'2012-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0008              ', N'loaihinhcon003      ', N'Speech recognition with deep recurrent neural networks', 4, CAST(N'2013-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0009              ', N'loaihinhcon003      ', N'Towards End-To-End Speech Recognition with Recurrent Neural Networks', 4, CAST(N'2014-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0010              ', N'loaihinhcon003      ', N'Fast and accurate recurrent neural network acoustic models for speech recognition', 3, CAST(N'2015-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0011              ', N'loaihinhcon004      ', N'Deep speech 2: End-to-end speech recognition in english and mandarin', 2, CAST(N'2015-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0012              ', N'loaihinhcon004      ', N'Improving neural networks by preventing co-adaptation of feature detectors', 3, CAST(N'2016-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0013              ', N'loaihinhcon004      ', N'Dropout: a simple way to prevent neural networks from overfitting', 3, CAST(N'2016-01-01' AS Date))
INSERT [dbo].[BaiBao] ([MaBaiBao], [MaLoaiHinhCon], [TenBaiBao], [SoLuongTacGia], [ThoiGian]) VALUES (N'bb0014              ', N'loaihinhcon004      ', N'Binarized Neural Networks: Training Neural Networks with Weights and Activations Constrained to+ 1 or−1.', 3, CAST(N'2016-01-01' AS Date))
INSERT [dbo].[BienSoanSach] ([MaSach], [TenSach], [NoiXuatBan], [SoLuongThanhVien], [ThoiGianXuatBan], [SoTrang], [DonViHocTrinh], [MaLoaiHinhCon]) VALUES (N'sach001             ', N'Đại số tuyến tính', N'Nhà xuất bản Giáo dục', 10, CAST(N'2017-01-01' AS Date), 300, 5, N'loaihinhcon007      ')
INSERT [dbo].[BienSoanSach] ([MaSach], [TenSach], [NoiXuatBan], [SoLuongThanhVien], [ThoiGianXuatBan], [SoTrang], [DonViHocTrinh], [MaLoaiHinhCon]) VALUES (N'sach002             ', N'Toán chuyên đề', N'Nhà xuất bản HVKTQS', 15, CAST(N'2015-01-01' AS Date), 200, 5, N'loaihinhcon008      ')
INSERT [dbo].[BienSoanSach] ([MaSach], [TenSach], [NoiXuatBan], [SoLuongThanhVien], [ThoiGianXuatBan], [SoTrang], [DonViHocTrinh], [MaLoaiHinhCon]) VALUES (N'sach003             ', N'Cơ sở dữ liệu nâng cao', N'Nhà xuất bản HVKTQS', 0, CAST(N'2015-01-01' AS Date), 150, 6, N'loaihinhcon009      ')
INSERT [dbo].[BienSoanSach] ([MaSach], [TenSach], [NoiXuatBan], [SoLuongThanhVien], [ThoiGianXuatBan], [SoTrang], [DonViHocTrinh], [MaLoaiHinhCon]) VALUES (N'sach004             ', N'Phương pháp phét triển hệ thống thông tin', N'Nhà xuất bản HVKTQS', 6, CAST(N'2018-01-01' AS Date), 100, 5, N'loaihinhcon010      ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM01                ', N'An toàn thông tin', N'Khoa01              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM02                ', N'Hệ thống thông tin', N'Khoa01              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM03                ', N'Công nghệ mạng', N'Khoa01              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM04                ', N'Công nghệ phần mềm', N'Khoa01              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM05                ', N'Vô tuyến điện tử', N'Khoa02              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM06                ', N'Điều khiển tự động', N'Khoa02              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM07                ', N'Tư tưởng Hồ Chí Minh', N'Khoa03              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM08                ', N'Công tác Đảng', N'Khoa03              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM09                ', N'Triết học Mac-Lênin', N'Khoa03              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM10                ', N'Vật lý', N'Khoa04              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM11                ', N'Hóa học', N'Khoa04              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM12                ', N'Tiếng anh', N'Khoa05              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM13                ', N'An toàn thông tin', N'Khoa06              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM14                ', N'Vật liệu xây dựng', N'Khoa06              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM15                ', N'Tiếng nhật', N'Khoa05              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM16                ', N'cầu đường', N'Khoa06              ')
INSERT [dbo].[BoMon] ([MaBoMon], [TenBoMon], [MaKhoa]) VALUES (N'BM17                ', N'Xây dựng dân dụng', N'Khoa06              ')
INSERT [dbo].[CacLoaiHinhDaoTao] ([MaLoaiHinhDaoTao], [TenLoaiHinhDaoTao]) VALUES (N'LHDT01              ', N'Giờ lên lớp')
INSERT [dbo].[CacLoaiHinhDaoTao] ([MaLoaiHinhDaoTao], [TenLoaiHinhDaoTao]) VALUES (N'LHDT02              ', N'Hướng dẫn đồ án')
INSERT [dbo].[CacLoaiHinhDaoTao] ([MaLoaiHinhDaoTao], [TenLoaiHinhDaoTao]) VALUES (N'LHDT03              ', N'Chấm Thi và nghiệm thu, phản biện đề tài')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq001               ', N'cvcq003             ', N'dvcq001             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq002               ', N'cvcq004             ', N'dvcq001             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq003               ', N'cvcq009             ', N'dvcq001             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq004               ', N'cvcq003             ', N'dvcq002             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq005               ', N'cvcq004             ', N'dvcq002             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq006               ', N'cvcq009             ', N'dvcq002             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq007               ', N'cvcq003             ', N'dvcq003             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq008               ', N'cvcq004             ', N'dvcq003             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq009               ', N'cvcq009             ', N'dvcq003             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq010               ', N'cvcq003             ', N'dvcq004             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq011               ', N'cvcq004             ', N'dvcq004             ')
INSERT [dbo].[ChinhQuyen] ([MaChinhQuyen], [MaChucVuChinhQuyen], [MaDonViChinhQuyen]) VALUES (N'cq012               ', N'cvcq009             ', N'dvcq004             ')
INSERT [dbo].[ChucDanh] ([MaChucDanh], [TenChucDanh], [MaDinhMucChucDanh]) VALUES (N'cd001               ', N'Giáo sư', N'dmcd001             ')
INSERT [dbo].[ChucDanh] ([MaChucDanh], [TenChucDanh], [MaDinhMucChucDanh]) VALUES (N'cd002               ', N'Phó Giáo sư', N'dmcd002             ')
INSERT [dbo].[ChucDanh] ([MaChucDanh], [TenChucDanh], [MaDinhMucChucDanh]) VALUES (N'cd003               ', N'Giảng viên chính', N'dmcd002             ')
INSERT [dbo].[ChucDanh] ([MaChucDanh], [TenChucDanh], [MaDinhMucChucDanh]) VALUES (N'cd004               ', N'Giảng viên', N'dmcd003             ')
INSERT [dbo].[ChucDanh] ([MaChucDanh], [TenChucDanh], [MaDinhMucChucDanh]) VALUES (N'cd005               ', N'Trợ giảng', N'dmcd004             ')
INSERT [dbo].[ChucVuChinhQuyen] ([MaChucVuChinhQuyen], [TenChucVuChinhQuyen], [MaDinhMucMienGiam]) VALUES (N'cvcq001             ', N'Giám đốc Học viện', N'mgcv001             ')
INSERT [dbo].[ChucVuChinhQuyen] ([MaChucVuChinhQuyen], [TenChucVuChinhQuyen], [MaDinhMucMienGiam]) VALUES (N'cvcq002             ', N'Chính ủy Học viện', N'mgcv002             ')
INSERT [dbo].[ChucVuChinhQuyen] ([MaChucVuChinhQuyen], [TenChucVuChinhQuyen], [MaDinhMucMienGiam]) VALUES (N'cvcq003             ', N'Chủ nhiệm Khoa', N'mgcv003             ')
INSERT [dbo].[ChucVuChinhQuyen] ([MaChucVuChinhQuyen], [TenChucVuChinhQuyen], [MaDinhMucMienGiam]) VALUES (N'cvcq004             ', N'Phó chủ nhiệm Khoa', N'mgcv004             ')
INSERT [dbo].[ChucVuChinhQuyen] ([MaChucVuChinhQuyen], [TenChucVuChinhQuyen], [MaDinhMucMienGiam]) VALUES (N'cvcq005             ', N'Chủ nhiệm Bộ môn', N'mgcv004             ')
INSERT [dbo].[ChucVuChinhQuyen] ([MaChucVuChinhQuyen], [TenChucVuChinhQuyen], [MaDinhMucMienGiam]) VALUES (N'cvcq006             ', N'Phó chủ nhiệm bộ môn', N'mgcv005             ')
INSERT [dbo].[ChucVuChinhQuyen] ([MaChucVuChinhQuyen], [TenChucVuChinhQuyen], [MaDinhMucMienGiam]) VALUES (N'cvcq007             ', N'Trưởng phòng thí nghiệm', N'mgcv005             ')
INSERT [dbo].[ChucVuChinhQuyen] ([MaChucVuChinhQuyen], [TenChucVuChinhQuyen], [MaDinhMucMienGiam]) VALUES (N'cvcq008             ', N'Phó trưởng phòng thí nghiệm', N'mgcv006             ')
INSERT [dbo].[ChucVuChinhQuyen] ([MaChucVuChinhQuyen], [TenChucVuChinhQuyen], [MaDinhMucMienGiam]) VALUES (N'cvcq009             ', N'Giáo viên', N'mgcv013             ')
INSERT [dbo].[ChucVuDang] ([MaChucVuDang], [TenChucVuDang], [MaDinhMucMienGiam]) VALUES (N'cvd001              ', N'Bí thư đảng ủy', N'mgcv007             ')
INSERT [dbo].[ChucVuDang] ([MaChucVuDang], [TenChucVuDang], [MaDinhMucMienGiam]) VALUES (N'cvd002              ', N'Phó Bí thư đảng ủy', N'mgcv008             ')
INSERT [dbo].[ChucVuDang] ([MaChucVuDang], [TenChucVuDang], [MaDinhMucMienGiam]) VALUES (N'cvd003              ', N'Bí thư chi bộ', N'mgcv008             ')
INSERT [dbo].[ChucVuDang] ([MaChucVuDang], [TenChucVuDang], [MaDinhMucMienGiam]) VALUES (N'cvd004              ', N'Bí thư đoàn cơ sở', N'mgcv009             ')
INSERT [dbo].[ChucVuDang] ([MaChucVuDang], [TenChucVuDang], [MaDinhMucMienGiam]) VALUES (N'cvd005              ', N'Đảng viên', N'mgcv014             ')
INSERT [dbo].[chuongtrinhdaotao] ([Machuongtrinhdaotao], [Tenchuongtrinhdaotao]) VALUES (N'CTDT01              ', N'Giảng dạy đại học (CQ + VB2)')
INSERT [dbo].[chuongtrinhdaotao] ([Machuongtrinhdaotao], [Tenchuongtrinhdaotao]) VALUES (N'CTDT02              ', N'Giảng dạy cao học')
INSERT [dbo].[chuongtrinhdaotao] ([Machuongtrinhdaotao], [Tenchuongtrinhdaotao]) VALUES (N'CTDT03              ', N'Giảng dạy nghiên cứu sinh')
INSERT [dbo].[chuongtrinhdaotao] ([Machuongtrinhdaotao], [Tenchuongtrinhdaotao]) VALUES (N'CTDT04              ', N'Giảng dạy cao đẳng')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd001                ', N'dvd001              ', N'cvd001              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd002                ', N'dvd001              ', N'cvd002              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd003                ', N'dvd001              ', N'cvd005              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd004                ', N'dvd002              ', N'cvd001              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd005                ', N'dvd002              ', N'cvd002              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd006                ', N'dvd002              ', N'cvd005              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd007                ', N'dvd003              ', N'cvd001              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd008                ', N'dvd003              ', N'cvd002              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd009                ', N'dvd003              ', N'cvd005              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd010                ', N'dvd004              ', N'cvd001              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd011                ', N'dvd004              ', N'cvd002              ')
INSERT [dbo].[Dang] ([MaDang], [MaDonViDang], [MaChucVuDang]) VALUES (N'd012                ', N'dvd004              ', N'cvd005              ')
INSERT [dbo].[DangKiBangSoHuu] ([MaBangSangChe], [SoHieu], [ThoiGianCap], [PhamVi], [NoiCap], [MaDuAn]) VALUES (N'bsc0001             ', N'111111              ', CAST(N'2015-01-01' AS Date), N'Trong nước', N'Cục Sở Hữu Trí Tuệ', N'duan001             ')
INSERT [dbo].[DangKiBangSoHuu] ([MaBangSangChe], [SoHieu], [ThoiGianCap], [PhamVi], [NoiCap], [MaDuAn]) VALUES (N'bsc0002             ', N'111112              ', CAST(N'2015-01-01' AS Date), N'Trong nước', N'Cục Sở Hữu Trí Tuệ', N'duan002             ')
INSERT [dbo].[DangKiBangSoHuu] ([MaBangSangChe], [SoHieu], [ThoiGianCap], [PhamVi], [NoiCap], [MaDuAn]) VALUES (N'bsc0003             ', N'111113              ', CAST(N'2015-01-01' AS Date), N'Trong nước', N'Cục Sở Hữu Trí Tuệ', N'duan003             ')
INSERT [dbo].[DaoTaoDaiHoc] ([MaDaoTaoDaiHoc], [HeDaoTao], [NoiDaoTao], [NuocDaoTao], [NganhDaoTao], [ThoiGianDaoTao]) VALUES (N'dtdh001             ', N'Kỹ sư', N'HVKTQS', N'Việt Nam', N'CNTT', N'5 nam     ')
INSERT [dbo].[DaoTaoDaiHoc] ([MaDaoTaoDaiHoc], [HeDaoTao], [NoiDaoTao], [NuocDaoTao], [NganhDaoTao], [ThoiGianDaoTao]) VALUES (N'dtdh002             ', N'Cử nhân', N'HVKTQS', N'Việt Nam', N'CNTT', N'4 nam     ')
INSERT [dbo].[DaoTaoDaiHoc] ([MaDaoTaoDaiHoc], [HeDaoTao], [NoiDaoTao], [NuocDaoTao], [NganhDaoTao], [ThoiGianDaoTao]) VALUES (N'dtdh003             ', N'Kỹ sư', N'Maxcovar', N'Nga', N'CNTT', N'7 nam     ')
INSERT [dbo].[DaoTaoDaiHoc] ([MaDaoTaoDaiHoc], [HeDaoTao], [NoiDaoTao], [NuocDaoTao], [NganhDaoTao], [ThoiGianDaoTao]) VALUES (N'dtdh004             ', N'Kỹ sư', N'Bắc kinh', N'Trung Quốc', N'CNTT', N'7 nam     ')
INSERT [dbo].[DaoTaoSauDaiHoc] ([MaDaoTaoSauDaiHoc], [LoaiDaoTao], [NoiDaoTao], [ThoiGianDaoTao]) VALUES (N'dtsdh001            ', N'Cao học', N'Việt Nam', N'2 nam     ')
INSERT [dbo].[DaoTaoSauDaiHoc] ([MaDaoTaoSauDaiHoc], [LoaiDaoTao], [NoiDaoTao], [ThoiGianDaoTao]) VALUES (N'dtsdh002            ', N'Thạc sỹ', N'Việt Nam', N'3 nam     ')
INSERT [dbo].[DaoTaoSauDaiHoc] ([MaDaoTaoSauDaiHoc], [LoaiDaoTao], [NoiDaoTao], [ThoiGianDaoTao]) VALUES (N'dtsdh003            ', N'Tiến sĩ', N'Việt Nam', N'4 nam     ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0001          ', N'Ứng dụng công nghệ bảo đảm an ninh, an toàn mạng và bí mật thông tin ở mức cao để phát triển bộ giải pháp an toàn an ninh mạng LAN cho cơ quan nhà nước', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0002          ', N'Phân tích ngôn ngữ tự nhiên và trích rút tri thức từ dữ liệu văn bản song ngữ ứng dụng cho dịch máy thống kê', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0003          ', N'Nghiên cứu xây dựng phần mềm công cụ để phát triển các ứng dụng thu thập và xử lý số liệu trong các hệ thống giám sát tập trung', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0004          ', N'Giải pháp nền tảng cho hệ thống tích hợp dữ liệu lớn và không đồng nhất', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0005          ', N'Tăng tốc truyền trực tuyến tệp tin video lớn với định dạng MP4 bằng phương pháp lấy trước thông tin mào đầu', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0006          ', N'Kiểm chứng sự tương đương của các mô hình phần mềm', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0007          ', N'Cơ sở hình thức và công cụ hỗ trợ cho thao tác mô hình trong phát triển phần mềm hướng mô hình', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0008          ', N'Phân tích chương trình và ứng dụng trong kiểm chứng phần mềm', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0009          ', N'Các phương pháp nhanh giải các bài toán phân tích mối quan hệ giữa các trình tự cho các tập dữ liệu lớn,', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0010          ', N'Xây dựng hệ thống hướng dịch vụ hỗ trợ kiểm lỗi chính tả và phát hiện sao chép văn bản', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0011          ', N'Mô hình hóa mức độ ô nhiễm không khí sử dụng dữ liệu ảnh viễn thám và quan trắc đa nguồn, đa thời gian, đa độ phân giải', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0012          ', N'Xây dựng hệ thống cung cấp video 360 độ trên bản đồ trực tuyến cho một số đường phố chính của Hà Nội', 5, N'loaihinhcon005      ')
INSERT [dbo].[DeTaiNghienCuu] ([MaDeTai], [TenDeTai], [SoLuongThanhVien], [MaLoaiHinhCon]) VALUES (N'dtnckh0013          ', N'Nghiên cứu và phát triển công cụ hỗ trợ việc phát hiện sớm bùng nổ sự kiện trên mạng xã hội Facebook', 5, N'loaihinhcon005      ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH01              ', N'0-75', N'Học viên', 1, N'QDLH01              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH02              ', N'76-100', N'Học viên', 1.1, N'QDLH01              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH03              ', N'101-1000', N'Học viên', 1.2, N'QDLH01              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH04              ', N'', N'Tiết', 0.5, N'QDLH02              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH05              ', N'Cơ bản, cơ sở, ngành', N'Tiết', 0.8, N'QDLH03              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH06              ', N'Chuyên nghành', N'Tiết', 1, N'QDLH03              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH07              ', N'', N'Tiết', 0.75, N'QDLH04              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH08              ', N'10', N'Phần trăm số tiết', 1, N'QDLH05              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH09              ', N'Giảng dạy lý thuyết trên lớp, giảng dạy kỹ thuật ở sân bãi', N'Tiết', 1.2, N'QDLH06              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH10              ', N'Bồi dưỡng cán sự thể dục thể thao', N'Tiết', 1, N'QDLH06              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH11              ', N'Hướng dẫn ngoại khóa, khiểm tra sức khỏe kiểm tra rèn luyện thể lực, tổ chức thi trong Học viện hoặc dẫn đội thi đấu ngoài Học viện', N'Tiết', 2.5, N'QDLH06              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH12              ', N'Trọng tài chính bóng đá', N'Trận', 3, N'QDLH06              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH13              ', N'Trọng tài chính bóng rổ, bóng chuyền', N'Trận', 1.2, N'QDLH06              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH14              ', N'Trọng tài chính bóng bàn', N'Trận', 1, N'QDLH06              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH15              ', N'Trọng tài phụ, thư ký bóng đá', N'Trận', 1.5, N'QDLH06              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH16              ', N'Trọng tài phụ, thư ký bóng rổ, bóng chuyền', N'Trận', 1, N'QDLH06              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH17              ', N'Trọng tài phụ, thư ký bóng bàn', N'Trận', 0.5, N'QDLH06              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH18              ', N'1-15', N'Học viên', 1.5, N'QDLH07              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH19              ', N'16-1000', N'Học viên', 0.75, N'QDLH07              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH20              ', N'1-15', N'Học viên', 2, N'QDLH08              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH21              ', N'16-1000', N'Học viên', 1, N'QDLH08              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH22              ', N'', N'Đồ án', 15, N'QDLH09              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH23              ', N'', N'Tiểu luận', 4, N'QDLH10              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH24              ', N'', N'Học viên', 0.333333, N'QDLH11              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH25              ', N'', N'Học viên', 0.25, N'QDLH12              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH26              ', N'', N'Học viên', 0.5, N'QDLH13              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH27              ', N'Bài tập lớn, bài tập', N'BTL', 0.33333, N'QDLH14              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH28              ', N'Đồ án môn cơ sở, tiểu luận môn khoa học xã hội và nhân văn', N'DA(TL)', 0.5, N'QDLH14              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH29              ', N'Đồ án môn học chuyên ngành', N'BTL', 0.66666, N'QDLH14              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH30              ', N'Đồ án tốt nghiệp đại học', N'BTL', 5, N'QDLH14              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH31              ', N'', N'BTL', 0.2, N'QDLH15              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH32              ', N'', N'Buổi', 2, N'QDLH16              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH33              ', N'', N'Học phần', 15, N'QDLH17              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH34              ', N'Chủ tịch', N'Đề tài', 0.666666, N'QDLH18              ')
INSERT [dbo].[DieuKienLoaiHinh] ([DieuKienLoaiHinh], [DieuKien], [DonViTinh], [QuyRaGioChuan], [MaLoaiHinhCon]) VALUES (N'DKLH35              ', N'Thư ký', N'Đề tài', 0.666666, N'QDLH18              ')
INSERT [dbo].[DinhMucChucDanh] ([MaDinhMucChucDanh], [TenChucDanh], [GioQuyDinhChungGiangDay], [GioMonTheChatGiaoDucQuocPhong], [ThoiGianNghienCuu], [ThoiGianChuanNghienCuu]) VALUES (N'dmcd001             ', N'Giáo sư và giảng viên cao cấp', 360, 500, 700, 280)
INSERT [dbo].[DinhMucChucDanh] ([MaDinhMucChucDanh], [TenChucDanh], [GioQuyDinhChungGiangDay], [GioMonTheChatGiaoDucQuocPhong], [ThoiGianNghienCuu], [ThoiGianChuanNghienCuu]) VALUES (N'dmcd002             ', N'Phó giao sư và giảng viên chinh', 320, 460, 600, 210)
INSERT [dbo].[DinhMucChucDanh] ([MaDinhMucChucDanh], [TenChucDanh], [GioQuyDinhChungGiangDay], [GioMonTheChatGiaoDucQuocPhong], [ThoiGianNghienCuu], [ThoiGianChuanNghienCuu]) VALUES (N'dmcd003             ', N'Giáo viên', 280, 420, 500, 150)
INSERT [dbo].[DinhMucChucDanh] ([MaDinhMucChucDanh], [TenChucDanh], [GioQuyDinhChungGiangDay], [GioMonTheChatGiaoDucQuocPhong], [ThoiGianNghienCuu], [ThoiGianChuanNghienCuu]) VALUES (N'dmcd004             ', N'Trợ giảng', 0, 0, 0, 0)
INSERT [dbo].[DinhMucGiamDacBiet] ([MaDinhMucGiamDacBiet], [TenDinhMucGiam], [TyLeGiam]) VALUES (N'dmgdb001            ', N'Có con nho hơn 36 thang', 10)
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv001             ', 95, 0, 0, N'Giám đốc')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv002             ', 85, 0, 0, N'Chính ủy')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv003             ', 30, 0, 0, N'Chủ nhiệm khoa và tương đương')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv004             ', 20, 25, 0, N'Phó chủ nhiệm khoa, Chủ nhiệm Bộ môn và tương đương')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv005             ', 15, 20, 0, N'Phó chủ nhiệm bộ môn và Trưởng phòng thí nghiệm')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv006             ', 10, 15, 0, N'Phó phòng thí nghiệm')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv007             ', 30, 0, 1, N'Bí thư Đảng ủy')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv008             ', 20, 25, 1, N'Phó bí thư Đảng ủy và Bí thư chi bộ')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv009             ', 15, 20, 1, N'Bí thư đoàn cơ sở')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv010             ', 10, 15, 0, N'Chủ nhiệm lớp')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv011             ', 50, 0, 2, N'Học viên cao học')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv012             ', 70, 0, 2, N'Nghiên cứu sinh không tập trung')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv013             ', 0, 0, 0, N'Giáo viên')
INSERT [dbo].[DinhMucMienGiamChucVu] ([MaDinhMucMienGiam], [TyLeMienGiamThap], [TyLeMienGiamCao], [Loai], [TenChucVu]) VALUES (N'mgcv014             ', 0, 0, 1, N'Đảng viên')
INSERT [dbo].[DonViChinhQuyen] ([MaDonViChinhQuyen], [TenDonViChinhQuyen]) VALUES (N'dvcq001             ', N'Khoa công nghệ thông tin')
INSERT [dbo].[DonViChinhQuyen] ([MaDonViChinhQuyen], [TenDonViChinhQuyen]) VALUES (N'dvcq002             ', N'Khoa kỹ thuật điều khiển')
INSERT [dbo].[DonViChinhQuyen] ([MaDonViChinhQuyen], [TenDonViChinhQuyen]) VALUES (N'dvcq003             ', N'Khoa Hóa, Lý Kỹ Thuật')
INSERT [dbo].[DonViChinhQuyen] ([MaDonViChinhQuyen], [TenDonViChinhQuyen]) VALUES (N'dvcq004             ', N'Khoa Vô Tuyến điện tử')
INSERT [dbo].[DonViDang] ([MaDonViDang], [TenDonViDang]) VALUES (N'dvd001              ', N'Đảng bộ khoa CNTT')
INSERT [dbo].[DonViDang] ([MaDonViDang], [TenDonViDang]) VALUES (N'dvd002              ', N'Đảng bộ khoa KTDK')
INSERT [dbo].[DonViDang] ([MaDonViDang], [TenDonViDang]) VALUES (N'dvd003              ', N'Đảng bộ khoa HLKT')
INSERT [dbo].[DonViDang] ([MaDonViDang], [TenDonViDang]) VALUES (N'dvd004              ', N'Đảng bộ khoa VTDT')
INSERT [dbo].[DuAn] ([MaDuAn], [TenDuAn], [MoTa], [MaCoQuanQuanLy], [TinhTrang]) VALUES (N'duan001             ', N'Nghiên cứu xây dựng Hệ thống phục vụ đào tạo nguồn lực an toàn thông tin', N'Cấp nhà nước', N'null                ', 1)
INSERT [dbo].[DuAn] ([MaDuAn], [TenDuAn], [MoTa], [MaCoQuanQuanLy], [TinhTrang]) VALUES (N'duan002             ', N'Nghiên cứu xây dựng hệ thống mô phỏng huấn luyện', N'Cấp trường', N'null                ', 1)
INSERT [dbo].[DuAn] ([MaDuAn], [TenDuAn], [MoTa], [MaCoQuanQuanLy], [TinhTrang]) VALUES (N'duan003             ', N'Nghiên cứu xây dựng thuật toán và phần mềm xử lý và nhận dạng ký tự viết tay', N'Câp bộ', N'null                ', 1)
INSERT [dbo].[DuAn] ([MaDuAn], [TenDuAn], [MoTa], [MaCoQuanQuanLy], [TinhTrang]) VALUES (N'duan004             ', N'Xây dựng hệ thống hỗ trợ học và thi trắc nghiệm', N'Cấp bộ', N'null                ', 1)
INSERT [dbo].[DuAn] ([MaDuAn], [TenDuAn], [MoTa], [MaCoQuanQuanLy], [TinhTrang]) VALUES (N'duan005             ', N'Xây dựng hệ thống quản lý Khoa học công nghệ tại Học viện Kỹ thuật Quân sự', N'Cấp nhà nước', N'null                ', 1)
INSERT [dbo].[DuAn] ([MaDuAn], [TenDuAn], [MoTa], [MaCoQuanQuanLy], [TinhTrang]) VALUES (N'duan006             ', N'Một số phương pháp phân cụm dữ liệu sử dụng tập mờ loại hai và ứng dụng', N'Cấp trường', N'null                ', 1)
INSERT [dbo].[GiaiThuong] ([MaGiaiThuong], [TenGiaiThuong], [PhamVi], [NoiCap], [ToChucTraoThuong]) VALUES (N'giaithuong001       ', N'ASOCIO', N'Toàn cầu', N'Nhật Bản', N'Tổ chức Công nghiệp Điện toán châu Á - châu Đại Dương')
INSERT [dbo].[GiaiThuong] ([MaGiaiThuong], [TenGiaiThuong], [PhamVi], [NoiCap], [ToChucTraoThuong]) VALUES (N'giaithuong002       ', N'Công nghệ số Việt Nam', N'Trong nước', N'Việt Nam', N'Hội Truyền thông số Việt Nam')
INSERT [dbo].[GiaiThuong] ([MaGiaiThuong], [TenGiaiThuong], [PhamVi], [NoiCap], [ToChucTraoThuong]) VALUES (N'giaithuong003       ', N'TOP ICT Việt Nam ', N'Trong nước', N'Việt Nam', N'Hội Tin học Việt Nam')
INSERT [dbo].[GiaiThuong] ([MaGiaiThuong], [TenGiaiThuong], [PhamVi], [NoiCap], [ToChucTraoThuong]) VALUES (N'giaithuong004       ', N' Giải thưởng Hồ Chí Minh về khoa học và công nghệ', N'Trong nước', N'Việt Nam', N'Hội đồng Nhà nước')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0001              ', N'Lê Ngọc Dự', CAST(N'1972-01-01' AS Date), N'Nam', N'Buôn Mê Thuột', N'Cầu Giấy - Hà Nội', N'84982123123         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0002              ', N'Bùi Thanh Hoàng', CAST(N'1972-01-02' AS Date), N'Nam', N'Buôn Mê Thuột', N'Cầu Giấy - Hà Nội', N'84982123124         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0003              ', N'Võ Huy Hoàng', CAST(N'1972-01-03' AS Date), N'Nam', N'Đắc Lắc', N'Cầu Giấy - Hà Nội', N'84982123125         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0004              ', N'Nguyễn Mạnh Thiên', CAST(N'1972-01-04' AS Date), N'Nam', N'Lào Cai', N'Cầu Giấy - Hà Nội', N'84982123126         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0005              ', N'Bùi Mạnh Hoài', CAST(N'1972-01-05' AS Date), N'Nam', N'Nghệ An', N'Cầu Giấy - Hà Nội', N'84982123127         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0006              ', N'Lữ Thái Học', CAST(N'1972-01-06' AS Date), N'Nam', N'Bến Tre', N'Cầu Giấy - Hà Nội', N'84982123128         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0007              ', N'Phạm Đăng Khoa', CAST(N'1972-01-07' AS Date), N'Nam', N'Phú Yên', N'Cầu Giấy - Hà Nội', N'84982123129         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0008              ', N'Nguyễn Trọng Long', CAST(N'1972-02-01' AS Date), N'Nam', N'Thanh Hóa', N'Cầu Giấy - Hà Nội', N'84982123130         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0009              ', N'Nguyễn Đức Vượng', CAST(N'1972-03-01' AS Date), N'Nam', N'Hải Dương', N'Cầu Giấy - Hà Nội', N'84982123131         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0010              ', N'Cao Mạnh Quyết', CAST(N'1972-01-12' AS Date), N'Nam', N'Buôn Mê Thuột', N'Cầu Giấy - Hà Nội', N'84982123132         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0011              ', N'Nguyễn Văn Tuấn', CAST(N'1972-01-15' AS Date), N'Nam', N'Hà Nội', N'Cầu Giấy - Hà Nội', N'84982123133         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0012              ', N'Hoàng Thị Thủy', CAST(N'1972-06-01' AS Date), N'Nữ', N'Đông Anh', N'Cầu Giấy - Hà Nội', N'84982123134         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0013              ', N'Hoàng Tấn Phát', CAST(N'1972-04-01' AS Date), N'Nam', N'Quảng Bình', N'Cầu Giấy - Hà Nội', N'84982123135         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0014              ', N'Nguyễn Tú Ngọc', CAST(N'1972-08-01' AS Date), N'Nam', N'Quảng Trị', N'Cầu Giấy - Hà Nội', N'84982123136         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0015              ', N'Nguyễn Duy ', CAST(N'1972-12-01' AS Date), N'Nam', N'Huế', N'Cầu Giấy - Hà Nội', N'84982123137         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0016              ', N'Trần Đăng', CAST(N'1972-11-01' AS Date), N'Nam', N'Đồng Nai', N'Cầu Giấy - Hà Nội', N'84982123138         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0017              ', N'Nguyễn Thị Ngọc', CAST(N'1972-11-11' AS Date), N'Nữ', N'Buôn Mê Thuột', N'Cầu Giấy - Hà Nội', N'84982123140         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0018              ', N'Nguyễn Trúc Anh', CAST(N'1972-10-12' AS Date), N'Nữ', N'Hà Nội', N'Cầu Giấy - Hà Nội', N'84982123141         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0019              ', N'Lê Minh Anh', CAST(N'1972-12-10' AS Date), N'Nữ', N'Hà Nội', N'Cầu Giấy - Hà Nội', N'84982123142         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0020              ', N'Lê Nguyên', CAST(N'1972-06-10' AS Date), N'Nam', N'Hà Nam', N'Cầu Giấy - Hà Nội', N'84982123143         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0021              ', N'Lê Công Bá Duy', CAST(N'1972-07-10' AS Date), N'Nam', N'Hà Tĩnh', N'Cầu Giấy - Hà Nội', N'84982123144         ')
INSERT [dbo].[GiaoVien] ([MaGiaoVien], [TenGiaoVien], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT]) VALUES (N'gv0022              ', N'Trần Hoàng', CAST(N'1972-05-01' AS Date), N'Nam', N'Hà Nội', N'Cầu Giấy - Hà Nội', N'84982123145         ')
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0001              ', N'bb0001              ', CAST(N'2004-01-01' AS Date), CAST(N'2005-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0006              ', N'bb0001              ', CAST(N'2004-01-01' AS Date), CAST(N'2005-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0007              ', N'bb0001              ', CAST(N'2004-01-01' AS Date), CAST(N'2005-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0002              ', N'bb0003              ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0004              ', N'bb0003              ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0005              ', N'bb0003              ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0008              ', N'bb0003              ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0003              ', N'bb0009              ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0008              ', N'bb0009              ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0009              ', N'bb0009              ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0011              ', N'bb0009              ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0013              ', N'bb0002              ', CAST(N'2007-01-01' AS Date), CAST(N'2010-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0018              ', N'bb0002              ', CAST(N'2007-01-01' AS Date), CAST(N'2010-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0019              ', N'bb0002              ', CAST(N'2007-01-01' AS Date), CAST(N'2010-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0011              ', N'bb0002              ', CAST(N'2007-01-01' AS Date), CAST(N'2010-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0014              ', N'bb0007              ', CAST(N'2008-01-01' AS Date), CAST(N'2009-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0021              ', N'bb0007              ', CAST(N'2008-01-01' AS Date), CAST(N'2009-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0020              ', N'bb0007              ', CAST(N'2008-01-01' AS Date), CAST(N'2009-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0022              ', N'bb0007              ', CAST(N'2008-01-01' AS Date), CAST(N'2009-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0014              ', N'bb0008              ', CAST(N'2008-01-01' AS Date), CAST(N'2009-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0015              ', N'bb0008              ', CAST(N'2008-01-01' AS Date), CAST(N'2009-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0020              ', N'bb0008              ', CAST(N'2008-01-01' AS Date), CAST(N'2009-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BaiBao] ([MaGiaoVien], [MaBaiBao], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongBaiBao]) VALUES (N'gv0003              ', N'bb0008              ', CAST(N'2008-01-01' AS Date), CAST(N'2009-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0001              ', N'sach001             ', CAST(N'2004-01-01' AS Date), CAST(N'2007-01-01' AS Date), 1, 100)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0008              ', N'sach001             ', CAST(N'2004-01-01' AS Date), CAST(N'2007-01-01' AS Date), 0, 50)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0010              ', N'sach001             ', CAST(N'2004-01-01' AS Date), CAST(N'2007-01-01' AS Date), 0, 25)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0011              ', N'sach001             ', CAST(N'2004-01-01' AS Date), CAST(N'2007-01-01' AS Date), 0, 22)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0012              ', N'sach001             ', CAST(N'2004-01-01' AS Date), CAST(N'2007-01-01' AS Date), 0, 12)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0022              ', N'sach001             ', CAST(N'2004-01-01' AS Date), CAST(N'2007-01-01' AS Date), 0, 90)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0002              ', N'sach002             ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 1, 50)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0014              ', N'sach002             ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0015              ', N'sach002             ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0018              ', N'sach002             ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0019              ', N'sach002             ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0020              ', N'sach002             ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0021              ', N'sach002             ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0, 50)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0004              ', N'sach002             ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0, 40)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0003              ', N'sach003             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 1, 50)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0012              ', N'sach003             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0009              ', N'sach003             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0011              ', N'sach003             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0017              ', N'sach003             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0016              ', N'sach003             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 0, 60)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0003              ', N'sach004             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 1, 50)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0005              ', N'sach004             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0007              ', N'sach004             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0009              ', N'sach004             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 0, 10)
INSERT [dbo].[GiaoVien_BienSoanSach] ([MaGiaoVien], [MaSach], [ThoiGianBatDau], [ThoiGianKetThuc], [VaiTroTrongBienSoan], [SoTrangViet]) VALUES (N'gv0011              ', N'sach004             ', CAST(N'2012-01-01' AS Date), CAST(N'2018-01-01' AS Date), 0, 70)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0001              ', N'cq001               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0002              ', N'cq002               ', CAST(N'1990-02-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0003              ', N'cq003               ', CAST(N'1990-03-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0004              ', N'cq003               ', CAST(N'1990-04-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0005              ', N'cq003               ', CAST(N'1990-05-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0006              ', N'cq003               ', CAST(N'1990-06-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0007              ', N'cq003               ', CAST(N'1990-07-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0008              ', N'cq003               ', CAST(N'1990-08-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0009              ', N'cq003               ', CAST(N'1990-09-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0010              ', N'cq003               ', CAST(N'1990-01-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0011              ', N'cq003               ', CAST(N'1990-01-03' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0012              ', N'cq004               ', CAST(N'1990-01-04' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0013              ', N'cq005               ', CAST(N'1990-01-05' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0014              ', N'cq006               ', CAST(N'1990-01-06' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0015              ', N'cq006               ', CAST(N'1990-01-07' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0016              ', N'cq006               ', CAST(N'1990-01-08' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0017              ', N'cq006               ', CAST(N'1990-01-09' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0018              ', N'cq006               ', CAST(N'1990-01-10' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0019              ', N'cq006               ', CAST(N'1990-01-04' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0020              ', N'cq006               ', CAST(N'1990-01-04' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0021              ', N'cq006               ', CAST(N'1990-01-04' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChinhQuyen] ([MaGiaoVien], [MaChinhQuyen], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0022              ', N'cq006               ', CAST(N'1990-01-04' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0001              ', N'cd001               ', CAST(N'1992-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0002              ', N'cd002               ', CAST(N'1992-10-10' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0003              ', N'cd002               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0004              ', N'cd002               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0005              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0006              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0007              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0008              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0009              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0010              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0011              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0012              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0013              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0014              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0015              ', N'cd003               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0016              ', N'cd004               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0017              ', N'cd004               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0018              ', N'cd004               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0019              ', N'cd004               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0020              ', N'cd004               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0021              ', N'cd004               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_ChucDanh] ([MaGiaoVien], [MaChucDanh], [ThoiGianNhanBatDau], [ThoiGianNhanKetThuc]) VALUES (N'gv0022              ', N'cd004               ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0001              ', N'd001                ', CAST(N'1990-02-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0002              ', N'd002                ', CAST(N'1990-03-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0003              ', N'd003                ', CAST(N'1990-04-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0004              ', N'd003                ', CAST(N'1990-05-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0005              ', N'd003                ', CAST(N'1990-06-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0006              ', N'd003                ', CAST(N'1990-07-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0007              ', N'd003                ', CAST(N'1990-08-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0008              ', N'd003                ', CAST(N'1990-09-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0009              ', N'd003                ', CAST(N'1990-10-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0010              ', N'd003                ', CAST(N'1990-11-02' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0011              ', N'd003                ', CAST(N'1990-02-21' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0012              ', N'd004                ', CAST(N'1990-03-21' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0013              ', N'd005                ', CAST(N'1990-04-21' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0014              ', N'd006                ', CAST(N'1990-05-22' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0015              ', N'd006                ', CAST(N'1990-06-23' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0016              ', N'd006                ', CAST(N'1990-07-24' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0017              ', N'd006                ', CAST(N'1990-08-22' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0018              ', N'd006                ', CAST(N'1990-09-25' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0019              ', N'd006                ', CAST(N'1990-10-26' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0020              ', N'd006                ', CAST(N'1990-11-28' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0021              ', N'd006                ', CAST(N'1990-11-21' AS Date), NULL)
INSERT [dbo].[GiaoVien_Dang] ([MaGiaoVien], [MaDang], [ThoiGianNhan], [ThoiGianKetThuc]) VALUES (N'gv0022              ', N'd006                ', CAST(N'1990-11-20' AS Date), NULL)
INSERT [dbo].[GiaoVien_DuAn] ([MaGiaoVien], [MaDuAn], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongDuAn]) VALUES (N'gv0001              ', N'duan001             ', CAST(N'2012-01-01' AS Date), CAST(N'2014-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_DuAn] ([MaGiaoVien], [MaDuAn], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongDuAn]) VALUES (N'gv0002              ', N'duan002             ', CAST(N'2014-01-01' AS Date), CAST(N'2015-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_DuAn] ([MaGiaoVien], [MaDuAn], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongDuAn]) VALUES (N'gv0003              ', N'duan003             ', CAST(N'2015-01-01' AS Date), CAST(N'2016-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_DuAn] ([MaGiaoVien], [MaDuAn], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongDuAn]) VALUES (N'gv0004              ', N'duan004             ', CAST(N'2016-01-01' AS Date), CAST(N'2017-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_DuAn] ([MaGiaoVien], [MaDuAn], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongDuAn]) VALUES (N'gv0005              ', N'duan005             ', CAST(N'2012-01-01' AS Date), CAST(N'2012-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_DuAn] ([MaGiaoVien], [MaDuAn], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongDuAn]) VALUES (N'gv0006              ', N'duan006             ', CAST(N'2011-01-01' AS Date), CAST(N'2015-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_DuAn] ([MaGiaoVien], [MaDuAn], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongDuAn]) VALUES (N'gv0007              ', N'duan006             ', CAST(N'2011-01-01' AS Date), CAST(N'2015-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_DuAn] ([MaGiaoVien], [MaDuAn], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongDuAn]) VALUES (N'gv0008              ', N'duan006             ', CAST(N'2011-01-01' AS Date), CAST(N'2015-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_GiamDacBiet] ([MaGiaoVien], [MaDinhMucGiamDacBiet], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0017              ', N'dmgdb001            ', CAST(N'2011-01-01' AS Date), CAST(N'2014-01-01' AS Date))
INSERT [dbo].[GiaoVien_GiamDacBiet] ([MaGiaoVien], [MaDinhMucGiamDacBiet], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0019              ', N'dmgdb001            ', CAST(N'2015-01-01' AS Date), CAST(N'2018-01-01' AS Date))
INSERT [dbo].[GiaoVien_HocHam] ([MaGiaoVien], [MaHocHam], [ThoiGianNhan]) VALUES (N'gv0001              ', N'hocham001           ', CAST(N'1991-04-04' AS Date))
INSERT [dbo].[GiaoVien_HocHam] ([MaGiaoVien], [MaHocHam], [ThoiGianNhan]) VALUES (N'gv0002              ', N'hocham002           ', CAST(N'1993-04-04' AS Date))
INSERT [dbo].[GiaoVien_HocHam] ([MaGiaoVien], [MaHocHam], [ThoiGianNhan]) VALUES (N'gv0003              ', N'hocham002           ', CAST(N'1993-04-04' AS Date))
INSERT [dbo].[GiaoVien_HocHam] ([MaGiaoVien], [MaHocHam], [ThoiGianNhan]) VALUES (N'gv0004              ', N'hocham002           ', CAST(N'1993-04-04' AS Date))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT01            ', N'gv0012              ', N'HPCT06              ', CAST(N'2013-03-05T00:00:00.000' AS DateTime), CAST(N'2013-03-06T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT02            ', N'gv0011              ', N'HPCT08              ', CAST(N'2015-10-20T00:00:00.000' AS DateTime), CAST(N'2015-11-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT03            ', N'gv0015              ', N'HPCT10              ', CAST(N'2017-02-19T00:00:00.000' AS DateTime), CAST(N'2017-02-22T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT04            ', N'gv0017              ', N'HPCT10              ', CAST(N'2016-11-11T00:00:00.000' AS DateTime), CAST(N'2016-11-19T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT05            ', N'gv0004              ', N'HPCT03              ', CAST(N'2015-07-23T00:00:00.000' AS DateTime), CAST(N'2015-08-07T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT06            ', N'gv0006              ', N'HPCT01              ', CAST(N'2013-05-12T00:00:00.000' AS DateTime), CAST(N'2013-06-05T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT07            ', N'gv0013              ', N'HPCT03              ', CAST(N'2018-01-17T00:00:00.000' AS DateTime), CAST(N'2018-01-22T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT08            ', N'gv0018              ', N'HPCT06              ', CAST(N'2015-01-29T00:00:00.000' AS DateTime), CAST(N'2015-02-12T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT09            ', N'gv0016              ', N'HPCT04              ', CAST(N'2013-01-20T00:00:00.000' AS DateTime), CAST(N'2013-02-14T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT10            ', N'gv0002              ', N'HPCT02              ', CAST(N'2012-03-11T00:00:00.000' AS DateTime), CAST(N'2017-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT11            ', N'gv0011              ', N'HPCT04              ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2017-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT12            ', N'gv0011              ', N'HPCT05              ', CAST(N'2014-05-16T00:00:00.000' AS DateTime), CAST(N'2017-05-23T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT13            ', N'gv0011              ', N'HPCT06              ', CAST(N'2017-06-17T00:00:00.000' AS DateTime), CAST(N'2017-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT14            ', N'gv0011              ', N'HPCT07              ', CAST(N'2017-11-13T00:00:00.000' AS DateTime), CAST(N'2017-11-13T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT15            ', N'gv0011              ', N'HPCT01              ', CAST(N'2018-07-15T00:00:00.000' AS DateTime), CAST(N'2017-08-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT16            ', N'gv0011              ', N'HPCT09              ', CAST(N'2016-01-17T00:00:00.000' AS DateTime), CAST(N'2017-01-26T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocPhanChamThi] ([GiaoVien_HocPhanChamThi], [MaGiaoVien], [MaHocPhanChamThi], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHPCT17            ', N'gv0011              ', N'HPCT10              ', CAST(N'2015-04-11T00:00:00.000' AS DateTime), CAST(N'2017-05-05T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0001              ', N'hocvi001            ', CAST(N'1990-03-13' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0002              ', N'hocvi001            ', CAST(N'1990-03-23' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0003              ', N'hocvi001            ', CAST(N'1990-03-04' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0004              ', N'hocvi001            ', CAST(N'1990-03-05' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0005              ', N'hocvi002            ', CAST(N'1990-03-06' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0006              ', N'hocvi002            ', CAST(N'1990-03-07' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0007              ', N'hocvi002            ', CAST(N'1990-03-08' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0008              ', N'hocvi003            ', CAST(N'1990-03-09' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0009              ', N'hocvi003            ', CAST(N'1990-01-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0010              ', N'hocvi003            ', CAST(N'1990-02-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0011              ', N'hocvi003            ', CAST(N'1990-03-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0012              ', N'hocvi003            ', CAST(N'1990-04-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0013              ', N'hocvi003            ', CAST(N'1990-05-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0014              ', N'hocvi003            ', CAST(N'1990-06-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0015              ', N'hocvi003            ', CAST(N'1990-07-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0016              ', N'hocvi003            ', CAST(N'1990-08-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0017              ', N'hocvi004            ', CAST(N'1990-09-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0018              ', N'hocvi004            ', CAST(N'1990-01-02' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0019              ', N'hocvi004            ', CAST(N'1990-02-05' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0020              ', N'hocvi004            ', CAST(N'1990-01-30' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0021              ', N'hocvi004            ', CAST(N'1990-01-08' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0022              ', N'hocvi004            ', CAST(N'1990-01-12' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0001              ', N'hocvi001            ', CAST(N'1990-03-13' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0002              ', N'hocvi001            ', CAST(N'1990-03-23' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0003              ', N'hocvi001            ', CAST(N'1990-03-04' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0004              ', N'hocvi001            ', CAST(N'1990-03-05' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0005              ', N'hocvi002            ', CAST(N'1990-03-06' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0006              ', N'hocvi002            ', CAST(N'1990-03-07' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0007              ', N'hocvi002            ', CAST(N'1990-03-08' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0008              ', N'hocvi003            ', CAST(N'1990-03-09' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0009              ', N'hocvi003            ', CAST(N'1990-01-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0010              ', N'hocvi003            ', CAST(N'1990-02-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0011              ', N'hocvi003            ', CAST(N'1990-03-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0012              ', N'hocvi003            ', CAST(N'1990-04-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0013              ', N'hocvi003            ', CAST(N'1990-05-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0014              ', N'hocvi003            ', CAST(N'1990-06-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0015              ', N'hocvi003            ', CAST(N'1990-07-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0016              ', N'hocvi003            ', CAST(N'1990-08-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0017              ', N'hocvi004            ', CAST(N'1990-09-03' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0018              ', N'hocvi004            ', CAST(N'1990-01-02' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0019              ', N'hocvi004            ', CAST(N'1990-02-05' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0020              ', N'hocvi004            ', CAST(N'1990-01-30' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0021              ', N'hocvi004            ', CAST(N'1990-01-08' AS Date))
INSERT [dbo].[GiaoVien_HocVi] ([MaGiaoVien], [MaHocVi], [ThoiGianNhan]) VALUES (N'gv0022              ', N'hocvi004            ', CAST(N'1990-01-12' AS Date))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD01              ', N'gv0010              ', N'HD01                ', CAST(N'2012-01-03T00:00:00.000' AS DateTime), CAST(N'2013-03-06T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD02              ', N'gv0017              ', N'HD06                ', CAST(N'2013-03-04T00:00:00.000' AS DateTime), CAST(N'2015-10-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD03              ', N'gv0014              ', N'HD05                ', CAST(N'2014-08-01T00:00:00.000' AS DateTime), CAST(N'2017-02-28T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD04              ', N'gv0012              ', N'HD02                ', CAST(N'2011-11-11T00:00:00.000' AS DateTime), CAST(N'2016-07-19T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD05              ', N'gv0009              ', N'HD04                ', CAST(N'2014-01-23T00:00:00.000' AS DateTime), CAST(N'2015-04-07T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD06              ', N'gv0006              ', N'HD08                ', CAST(N'2012-12-12T00:00:00.000' AS DateTime), CAST(N'2013-07-05T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD07              ', N'gv0016              ', N'HD04                ', CAST(N'2011-10-17T00:00:00.000' AS DateTime), CAST(N'2018-02-22T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD08              ', N'gv0019              ', N'HD06                ', CAST(N'2011-05-29T00:00:00.000' AS DateTime), CAST(N'2015-12-12T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD09              ', N'gv0016              ', N'HD02                ', CAST(N'2012-02-20T00:00:00.000' AS DateTime), CAST(N'2013-03-14T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD10              ', N'gv0001              ', N'HD09                ', CAST(N'2015-04-10T00:00:00.000' AS DateTime), CAST(N'2017-02-11T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD11              ', N'gv0016              ', N'HD08                ', CAST(N'2012-04-10T00:00:00.000' AS DateTime), CAST(N'2013-03-16T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD12              ', N'gv0015              ', N'HD07                ', CAST(N'2016-04-10T00:00:00.000' AS DateTime), CAST(N'2017-05-17T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD13              ', N'gv0011              ', N'HD38                ', CAST(N'2015-02-11T00:00:00.000' AS DateTime), CAST(N'2016-01-12T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD14              ', N'gv0013              ', N'HD37                ', CAST(N'2017-08-15T00:00:00.000' AS DateTime), CAST(N'2018-04-15T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD15              ', N'gv0011              ', N'HD01                ', CAST(N'2012-03-18T00:00:00.000' AS DateTime), CAST(N'2017-08-17T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD16              ', N'gv0011              ', N'HD02                ', CAST(N'2018-08-13T00:00:00.000' AS DateTime), CAST(N'2019-02-13T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD17              ', N'gv0011              ', N'HD03                ', CAST(N'2016-03-15T00:00:00.000' AS DateTime), CAST(N'2019-06-10T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD18              ', N'gv0011              ', N'HD04                ', CAST(N'2014-07-12T00:00:00.000' AS DateTime), CAST(N'2015-04-17T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD19              ', N'gv0011              ', N'HD05                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD20              ', N'gv0011              ', N'HD06                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD21              ', N'gv0011              ', N'HD07                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD22              ', N'gv0011              ', N'HD08                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD23              ', N'gv0011              ', N'HD09                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD24              ', N'gv0011              ', N'HD10                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD25              ', N'gv0011              ', N'HD11                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD26              ', N'gv0011              ', N'HD12                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD27              ', N'gv0011              ', N'HD13                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD28              ', N'gv0011              ', N'HD14                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD29              ', N'gv0011              ', N'HD15                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD30              ', N'gv0011              ', N'HD16                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD31              ', N'gv0011              ', N'HD17                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD32              ', N'gv0011              ', N'HD18                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD33              ', N'gv0011              ', N'HD19                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD34              ', N'gv0011              ', N'HD20                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD35              ', N'gv0011              ', N'HD21                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD36              ', N'gv0011              ', N'HD22                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD37              ', N'gv0011              ', N'HD23                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD38              ', N'gv0011              ', N'HD24                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD39              ', N'gv0011              ', N'HD15                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD40              ', N'gv0011              ', N'HD26                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD41              ', N'gv0011              ', N'HD27                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD42              ', N'gv0011              ', N'HD28                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD43              ', N'gv0011              ', N'HD29                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD44              ', N'gv0011              ', N'HD30                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD45              ', N'gv0011              ', N'HD31                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD46              ', N'gv0011              ', N'HD32                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD47              ', N'gv0011              ', N'HD33                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD48              ', N'gv0011              ', N'HD34                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD49              ', N'gv0011              ', N'HD35                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD50              ', N'gv0011              ', N'HD36                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD51              ', N'gv0011              ', N'HD37                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD52              ', N'gv0011              ', N'HD38                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD53              ', N'gv0011              ', N'HD39                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD54              ', N'gv0011              ', N'HD40                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD55              ', N'gv0011              ', N'HD41                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongDan] ([GiaoVien_HuongDan], [MaGiaoVien], [MaHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVHD56              ', N'gv0011              ', N'HD42                ', CAST(N'2017-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_HuongNghienCuu] ([MaGiaoVien], [MaHuongNghienCuu], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0001              ', N'hnc001              ', CAST(N'1995-01-01' AS Date), CAST(N'1998-02-02' AS Date))
INSERT [dbo].[GiaoVien_HuongNghienCuu] ([MaGiaoVien], [MaHuongNghienCuu], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0002              ', N'hnc002              ', CAST(N'1995-01-01' AS Date), CAST(N'1998-02-02' AS Date))
INSERT [dbo].[GiaoVien_HuongNghienCuu] ([MaGiaoVien], [MaHuongNghienCuu], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0003              ', N'hnc001              ', CAST(N'1995-01-01' AS Date), CAST(N'1998-02-02' AS Date))
INSERT [dbo].[GiaoVien_HuongNghienCuu] ([MaGiaoVien], [MaHuongNghienCuu], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0004              ', N'hnc002              ', CAST(N'1995-01-01' AS Date), CAST(N'1998-02-02' AS Date))
INSERT [dbo].[GiaoVien_HuongNghienCuu] ([MaGiaoVien], [MaHuongNghienCuu], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0005              ', N'hnc001              ', CAST(N'1995-01-01' AS Date), CAST(N'1998-02-02' AS Date))
INSERT [dbo].[GiaoVien_KhenThuongKyLuat] ([MaGiaoVien], [MaKhenThuongKyLuat], [TenKhenThuongKyLuatNhan], [ThoiGianNhan]) VALUES (N'gv0001              ', N'ktkl001             ', N'Bằng khen về thi đua quyết thắng', CAST(N'1998-01-01' AS Date))
INSERT [dbo].[GiaoVien_KhenThuongKyLuat] ([MaGiaoVien], [MaKhenThuongKyLuat], [TenKhenThuongKyLuatNhan], [ThoiGianNhan]) VALUES (N'gv0002              ', N'ktkl002             ', N'Giấy khen về thi đua quyết thắng', CAST(N'1998-01-01' AS Date))
INSERT [dbo].[GiaoVien_KhenThuongKyLuat] ([MaGiaoVien], [MaKhenThuongKyLuat], [TenKhenThuongKyLuatNhan], [ThoiGianNhan]) VALUES (N'gv0008              ', N'ktkl003             ', N'Khiển trách về vi phạm quy định lễ tiết tác phong', CAST(N'1998-01-01' AS Date))
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0001              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0002              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0003              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0004              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0005              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0006              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0007              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0008              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0009              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0010              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0011              ', N'khoa01              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0012              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0013              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0014              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0015              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0016              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0017              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0018              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0019              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0020              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0021              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_Khoa] ([MaGiaoVien], [MaKhoa], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'gv0022              ', N'khoa02              ', CAST(N'1990-01-01' AS Date), NULL)
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH01              ', N'gv0011              ', N'LH01                ', CAST(N'2012-01-03T00:00:00.000' AS DateTime), CAST(N'2013-03-06T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH02              ', N'gv0017              ', N'LH02                ', CAST(N'2014-03-04T00:00:00.000' AS DateTime), CAST(N'2015-10-01T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH03              ', N'gv0014              ', N'LH10                ', CAST(N'2016-08-01T00:00:00.000' AS DateTime), CAST(N'2017-02-28T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH04              ', N'gv0012              ', N'LH10                ', CAST(N'2015-11-11T00:00:00.000' AS DateTime), CAST(N'2016-07-19T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH05              ', N'gv0009              ', N'LH05                ', CAST(N'2014-01-23T00:00:00.000' AS DateTime), CAST(N'2015-04-07T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH06              ', N'gv0006              ', N'LH07                ', CAST(N'2012-12-12T00:00:00.000' AS DateTime), CAST(N'2013-07-05T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH07              ', N'gv0016              ', N'LH03                ', CAST(N'2017-10-17T00:00:00.000' AS DateTime), CAST(N'2018-02-22T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH08              ', N'gv0019              ', N'LH01                ', CAST(N'2014-05-29T00:00:00.000' AS DateTime), CAST(N'2015-12-12T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH09              ', N'gv0016              ', N'LH02                ', CAST(N'2012-02-20T00:00:00.000' AS DateTime), CAST(N'2013-03-14T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH10              ', N'gv0003              ', N'LH06                ', CAST(N'2016-04-10T00:00:00.000' AS DateTime), CAST(N'2017-02-11T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH11              ', N'gv0011              ', N'LH05                ', CAST(N'2012-03-06T00:00:00.000' AS DateTime), CAST(N'2013-09-06T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH12              ', N'gv0011              ', N'LH04                ', CAST(N'2012-05-03T00:00:00.000' AS DateTime), CAST(N'2013-02-17T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH13              ', N'gv0011              ', N'LH03                ', CAST(N'2012-01-11T00:00:00.000' AS DateTime), CAST(N'2013-03-05T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH14              ', N'gv0011              ', N'LH02                ', CAST(N'2012-03-26T00:00:00.000' AS DateTime), CAST(N'2013-11-06T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_LopHoc] ([GiaoVien_LopHoc], [MaGiaoVien], [MaLopHoc], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'GVLH15              ', N'gv0011              ', N'LH06                ', CAST(N'2012-01-03T00:00:00.000' AS DateTime), CAST(N'2013-03-06T00:00:00.000' AS DateTime))
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0001              ', N'dtnckh0002          ', CAST(N'2004-01-01' AS Date), CAST(N'2005-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0008              ', N'dtnckh0002          ', CAST(N'2004-01-01' AS Date), CAST(N'2005-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0010              ', N'dtnckh0002          ', CAST(N'2004-01-01' AS Date), CAST(N'2005-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0002              ', N'dtnckh0004          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0014              ', N'dtnckh0004          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0015              ', N'dtnckh0004          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0018              ', N'dtnckh0004          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0003              ', N'dtnckh0001          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0012              ', N'dtnckh0001          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0009              ', N'dtnckh0001          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0011              ', N'dtnckh0001          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0005              ', N'dtnckh0006          ', CAST(N'2002-01-01' AS Date), CAST(N'2003-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0012              ', N'dtnckh0006          ', CAST(N'2002-01-01' AS Date), CAST(N'2003-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0019              ', N'dtnckh0006          ', CAST(N'2002-01-01' AS Date), CAST(N'2003-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0021              ', N'dtnckh0006          ', CAST(N'2002-01-01' AS Date), CAST(N'2003-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0003              ', N'dtnckh0003          ', CAST(N'2014-01-01' AS Date), CAST(N'2016-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0012              ', N'dtnckh0003          ', CAST(N'2014-01-01' AS Date), CAST(N'2016-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0009              ', N'dtnckh0003          ', CAST(N'2014-01-01' AS Date), CAST(N'2016-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0011              ', N'dtnckh0003          ', CAST(N'2014-01-01' AS Date), CAST(N'2016-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0022              ', N'dtnckh0007          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0021              ', N'dtnckh0007          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0020              ', N'dtnckh0007          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0018              ', N'dtnckh0007          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0013              ', N'dtnckh0007          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0012              ', N'dtnckh0007          ', CAST(N'2012-01-01' AS Date), CAST(N'2013-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0003              ', N'dtnckh0013          ', CAST(N'2014-01-01' AS Date), CAST(N'2016-01-01' AS Date), 1)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0012              ', N'dtnckh0013          ', CAST(N'2014-01-01' AS Date), CAST(N'2016-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0009              ', N'dtnckh0013          ', CAST(N'2014-01-01' AS Date), CAST(N'2016-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NghienCuuKhoaHoc] ([MaGiaoVien], [MaDeTai], [ThoiGianBatDau], [ThoiGianHoanThanh], [VaiTroTrongNghienCuu]) VALUES (N'gv0011              ', N'dtnckh0013          ', CAST(N'2014-01-01' AS Date), CAST(N'2016-01-01' AS Date), 0)
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0001              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B2                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0002              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B2                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0003              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B2                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0004              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B2                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0005              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B2                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0006              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0007              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0008              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0009              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0010              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0011              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0012              ', N'nn002               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0013              ', N'nn002               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0014              ', N'nn002               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0015              ', N'nn002               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0016              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0017              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0018              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0019              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0020              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[GiaoVien_NgoaiNgu] ([MaGiaoVien], [MaNgoaiNgu], [ThoiGianNhan], [TrinhDo]) VALUES (N'gv0021              ', N'nn001               ', CAST(N'1990-07-08' AS Date), N'B1                  ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H01                 ', N'Quân Sự', N'CTDT01              ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H02                 ', N'Dân sự', N'CTDT01              ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H03                 ', N'Văn bằng 2', N'CTDT01              ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H04                 ', N'PTNC', N'CTDT02              ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H05                 ', N'Ban ngày', N'CTDT02              ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H06                 ', N'Buổi tối', N'CTDT02              ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H07                 ', N'Tp.HCM', N'CTDT02              ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H08                 ', N'Tập trung', N'CTDT03              ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H09                 ', N'Không tập trung', N'CTDT03              ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H10                 ', N'HV', N'CTDT04              ')
INSERT [dbo].[He] ([MaHe], [TenHe], [Machuongtrinhdaotao]) VALUES (N'H11                 ', N'Tr10', N'CTDT04              ')
INSERT [dbo].[HocHam] ([MaHocHam], [TenHocHam], [MaDinhMucChucDanh]) VALUES (N'hocham001           ', N'Giáo sư', N'dmcd001             ')
INSERT [dbo].[HocHam] ([MaHocHam], [TenHocHam], [MaDinhMucChucDanh]) VALUES (N'hocham002           ', N'Phó Giáo sư', N'dmcd002             ')
INSERT [dbo].[HocHam] ([MaHocHam], [TenHocHam], [MaDinhMucChucDanh]) VALUES (N'hocham003           ', N'Giảng viên chính', N'dmcd002             ')
INSERT [dbo].[HocHam] ([MaHocHam], [TenHocHam], [MaDinhMucChucDanh]) VALUES (N'hocham004           ', N'Giảng viên', N'dmcd003             ')
INSERT [dbo].[HocHam] ([MaHocHam], [TenHocHam], [MaDinhMucChucDanh]) VALUES (N'hocham005           ', N'Trợ giảng', N'dmcd004             ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP01                ', N'Bảo đảm an toàn thông tin', 3, 50, N'BM01                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP02                ', N'Mạng máy tính', 3, 50, N'BM01                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP03                ', N'Đạo đức học', 3, 54, N'BM01                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP04                ', N'Tư tưởng Hồ Chí Minh', 4, 76, N'BM02                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP05                ', N'Triết học 1', 2, 65, N'BM03                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP06                ', N'Triết học 2', 1, 54, N'BM03                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP07                ', N'Cơ sở dữ liệu', 1, 34, N'BM05                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP08                ', N'Xác xuất thông kê', 4, 65, N'BM07                ', N'QDLH02              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP09                ', N'Lập trình 1', 2, 54, N'BM09                ', N'QDLH02              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP10                ', N'Lập trình 2', 1, 23, N'BM08                ', N'QDLH02              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP11                ', N'Vô tuyến điện tử', 2, 54, N'BM08                ', N'QDLH03              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP12                ', N'Siêu cao tần', 4, 35, N'BM10                ', N'QDLH03              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP13                ', N'Ăng ten', 2, 54, N'BM12                ', N'QDLH03              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP14                ', N'Điện tử tương tự', 4, 76, N'BM15                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP15                ', N'Lý thuyết mạch', 1, 65, N'BM15                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP16                ', N'Lập trình hợp ngữ', 2, 63, N'BM12                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP17                ', N'Đại số tuyến tính', 5, 63, N'BM13                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP18                ', N'Giải tích 1', 4, 65, N'BM05                ', N'QDLH01              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP19                ', N'Giải tích 2', 2, 63, N'BM01                ', N'QDLH04              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP20                ', N'Vật lý 1', 1, 74, N'BM05                ', N'QDLH04              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP21                ', N'Vật lý 2', 5, 36, N'BM02                ', N'QDLH04              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP22                ', N'vật lý 3', 2, 64, N'BM04                ', N'QDLH04              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP23                ', N'Giải tích 3', 5, 85, N'BM06                ', N'QDLH05              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP24                ', N'Toán chuyền đề', 1, 67, N'BM13                ', N'QDLH05              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP25                ', N'Thu phát', 3, 56, N'BM13                ', N'QDLH05              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP26                ', N'Tiếng anh a1', 2, 76, N'BM14                ', N'QDLH06              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP27                ', N'Tiếng anh a2', 3, 76, N'BM17                ', N'QDLH06              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP28                ', N'Tiếng nga', 1, 65, N'BM16                ', N'QDLH06              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP29                ', N'Tiếng pháp', 3, 84, N'BM17                ', N'QDLH06              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP30                ', N'Tiếng nhật', 2, 86, N'BM15                ', N'QDLH06              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP31                ', N'Lịch sử Đảng', 1, 58, N'BM11                ', N'QDLH06              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP32                ', N'Dân tộc học', 3, 76, N'BM02                ', N'QDLH06              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP33                ', N'Tâm lý', 4, 45, N'BM05                ', N'QDLH06              ')
INSERT [dbo].[HocPhan] ([MaHocPhan], [TenHocPhan], [SoTinChi], [SoTiet], [MaBoMon], [MaLoaiHinhCon]) VALUES (N'HP34                ', N'Giáo dục', 1, 32, N'BM06                ', N'QDLH06              ')
INSERT [dbo].[HocPhanChamThi] ([MaHocPhanChamThi], [SoBai], [MaLopHoc], [MaQuyDoi], [GhiChu]) VALUES (N'HPCT01              ', 23, N'LH01                ', N'DKLH24              ', N'Công nghệ thông tin')
INSERT [dbo].[HocPhanChamThi] ([MaHocPhanChamThi], [SoBai], [MaLopHoc], [MaQuyDoi], [GhiChu]) VALUES (N'HPCT02              ', 54, N'LH03                ', N'DKLH25              ', N'Vật lý')
INSERT [dbo].[HocPhanChamThi] ([MaHocPhanChamThi], [SoBai], [MaLopHoc], [MaQuyDoi], [GhiChu]) VALUES (N'HPCT03              ', 167, N'LH10                ', N'DKLH30              ', N'Thi đại học môn toán')
INSERT [dbo].[HocPhanChamThi] ([MaHocPhanChamThi], [SoBai], [MaLopHoc], [MaQuyDoi], [GhiChu]) VALUES (N'HPCT04              ', 124, N'LH01                ', N'DKLH26              ', N'Giải tích')
INSERT [dbo].[HocPhanChamThi] ([MaHocPhanChamThi], [SoBai], [MaLopHoc], [MaQuyDoi], [GhiChu]) VALUES (N'HPCT05              ', 12, N'LH01                ', N'DKLH24              ', N'Thi giữa kỳ')
INSERT [dbo].[HocPhanChamThi] ([MaHocPhanChamThi], [SoBai], [MaLopHoc], [MaQuyDoi], [GhiChu]) VALUES (N'HPCT06              ', 46, N'LH03                ', N'DKLH29              ', N'Thi cuối kỳ')
INSERT [dbo].[HocPhanChamThi] ([MaHocPhanChamThi], [SoBai], [MaLopHoc], [MaQuyDoi], [GhiChu]) VALUES (N'HPCT07              ', 65, N'LH10                ', N'DKLH31              ', N'Phúc tra')
INSERT [dbo].[HocPhanChamThi] ([MaHocPhanChamThi], [SoBai], [MaLopHoc], [MaQuyDoi], [GhiChu]) VALUES (N'HPCT08              ', 76, N'LH07                ', N'DKLH33              ', N'Học sinh giỏi lý')
INSERT [dbo].[HocPhanChamThi] ([MaHocPhanChamThi], [SoBai], [MaLopHoc], [MaQuyDoi], [GhiChu]) VALUES (N'HPCT09              ', 26, N'LH09                ', N'DKLH31              ', N'Công nghệ số')
INSERT [dbo].[HocPhanChamThi] ([MaHocPhanChamThi], [SoBai], [MaLopHoc], [MaQuyDoi], [GhiChu]) VALUES (N'HPCT10              ', 13, N'LH06                ', N'DKLH28              ', N'An toàn thông tin')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'hocvi001            ', N'Tiến sĩ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'hocvi002            ', N'Thạc sĩ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'hocvi003            ', N'Kỹ sư')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi]) VALUES (N'hocvi004            ', N'Cử nhân')
INSERT [dbo].[HocVien] ([MaHocVien], [TenHocVien], [MaLop]) VALUES (N'HV001               ', N'Nguyễn Mạnh Thiên', N'Lop01               ')
INSERT [dbo].[HocVien] ([MaHocVien], [TenHocVien], [MaLop]) VALUES (N'HV002               ', N'Bùi Mạnh Hoài', N'Lop03               ')
INSERT [dbo].[HocVien] ([MaHocVien], [TenHocVien], [MaLop]) VALUES (N'HV003               ', N'Võ Huy Hoàng', N'Lop02               ')
INSERT [dbo].[HocVien] ([MaHocVien], [TenHocVien], [MaLop]) VALUES (N'HV004               ', N'Nguyễn Tú Ngọc', N'Lop04               ')
INSERT [dbo].[HocVien] ([MaHocVien], [TenHocVien], [MaLop]) VALUES (N'HV005               ', N'Bùi Thanh Hoàng', N'Lop05               ')
INSERT [dbo].[HocVien] ([MaHocVien], [TenHocVien], [MaLop]) VALUES (N'HV006               ', N'Hoàng Thị Thủy', N'Lop07               ')
INSERT [dbo].[HocVien] ([MaHocVien], [TenHocVien], [MaLop]) VALUES (N'HV007               ', N'Nguyễn Đức Trường', N'Lop08               ')
INSERT [dbo].[HocVien] ([MaHocVien], [TenHocVien], [MaLop]) VALUES (N'HV009               ', N'Lê Ngọc Dự', N'Lop09               ')
INSERT [dbo].[HocVien] ([MaHocVien], [TenHocVien], [MaLop]) VALUES (N'HV010               ', N'Đặng Xuân Trường', N'Lop10               ')
INSERT [dbo].[HocVien] ([MaHocVien], [TenHocVien], [MaLop]) VALUES (N'HV011               ', N'Cao Minh Ngọc', N'Lop11               ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD01                ', N'Nhận diện khuân mặt', 5, CAST(N'2017-02-02T00:00:00.000' AS DateTime), CAST(N'2017-08-01T00:00:00.000' AS DateTime), N'HV002               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD02                ', N'Phóng xạ mặt trời', 2, CAST(N'2014-11-05T00:00:00.000' AS DateTime), CAST(N'2015-05-23T00:00:00.000' AS DateTime), N'HV005               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD03                ', N'An toàn mạng xã hội', 5, CAST(N'2016-05-06T00:00:00.000' AS DateTime), CAST(N'2017-02-06T00:00:00.000' AS DateTime), N'HV003               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD04                ', N'Toán học trong quân sự', 3, CAST(N'2018-03-30T00:00:00.000' AS DateTime), CAST(N'2018-05-04T00:00:00.000' AS DateTime), N'HV010               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD05                ', N'Điện hạt nhân', 5, CAST(N'2017-08-03T00:00:00.000' AS DateTime), CAST(N'2017-10-12T00:00:00.000' AS DateTime), N'HV003               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD06                ', N'Thiên hà 42-62', 2, CAST(N'2010-06-12T00:00:00.000' AS DateTime), CAST(N'2011-03-21T00:00:00.000' AS DateTime), N'HV006               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD07                ', N'Đạo đức trong đời sống', 5, CAST(N'2012-02-22T00:00:00.000' AS DateTime), CAST(N'2013-07-26T00:00:00.000' AS DateTime), N'HV007               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD08                ', N'Mạng máy tính', 4, CAST(N'2014-10-26T00:00:00.000' AS DateTime), CAST(N'2015-03-12T00:00:00.000' AS DateTime), N'HV004               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD09                ', N'Mã hóa- số hóa', 5, CAST(N'2016-07-15T00:00:00.000' AS DateTime), CAST(N'2016-11-24T00:00:00.000' AS DateTime), N'HV009               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD10                ', N'Thiết bị IOT', 1, CAST(N'2017-04-01T00:00:00.000' AS DateTime), CAST(N'2017-06-04T00:00:00.000' AS DateTime), N'HV011               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD11                ', N'Ý thức học tập', 5, CAST(N'2012-01-24T00:00:00.000' AS DateTime), CAST(N'2012-03-08T00:00:00.000' AS DateTime), N'HV010               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD12                ', N'Tác phong mang mặc', 5, CAST(N'2014-02-05T00:00:00.000' AS DateTime), CAST(N'2014-02-18T00:00:00.000' AS DateTime), N'HV003               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD13                ', N'Toán học trong quân sự lần 2', 3, CAST(N'2018-03-30T00:00:00.000' AS DateTime), CAST(N'2018-05-04T00:00:00.000' AS DateTime), N'HV010               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD14                ', N'Điện hạt nhân lần 2', 5, CAST(N'2017-08-03T00:00:00.000' AS DateTime), CAST(N'2017-10-12T00:00:00.000' AS DateTime), N'HV003               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD15                ', N'Thiên hà 42-62 lần 2', 2, CAST(N'2010-06-12T00:00:00.000' AS DateTime), CAST(N'2011-03-21T00:00:00.000' AS DateTime), N'HV006               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD16                ', N'Đạo đức trong đời sống lần 2', 5, CAST(N'2012-02-22T00:00:00.000' AS DateTime), CAST(N'2013-07-26T00:00:00.000' AS DateTime), N'HV007               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD17                ', N'Mạng máy tính lần 2', 4, CAST(N'2014-10-26T00:00:00.000' AS DateTime), CAST(N'2015-03-12T00:00:00.000' AS DateTime), N'HV004               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD18                ', N'Mã hóa- số hóa lần 2', 5, CAST(N'2016-07-15T00:00:00.000' AS DateTime), CAST(N'2016-11-24T00:00:00.000' AS DateTime), N'HV009               ', N'QDLH07              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD19                ', N'Thiết bị IOT lần 2', 1, CAST(N'2017-04-01T00:00:00.000' AS DateTime), CAST(N'2017-06-04T00:00:00.000' AS DateTime), N'HV011               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD20                ', N'Ý thức học tập lần 2', 5, CAST(N'2012-01-24T00:00:00.000' AS DateTime), CAST(N'2012-03-08T00:00:00.000' AS DateTime), N'HV010               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD21                ', N'Tác phong mang mặc lần 2', 5, CAST(N'2014-02-05T00:00:00.000' AS DateTime), CAST(N'2014-02-18T00:00:00.000' AS DateTime), N'HV003               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD22                ', N'Nhận diện khuân mặt', 5, CAST(N'2017-02-02T00:00:00.000' AS DateTime), CAST(N'2017-08-01T00:00:00.000' AS DateTime), N'HV002               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD23                ', N'Phóng xạ mặt trời', 2, CAST(N'2014-11-05T00:00:00.000' AS DateTime), CAST(N'2015-05-23T00:00:00.000' AS DateTime), N'HV005               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD24                ', N'An toàn mạng xã hội', 5, CAST(N'2016-05-06T00:00:00.000' AS DateTime), CAST(N'2017-02-06T00:00:00.000' AS DateTime), N'HV003               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD25                ', N'Toán học trong quân sự', 3, CAST(N'2018-03-30T00:00:00.000' AS DateTime), CAST(N'2018-05-04T00:00:00.000' AS DateTime), N'HV010               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD26                ', N'Điện hạt nhân', 5, CAST(N'2017-08-03T00:00:00.000' AS DateTime), CAST(N'2017-10-12T00:00:00.000' AS DateTime), N'HV003               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD27                ', N'Thiên hà 42-62', 2, CAST(N'2010-06-12T00:00:00.000' AS DateTime), CAST(N'2011-03-21T00:00:00.000' AS DateTime), N'HV006               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD28                ', N'Đạo đức trong đời sống', 5, CAST(N'2012-02-22T00:00:00.000' AS DateTime), CAST(N'2013-07-26T00:00:00.000' AS DateTime), N'HV007               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD29                ', N'Mạng máy tính', 4, CAST(N'2014-10-26T00:00:00.000' AS DateTime), CAST(N'2015-03-12T00:00:00.000' AS DateTime), N'HV004               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD30                ', N'Mã hóa- số hóa', 5, CAST(N'2016-07-15T00:00:00.000' AS DateTime), CAST(N'2016-11-24T00:00:00.000' AS DateTime), N'HV009               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD31                ', N'Thiết bị IOT', 1, CAST(N'2017-04-01T00:00:00.000' AS DateTime), CAST(N'2017-06-04T00:00:00.000' AS DateTime), N'HV011               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD32                ', N'Ý thức học tập', 5, CAST(N'2012-01-24T00:00:00.000' AS DateTime), CAST(N'2012-03-08T00:00:00.000' AS DateTime), N'HV010               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD33                ', N'Tác phong mang mặc', 5, CAST(N'2014-02-05T00:00:00.000' AS DateTime), CAST(N'2014-02-18T00:00:00.000' AS DateTime), N'HV003               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD34                ', N'Toán học trong quân sự lần 2', 3, CAST(N'2018-03-30T00:00:00.000' AS DateTime), CAST(N'2018-05-04T00:00:00.000' AS DateTime), N'HV010               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD35                ', N'Điện hạt nhân lần 2', 5, CAST(N'2017-08-03T00:00:00.000' AS DateTime), CAST(N'2017-10-12T00:00:00.000' AS DateTime), N'HV003               ', N'QDLH08              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD36                ', N'Thiên hà 42-62 lần 2', 2, CAST(N'2010-06-12T00:00:00.000' AS DateTime), CAST(N'2011-03-21T00:00:00.000' AS DateTime), N'HV006               ', N'QDLH09              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD37                ', N'Đạo đức trong đời sống lần 2', 5, CAST(N'2012-02-22T00:00:00.000' AS DateTime), CAST(N'2013-07-26T00:00:00.000' AS DateTime), N'HV007               ', N'QDLH09              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD38                ', N'Mạng máy tính lần 2', 4, CAST(N'2014-10-26T00:00:00.000' AS DateTime), CAST(N'2015-03-12T00:00:00.000' AS DateTime), N'HV004               ', N'QDLH09              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD39                ', N'Mã hóa- số hóa lần 2', 5, CAST(N'2016-07-15T00:00:00.000' AS DateTime), CAST(N'2016-11-24T00:00:00.000' AS DateTime), N'HV009               ', N'QDLH10              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD40                ', N'Thiết bị IOT lần 2', 1, CAST(N'2017-04-01T00:00:00.000' AS DateTime), CAST(N'2017-06-04T00:00:00.000' AS DateTime), N'HV011               ', N'QDLH10              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD41                ', N'Ý thức học tập lần 2', 5, CAST(N'2012-01-24T00:00:00.000' AS DateTime), CAST(N'2012-03-08T00:00:00.000' AS DateTime), N'HV010               ', N'QDLH09              ')
INSERT [dbo].[HuongDan] ([MaHuongDan], [TenDeTai_ChuDe], [SoCanBoHuongDan], [ThoiGianBatDau], [ThoiGianKetThuc], [MaHocVien], [MaQuyDoi]) VALUES (N'HD42                ', N'Tác phong mang mặc lần 2', 5, CAST(N'2014-02-05T00:00:00.000' AS DateTime), CAST(N'2014-02-18T00:00:00.000' AS DateTime), N'HV003               ', N'QDLH10              ')
INSERT [dbo].[HuongNghienCuu] ([MaHuongNghienCuu], [TenHuongNghienCuu]) VALUES (N'hnc001              ', N'An ninh thông tin')
INSERT [dbo].[HuongNghienCuu] ([MaHuongNghienCuu], [TenHuongNghienCuu]) VALUES (N'hnc002              ', N'Bảo mật thông tin')
INSERT [dbo].[KhenThuongKyLuat] ([MaKhenThuongKyLuat], [TenKhenThuongKyLuat], [Loai]) VALUES (N'ktkl001             ', N'Bằng khen', N'Khen thưởng')
INSERT [dbo].[KhenThuongKyLuat] ([MaKhenThuongKyLuat], [TenKhenThuongKyLuat], [Loai]) VALUES (N'ktkl002             ', N'Giấy khen', N'Khen thưởng')
INSERT [dbo].[KhenThuongKyLuat] ([MaKhenThuongKyLuat], [TenKhenThuongKyLuat], [Loai]) VALUES (N'ktkl003             ', N'Khiển trách', N'Kỷ luật')
INSERT [dbo].[KhenThuongKyLuat] ([MaKhenThuongKyLuat], [TenKhenThuongKyLuat], [Loai]) VALUES (N'ktkl004             ', N'Cảnh cáo', N'Kỷ luật')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'Khoa01              ', N'Công nghệ thông tin')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'Khoa02              ', N'Kỹ thuật điều khiển')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'Khoa03              ', N'Mac-Lenin')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'Khoa04              ', N'Hóa Lý kỹ thuật')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'Khoa05              ', N'Ngoại ngữ')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'Khoa06              ', N'Viện Công trình đặc biệt')
INSERT [dbo].[LoaiHinhChinhNCKH] ([MaLoaiHinhChinh], [TenLoaiHinhChinh]) VALUES (N'lhcnckh001          ', N'Bài báo khoa học')
INSERT [dbo].[LoaiHinhChinhNCKH] ([MaLoaiHinhChinh], [TenLoaiHinhChinh]) VALUES (N'lhcnckh002          ', N'Đề tài nghiên cứu khoa học các cấp')
INSERT [dbo].[LoaiHinhChinhNCKH] ([MaLoaiHinhChinh], [TenLoaiHinhChinh]) VALUES (N'lhcnckh003          ', N'Biên soạn sách, sách chuyên khảo, giáo trình, tài liệu tham khảo,sách hướng dẫn')
INSERT [dbo].[LoaiHinhConNCKH] ([MaLoaiHinhCon], [TenLoaiHinhCon], [DonViTinh], [GioChuan], [MaLoaiHinhChinh], [TyLeChinh]) VALUES (N'loaihinhcon001      ', N'Đăng trong toàn văn trong KYHNKH trong nước', N'01 bài báo', 100, N'lhcnckh001          ', 0)
INSERT [dbo].[LoaiHinhConNCKH] ([MaLoaiHinhCon], [TenLoaiHinhCon], [DonViTinh], [GioChuan], [MaLoaiHinhChinh], [TyLeChinh]) VALUES (N'loaihinhcon002      ', N'Đăng trong toàn văn trong TCKH trong nước có ISSN', N'01 bài báo', 150, N'lhcnckh001          ', 0)
INSERT [dbo].[LoaiHinhConNCKH] ([MaLoaiHinhCon], [TenLoaiHinhCon], [DonViTinh], [GioChuan], [MaLoaiHinhChinh], [TyLeChinh]) VALUES (N'loaihinhcon003      ', N'Đăng trong toàn văn trong KYHNKH quốc tế', N'01 bài báo', 150, N'lhcnckh001          ', 0)
INSERT [dbo].[LoaiHinhConNCKH] ([MaLoaiHinhCon], [TenLoaiHinhCon], [DonViTinh], [GioChuan], [MaLoaiHinhChinh], [TyLeChinh]) VALUES (N'loaihinhcon004      ', N'Đăng trong toàn văn trong TCKH quốc tế có ISI', N'01 bài báo', 200, N'lhcnckh001          ', 0)
INSERT [dbo].[LoaiHinhConNCKH] ([MaLoaiHinhCon], [TenLoaiHinhCon], [DonViTinh], [GioChuan], [MaLoaiHinhChinh], [TyLeChinh]) VALUES (N'loaihinhcon005      ', N'Đề tài, dự án sản xuất thứ cấp Nhà nước', N'01 đề tài', 400, N'lhcnckh002          ', 20)
INSERT [dbo].[LoaiHinhConNCKH] ([MaLoaiHinhCon], [TenLoaiHinhCon], [DonViTinh], [GioChuan], [MaLoaiHinhChinh], [TyLeChinh]) VALUES (N'loaihinhcon006      ', N'Sách chuyên khảo', N'01 trang tác giả', 3, N'lhcnckh003          ', 0)
INSERT [dbo].[LoaiHinhConNCKH] ([MaLoaiHinhCon], [TenLoaiHinhCon], [DonViTinh], [GioChuan], [MaLoaiHinhChinh], [TyLeChinh]) VALUES (N'loaihinhcon007      ', N'Giáo trình mới', N'01 dvht hoặc 01 tc', 150, N'lhcnckh003          ', 20)
INSERT [dbo].[LoaiHinhConNCKH] ([MaLoaiHinhCon], [TenLoaiHinhCon], [DonViTinh], [GioChuan], [MaLoaiHinhChinh], [TyLeChinh]) VALUES (N'loaihinhcon008      ', N'Giáo trình tái bản(có bổ sung, sửa chữa)', N'01 dvht hoặc 01 tc', 120, N'lhcnckh003          ', 20)
INSERT [dbo].[LoaiHinhConNCKH] ([MaLoaiHinhCon], [TenLoaiHinhCon], [DonViTinh], [GioChuan], [MaLoaiHinhChinh], [TyLeChinh]) VALUES (N'loaihinhcon009      ', N'Tài liệu biên dịch, sách tham khảo', N'01 dvht hoặc 01 tc', 100, N'lhcnckh003          ', 20)
INSERT [dbo].[LoaiHinhConNCKH] ([MaLoaiHinhCon], [TenLoaiHinhCon], [DonViTinh], [GioChuan], [MaLoaiHinhChinh], [TyLeChinh]) VALUES (N'loaihinhcon010      ', N'Sách hướng dẫn, bài giảng đối mới học phần chưa có giáo trình', N'01 dvht hoặc 01 tc', 75, N'lhcnckh003          ', 20)
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop01               ', N'An ninh hệ thống thông tin', 10, N'H01                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop02               ', N'Công nghệ thông tin', 74, N'H01                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop03               ', N'Đạn', 49, N'H02                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop04               ', N'Vũ khí', 104, N'H02                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop05               ', N'Oto', 84, N'H03                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop06               ', N'Pháo tàu', 26, N'H02                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop07               ', N'Điện tàu', 99, N'H03                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop08               ', N'Tên lửa phòng không', 160, N'H04                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop09               ', N'Thông tin', 75, N'H05                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop10               ', N'Kỹ thuật vật liệu', 77, N'H06                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop11               ', N'Tác chiến điện tử', 50, N'H07                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop12               ', N'Hóa học', 24, N'H08                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop13               ', N'Dịa tin học', 85, N'H09                 ')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [SiSo], [MaHe]) VALUES (N'Lop14               ', N'Hải quân', 127, N'H11                 ')
INSERT [dbo].[LopHoc] ([MaLopHoc], [TenLopHoc], [CSN_CN], [HocKy], [MaLop], [MaHocPhan], [MaQuyDoi]) VALUES (N'LH01                ', N'Công nghệ thông tin', N'CSN                 ', N'Kỳ 2 năm 2015-2016', N'Lop01               ', N'HP01                ', NULL)
INSERT [dbo].[LopHoc] ([MaLopHoc], [TenLopHoc], [CSN_CN], [HocKy], [MaLop], [MaHocPhan], [MaQuyDoi]) VALUES (N'LH02                ', N'Công nghệ thông tin 2', N'CN                  ', N'Kỳ 2 năm 2015-2016', N'Lop02               ', N'HP02                ', NULL)
INSERT [dbo].[LopHoc] ([MaLopHoc], [TenLopHoc], [CSN_CN], [HocKy], [MaLop], [MaHocPhan], [MaQuyDoi]) VALUES (N'LH03                ', N'Hệ thống thông tin', N'CSN                 ', N'Kỳ 2 năm 2015-2016', N'Lop05               ', N'HP04                ', NULL)
INSERT [dbo].[LopHoc] ([MaLopHoc], [TenLopHoc], [CSN_CN], [HocKy], [MaLop], [MaHocPhan], [MaQuyDoi]) VALUES (N'LH04                ', N'Điều khiển tự động', N'CN                  ', N'Kỳ 2 năm 2015-2016', N'Lop12               ', N'HP12                ', N'DKLH06              ')
INSERT [dbo].[LopHoc] ([MaLopHoc], [TenLopHoc], [CSN_CN], [HocKy], [MaLop], [MaHocPhan], [MaQuyDoi]) VALUES (N'LH05                ', N'Công nghệ hóa', N'CN                  ', N'Kỳ 2 năm 2015-2016', N'Lop13               ', N'HP22                ', NULL)
INSERT [dbo].[LopHoc] ([MaLopHoc], [TenLopHoc], [CSN_CN], [HocKy], [MaLop], [MaHocPhan], [MaQuyDoi]) VALUES (N'LH06                ', N'Lý thuyết hệ điều hành', N'CSN                 ', N'Kỳ 2 năm 2015-2016', N'Lop12               ', N'HP14                ', NULL)
INSERT [dbo].[LopHoc] ([MaLopHoc], [TenLopHoc], [CSN_CN], [HocKy], [MaLop], [MaHocPhan], [MaQuyDoi]) VALUES (N'LH07                ', N'Công tác đảng', N'CSN                 ', N'Kỳ 2 năm 2015-2016', N'Lop11               ', N'HP16                ', NULL)
INSERT [dbo].[LopHoc] ([MaLopHoc], [TenLopHoc], [CSN_CN], [HocKy], [MaLop], [MaHocPhan], [MaQuyDoi]) VALUES (N'LH08                ', N'Điều lệnh', N'CN                  ', N'Kỳ 2 năm 2015-2016', N'Lop12               ', N'HP08                ', NULL)
INSERT [dbo].[LopHoc] ([MaLopHoc], [TenLopHoc], [CSN_CN], [HocKy], [MaLop], [MaHocPhan], [MaQuyDoi]) VALUES (N'LH09                ', N'Tổng hợp', N'CSN                 ', N'Kỳ 2 năm 2015-2016', N'Lop07               ', N'HP17                ', NULL)
INSERT [dbo].[LopHoc] ([MaLopHoc], [TenLopHoc], [CSN_CN], [HocKy], [MaLop], [MaHocPhan], [MaQuyDoi]) VALUES (N'LH10                ', N'Siêu cao tần', N'CN                  ', N'Kỳ 2 năm 2015-2016', N'Lop08               ', N'HP32                ', N'DKLH10              ')
INSERT [dbo].[NgoaiNgu] ([MaNgoaiNgu], [TenNgoaiNgu]) VALUES (N'nn001               ', N'Tiếng anh')
INSERT [dbo].[NgoaiNgu] ([MaNgoaiNgu], [TenNgoaiNgu]) VALUES (N'nn002               ', N'Tiếng nga')
INSERT [dbo].[NgoaiNgu] ([MaNgoaiNgu], [TenNgoaiNgu]) VALUES (N'nn003               ', N'Tiếng trung')
INSERT [dbo].[NgoaiNgu] ([MaNgoaiNgu], [TenNgoaiNgu]) VALUES (N'nn004               ', N'Tiếng hàn')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0001              ', N'qtdt001             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0002              ', N'qtdt002             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0003              ', N'qtdt003             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0004              ', N'qtdt004             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0005              ', N'qtdt005             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0006              ', N'qtdt006             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0007              ', N'qtdt007             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0008              ', N'qtdt008             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0009              ', N'qtdt009             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0010              ', N'qtdt010             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0011              ', N'qtdt011             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0012              ', N'qtdt012             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0013              ', N'qtdt013             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0014              ', N'qtdt014             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0015              ', N'qtdt015             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0016              ', N'qtdt016             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0017              ', N'qtdt017             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0018              ', N'qtdt018             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0019              ', N'qtdt019             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0020              ', N'qtdt020             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0021              ', N'qtdt021             ')
INSERT [dbo].[QuaTrinhDaoTao] ([MaGiaoVien], [MaQuaTrinhDaoTao]) VALUES (N'gv0022              ', N'qtdt022             ')
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt001             ', N'dtdh001             ', CAST(N'1988-01-01' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt002             ', N'dtdh001             ', CAST(N'1988-01-02' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt003             ', N'dtdh001             ', CAST(N'1988-01-03' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt004             ', N'dtdh001             ', CAST(N'1988-01-04' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt005             ', N'dtdh001             ', CAST(N'1988-01-01' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt006             ', N'dtdh001             ', CAST(N'1988-01-01' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt007             ', N'dtdh001             ', CAST(N'1988-02-03' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt008             ', N'dtdh001             ', CAST(N'1988-02-02' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt009             ', N'dtdh001             ', CAST(N'1988-04-04' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt010             ', N'dtdh001             ', CAST(N'1988-04-05' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt011             ', N'dtdh001             ', CAST(N'1988-04-07' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt012             ', N'dtdh001             ', CAST(N'1988-05-07' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt013             ', N'dtdh001             ', CAST(N'1988-05-07' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt014             ', N'dtdh001             ', CAST(N'1988-05-07' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt015             ', N'dtdh001             ', CAST(N'1988-05-07' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt016             ', N'dtdh001             ', CAST(N'1988-07-07' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoDaiHoc], [NamTotNghiep]) VALUES (N'qtdt017             ', N'dtdh001             ', CAST(N'1988-07-07' AS Date))
INSERT [dbo].[QuaTrinhDaoTao_DaoTaoSauDaiHoc] ([MaQuaTrinhDaoTao], [MaDaoTaoSauDaiHoc], [NamTotNghiep], [TenDeAnTotNghiep]) VALUES (N'qtdt001             ', N'dtsdh003            ', CAST(N'1999-01-01' AS Date), N'Bảo mật thông tin')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH01              ', N'Giảng dạy lý thuyết', N'LHDT01              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH02              ', N'Hướng dẫn bài tập, bài kiểm tra, thí nghiệm, thực hành, thảo luận', N'LHDT01              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH03              ', N'Dạy ngoại ngữ', N'LHDT01              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH04              ', N'Dạy vẽ kỹ thuật', N'LHDT01              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH05              ', N'Dạy phụ đạo', N'LHDT01              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH06              ', N'Dạy thể dục thể thao và giáo dục thể chất', N'LHDT01              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH07              ', N'Đồ án môn cơ sở, tiểu luận các môn khoa học xã hội và nhân văn', N'LHDT02              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH08              ', N'Đồ án môn học chuyên nghành', N'LHDT02              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH09              ', N'Đồ án (Luân văn) tốt nghiệp', N'LHDT02              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH10              ', N'Tiểu luận các lớp ngắn hạn', N'LHDT02              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH11              ', N'Thi vấn đáp môn học', N'LHDT03              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH12              ', N'Thi viết', N'LHDT03              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH13              ', N'Thi tốt nghiệp', N'LHDT03              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH14              ', N'Chấm đồ án, bài tập lớn', N'LHDT03              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH15              ', N'Chấm thi tuyển sinh đại học', N'LHDT03              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH16              ', N'Tham gia hội đồng bảo vệ đồ án tốt nghiệp đại học', N'LHDT03              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH17              ', N'Sửa đổi, bổ sung ngân hành đề thi kết thúc học phần', N'LHDT03              ')
INSERT [dbo].[QuyDoiLoaiHinh] ([MaLoaiHinhCon], [TenLoaiHinhCon], [MaLoaiHinhDaoTao]) VALUES (N'QDLH18              ', N'Tham gia hội đồng đánh giá nghiệm thu đề tài nghiên cứu hóa học của học viên', N'LHDT03              ')
/****** Object:  StoredProcedure [dbo].[TK_GV_BB_TM]    Script Date: 6/30/2019 2:17:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TK_GV_BB_TM]
@magiaovien CHAR(20),@time DATE
AS
BEGIN
	SELECT TenBaiBao,TenLoaiHinhCon AS Loai,VaiTroTrongBaiBao AS VaiTro,SoTacGia,SoGioChuan AS GioChuan,ThoiGianBatDau AS BatDau,ThoiGianKetThuc AS KetThuc FROM ThongKe_BaiBao(@magiaovien)
	WHERE CAST(ThoiGianBatDau AS DATE) <= CAST(@time AS DATE)
	AND CAST(ThoiGianKetThuc AS DATE) >= CAST(@time AS DATE)
END
GO
/****** Object:  StoredProcedure [dbo].[TK_GV_BSS_TM]    Script Date: 6/30/2019 2:17:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TK_GV_BSS_TM]
@magiaovien CHAR(20),@time DATE
AS
BEGIN
	SELECT TenSach,TenLoaiHinhCon AS Loai,VaiTroTrongBienSoan AS VaiTro,SoThanhVien,SoGioChuan AS GioChuan,ThoiGianBatDau AS BatDau,ThoiGianKetThuc AS KetThuc FROM dbo.ThongKe_BienSoanSach(@magiaovien)
	WHERE CAST(ThoiGianBatDau AS DATE) <= CAST(@time AS DATE)
	AND CAST(ThoiGianKetThuc AS DATE) >= CAST(@time AS DATE)
END
GO
/****** Object:  StoredProcedure [dbo].[TK_GV_DT_TM]    Script Date: 6/30/2019 2:17:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TK_GV_DT_TM]
@magiaovien CHAR(20),@time DATE
AS
BEGIN
	SELECT TenDeTai,TenLoaiHinhCon AS Loai,VaiTroTrongNghienCuu AS VaiTro,SoThanhVien,SoGioChuan AS GioChuan,ThoiGianBatDau AS BatDau,ThoiGianKetThuc AS KetThuc FROM dbo.ThongKe_DeTai(@magiaovien)
	WHERE CAST(ThoiGianBatDau AS DATE) <= CAST(@time AS DATE)
	AND CAST(ThoiGianKetThuc AS DATE) >= CAST(@time AS DATE)
END
GO
/****** Object:  StoredProcedure [dbo].[TongTaiGD]    Script Date: 6/30/2019 2:17:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TongTaiGD]
AS 
BEGIN
    SELECT	TenDonViChinhQuyen AS [Tên đơn vị], SUM(dbo.TongGD(GiaoVien.MaGiaoVien, getdate())) AS [Số giờ chuẩn đã thực hiện]  FROM dbo.GiaoVien,dbo.GiaoVien_ChinhQuyen,dbo.ChinhQuyen,dbo.DonViChinhQuyen
	WHERE GiaoVien.MaGiaoVien = GiaoVien_ChinhQuyen.MaGiaoVien
	AND ChinhQuyen.MaChinhQuyen = GiaoVien_ChinhQuyen.MaChinhQuyen
	AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen
	GROUP BY TenDonViChinhQuyen
END
GO
/****** Object:  StoredProcedure [dbo].[XuatThongTinGV]    Script Date: 6/30/2019 2:17:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[XuatThongTinGV]
@magiaovien CHAR(20)
AS
BEGIN
    SELECT TenGiaoVien,TenDonViChinhQuyen FROM GiaoVien_ChinhQuyen,ChinhQuyen,DonViChinhQuyen,GiaoVien
	WHERE ChinhQuyen.MaChinhQuyen = GiaoVien_ChinhQuyen.MaChinhQuyen
	AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen
	AND GiaoVien_ChinhQuyen.MaGiaoVien = GiaoVien.MaGiaoVien
	AND GiaoVien.MaGiaoVien = @magiaovien
END
GO
USE [master]
GO
ALTER DATABASE [QUAN_LY_GIAO_VIEN] SET  READ_WRITE 
GO
