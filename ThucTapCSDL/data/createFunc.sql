

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

DROP FUNCTION ThongKe_MGCVD
SELECT * FROM ThongKe_MGCVD('gv0002','2015')
----------------------thong ke viet bang seclect





SELECT MaGiaoVien,C.MaChinhQuyen,ThoiGianNhan,ThoiGianKetThuc,C.MaChucVuChinhQuyen,C.TyLeMienGiamThap,C.TyLeMienGiamCao FROM dbo.GiaoVien_ChinhQuyen
JOIN (
	SELECT MaChinhQuyen,B.MaChucVuChinhQuyen,B.TyLeMienGiamThap,B.TyLeMienGiamCao FROM dbo.ChinhQuyen
	JOIN (
		SELECT MaChucVuChinhQuyen,A.MaDinhMucMienGiam,A.TyLeMienGiamThap,A.TyLeMienGiamCao FROM dbo.ChucVuChinhQuyen
		JOIN (SELECT MaDinhMucMienGiam,TyLeMienGiamThap,TyLeMienGiamCao FROM dbo.DinhMucMienGiamChucVu) AS A
		ON A.MaDinhMucMienGiam = ChucVuChinhQuyen.MaDinhMucMienGiam 
	) AS B
	ON B.MaChucVuChinhQuyen = ChinhQuyen.MaChucVuChinhQuyen
) AS C
ON C.MaChinhQuyen = GiaoVien_ChinhQuyen.MaChinhQuyen

SELECT MaGiaoVien,C.MaDang,ThoiGianNhan,ThoiGianKetThuc,C.MaChucVuDang,C.TyLeMienGiamThap,C.TyLeMienGiamCao FROM dbo.GiaoVien_Dang
JOIN(		
	SELECT MaDang,B.MaChucVuDang,B.TyLeMienGiamThap,B.TyLeMienGiamCao FROM dbo.Dang
	JOIN (
		SELECT MaChucVuDang,A.MaDinhMucMienGiam,A.TyLeMienGiamThap,A.TyLeMienGiamCao FROM dbo.ChucVuDang
		JOIN (SELECT MaDinhMucMienGiam,TyLeMienGiamThap,TyLeMienGiamCao FROM dbo.DinhMucMienGiamChucVu) AS A
		ON A.MaDinhMucMienGiam = ChucVuDang.MaDinhMucMienGiam
	) AS B
	ON B.MaChucVuDang = Dang.MaChucVuDang 
) AS C
ON C.MaDang = GiaoVien_Dang.MaDang



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

DROP FUNCTION ThongKe_MGCVCQ
SELECT * FROM ThongKe_MGCVCQ('gv0019','2006')
SELECT * FROM ThongKe_MGCVD('gv0019','2006')
SELECT * FROM dbo.GiaoVien_GiamDacBiet,dbo.DinhMucGiamDacBiet
WHERE DinhMucGiamDacBiet.MaDinhMucGiamDacBiet = GiaoVien_GiamDacBiet.MaDinhMucGiamDacBiet
AND MaGiaoVien = 'gv0019'

CREATE FUNCTION MienGiam(@magiaovien CHAR(20),@time DATE)
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

PRINT dbo.MienGiam('gv0001','2014')








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

SELECT TenBaiBao,TenLoaiHinhCon AS Loai,VaiTroTrongBaiBao AS VaiTro,SoGioChuan AS GioChuan FROM ThongKe_BaiBao('gv0003')

CREATE PROCEDURE TK_GV_BB_TM
@magiaovien CHAR(20),@time DATE
AS
BEGIN
	SELECT TenBaiBao,TenLoaiHinhCon AS Loai,VaiTroTrongBaiBao AS VaiTro,SoTacGia,SoGioChuan AS GioChuan,ThoiGianBatDau AS BatDau,ThoiGianKetThuc AS KetThuc FROM ThongKe_BaiBao(@magiaovien)
	WHERE CAST(ThoiGianBatDau AS DATE) <= CAST(@time AS DATE)
	AND CAST(ThoiGianKetThuc AS DATE) >= CAST(@time AS DATE)
END

DROP PROCEDURE TK_GV_BB_TM

EXEC TK_GV_BB_TM @magiaovien = 'gv0003',@time = '2008'


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
CREATE PROCEDURE TK_GV_DT_TM
@magiaovien CHAR(20),@time DATE
AS
BEGIN
	SELECT TenDeTai,TenLoaiHinhCon AS Loai,VaiTroTrongNghienCuu AS VaiTro,SoThanhVien,SoGioChuan AS GioChuan,ThoiGianBatDau AS BatDau,ThoiGianKetThuc AS KetThuc FROM dbo.ThongKe_DeTai(@magiaovien)
	WHERE CAST(ThoiGianBatDau AS DATE) <= CAST(@time AS DATE)
	AND CAST(ThoiGianKetThuc AS DATE) >= CAST(@time AS DATE)
END

DROP PROCEDURE TK_GV_DT_TM

EXEC TK_GV_DT_TM @magiaovien = 'gv0003',@time = '2006'

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


CREATE PROCEDURE TK_GV_BSS_TM
@magiaovien CHAR(20),@time DATE
AS
BEGIN
	SELECT TenSach,TenLoaiHinhCon AS Loai,VaiTroTrongBienSoan AS VaiTro,SoThanhVien,SoGioChuan AS GioChuan,ThoiGianBatDau AS BatDau,ThoiGianKetThuc AS KetThuc FROM dbo.ThongKe_BienSoanSach(@magiaovien)
	WHERE CAST(ThoiGianBatDau AS DATE) <= CAST(@time AS DATE)
	AND CAST(ThoiGianKetThuc AS DATE) >= CAST(@time AS DATE)
END

DROP PROCEDURE TK_GV_BSS_TM

EXEC TK_GV_BSS_TM @magiaovien = 'gv0003',@time = '2006'

-------------------------------tra ve tong tai cua giao vien do----------------

PRINT dbo.MienGiam('gv0001','2004')
EXEC TK_GV_BB_TM @magiaovien = 'gv0001',@time = '2004'
EXEC TK_GV_DT_TM @magiaovien = 'gv0001',@time = '2004'
EXEC TK_GV_BSS_TM @magiaovien = 'gv0001',@time = '2004'

--------------------------------- tong tai nckh cua mot giao vien
UPDATE dbo.GiaoVien_ChucDanh SET ThoiGianNhanKetThuc = NULL

CREATE FUNCTION TongTaiNCKH_GV(@magiaovien CHAR(20),@time date )
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
DROP FUNCTION  TongTaiNCKH_GV

SELECT * FROM dbo.TongTaiNCKH_GV('gv0001','2006')

CREATE FUNCTION ShowNCKH(@time date)
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

DROP FUNCTION ShowNCKH
SELECT * FROM dbo. ShowNCKH('2006')


-----------------------------------
CREATE PROCEDURE XuatThongTinGV
@magiaovien CHAR(20)
AS
BEGIN
    SELECT TenGiaoVien,TenDonViChinhQuyen FROM GiaoVien_ChinhQuyen,ChinhQuyen,DonViChinhQuyen,GiaoVien
	WHERE ChinhQuyen.MaChinhQuyen = GiaoVien_ChinhQuyen.MaChinhQuyen
	AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen
	AND GiaoVien_ChinhQuyen.MaGiaoVien = GiaoVien.MaGiaoVien
	AND GiaoVien.MaGiaoVien = @magiaovien
END

EXEC dbo. XuatThongTinGV 'gv0001'

------dua ra tai giang day va tai nghien cuu khoa hoc cua mot giao vien
-----------------------------------
----tra cuuu de tai
SELECT * FROM dbo.DeTaiNghienCuu

SELECT TenGiaoVien,VaiTroTrongNghienCuu FROM dbo.GiaoVien,dbo.GiaoVien_NghienCuuKhoaHoc
WHERE GiaoVien.MaGiaoVien = GiaoVien_NghienCuuKhoaHoc.MaGiaoVien
AND MaDeTai = 'dtnckh0001'






----------------------tao ham khong su dung con tro
CREATE FUNCTION THONGKE_MIENGIAMDANG()
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
DROP FUNCTION THONGKE_MIENGIAMDANG
SELECT * FROM THONGKE_MIENGIAMDANG ()


-------
CREATE FUNCTION THONGKE_MIENGIAMCHINHQUYEN()
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

DROP FUNCTION THONGKE_MIENGIAMCHINHQUYEN
SELECT  FROM THONGKE_MIENGIAMCHINHQUYEN()
SELECT * FROM THONGKE_MIENGIAMDANG()

CREATE FUNCTION MIENGIAM_GIAOVIEN (@time date )
RETURNS @tb_miengiam TABLE (
	MagiaoVien CHAR(20),
	TyLeGiam Int
)
AS
BEGIN
	DECLARE @time DATE
	SET @time = '2016'
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
	 
	SELECT * FROM @tb_temp
	INSERT INTO @tb_miengiam (MaGiaoVien,TyLeGiam)
	SELECT MaGiaoVien,tong FROM @tb_temp
	RETURN
END

SELECT * FROM MienGiam_GiaoVien ('2016')
WHERE MaGiaoVien = 'gv0001'


SELECT * FROM dbo.DinhMucChucDanh

SELECT * FROM dbo.HocHam
SELECT * FROM dbo.ChucDanh





CREATE FUNCTION TinhDinhMucChucDanh(@time date)
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




CREATE FUNCTION TongTai( @time date)
RETURNS @tb_temp1 TABLE(
		TenKhoa NVARCHAR(50),
		TenGiaoVien NVARCHAR(200),
		ThucTaiDaoTao INT,
		YeuCauDaoTao  INT,
		[%DaoTao] INT,
		ThucTaiNCKH INT,
		YeuCauNCKH INT,
		[%NCKH] INT,
		TongTai INT NULL,
		TongTaiYeuCau INT NULL,
		[%Tong] INT NULL	
) 
AS
BEGIN
    DECLARE @tb_temp TABLE(
		TenKhoa NVARCHAR(50),
		TenGiaoVien NVARCHAR(200),
		ttgd INT,
		ycgd INT,
		ptgd INT,
		ttnc INT,
		ycnc INT,
		ptnc INT,
		tt INT NULL,
		yc INT NULL,
		pt INT NULL
	)
	INSERT INTO @tb_temp(TenKhoa,TenGiaoVien,ttgd,ycgd,ptgd,ttnc,ycnc,ptnc)
    select a.TenKhoa,a.TenGiaoVien,a.ThucTai,a.YeuCau,a.Phantramdatduoc,b.ThucTai ,b.TaiYeuCau,b.NCKH FROM ThongKeGiaoVienDaoTao(@time) AS a
	INNER JOIN  (
		SELECT * FROM dbo. ShowNCKH(@time)
	) AS b
	ON a.MaGiaoVien = b.MaGiaoVien
	
	UPDATE @tb_temp SET tt = ttnc + ttgd
	UPDATE @tb_temp SET yc = ycgd + ycnc
    UPDATE @tb_temp SET pt = tt * 100 / yc
	INSERT INTO @tb_temp1
	SELECT * FROM @tb_temp
	RETURN
END
 

DROP FUNCTION tongtai

SELECT * FROM dbo.TongTai('2016')
--------------------------
CREATE function  ThongKeNhanLuc(@Khoa char(20), @time date )
returns @ans table 
(
  TenKhoa nvarchar(50),
  GiaoSu INT,
  PhoGiaoSu INT,
  GiangVienChinh INT,
  GiangVien INT,
  TroGiang INT,
  TienSi INT,
  ThacSi INT,
  KySu INT,
  CuNhan INT,
  Tong Int 
  
)
AS 
BEGIN
  DECLARE @temp TABLE(
    GiaoSu INT,
    PhoGiaoSu INT,
    GiangVienChinh INT,
    GiangVien INT,
    TroGiang INT,
    TienSi INT,
    ThacSi INT,
    KySu INT,
    CuNhan INT
  )
  --declare @Khoa char(20)
  --set @Khoa = 'khoa01'
  DECLARE @tb_TKCD TABLE(
    TenChucDanh NVARCHAR(50),
    Soluong int
  )
  INSERT INTO @tb_TKCD
  SELECT dbo.ChucDanh.TenChucDanh,a.SoLuong FROM dbo.ChucDanh
  LEFT JOIN  (SELECT TenChucDanh,SoLuong FROM TinhSoLuongChucDanhTheoKhoa(@Khoa,@time)) AS a
  ON dbo.ChucDanh.TenChucDanh = a.TenChucDanh
  UPDATE @tb_TKCD SET Soluong = 0 WHERE Soluong IS NULL
  -------------------------
  DECLARE @tb_TKHV TABLE(
    
    TenHocVi NVARCHAR(50),
    Soluong int
  )

  INSERT INTO @tb_TKHV
  SELECT dbo.HocVi.TenHocVi,a.SoLuong FROM dbo.HocVi
  LEFT JOIN (SELECT TenHocVi,SoLuong FROM TinhSoLuongHocViTheoKhoa(@Khoa,@time)) AS a
  ON dbo.HocVi.TenHocVi = a.TenHocVi
  UPDATE @tb_TKHV SET Soluong = 0 WHERE Soluong IS NULL
  INSERT INTO @tb_TKCD
  SELECT * FROM @tb_TKHV

  
  declare @Tong int
  select @Tong = Sum(SoLuong) from @tb_TKCD
  
  insert into @temp
  select [Giáo sư], [Phó Giáo sư], [Giảng viên chính],[Giảng viên], [Trợ Giảng], [Tiến sĩ], [Thạc sĩ], [Kỹ sư], [Cử nhân]
  from
  (
    select SoLuong, TenChucDanh
    from @tb_TKCD
  ) d
  pivot
  (
    max(SoLuong)
    for TenChucDanh in ( [Giáo sư], [Phó Giáo sư], [Giảng viên chính],[Giảng viên], [Trợ Giảng], [Tiến sĩ], [Thạc sĩ], [Kỹ sư], [Cử nhân])
  ) piv;
  
  declare @TenKhoa nvarchar(50)
  select @TenKhoa = TenKhoa  from Khoa where MaKhoa = @Khoa
  insert into @ans
  select @TenKhoa,*, @Tong from @temp
  
  return 
END


-----------------
--select * from  dbo.ThongKeNhanLuc('khoa01', '1900') 
--------------------------
drop proc TongKeNhanLuc
create proc TongKeNhanLuc @time date 
as 

begin 
  
  declare @ans table (
    TenKhoa nvarchar(50),
  GiaoSu INT,
  PhoGiaoSu INT,
  GiangVienChinh INT,
  GiangVien INT,
  TroGiang INT,
  TienSi INT,
  ThacSi INT,
  KySu INT,
  CuNhan INT,
  Tong Int )


  DECLARE @makhoa char(20)
  

  DECLARE cursorProduct CURSOR FOR  
  SELECT MaKhoa FROM Khoa    

  OPEN cursorProduct                

  FETCH NEXT FROM cursorProduct    
      INTO @makhoa

  WHILE @@FETCH_STATUS = 0          
  BEGIN
    insert into @ans 
    select * from dbo.ThongKeNhanLuc(@makhoa, @time)
    FETCH NEXT FROM cursorProduct 
        INTO @makhoa
  END

  select * from @ans
  CLOSE cursorProduct             
  DEALLOCATE cursorProduct        
end 


exec TongKeNhanLuc '1966'




----------------------thong ke bai bao
CREATE PROCEDURE ShowBaiBao
AS
BEGIN
    SELECT MaBaiBao,TenBaiBao,A.TenLoaiHinhCon,SoLuongTacGia,A.GioChuan FROM dbo.BaiBao
	JOIN (
		SELECT * FROM dbo.LoaiHinhConNCKH
	) AS A
	ON A.MaLoaiHinhCon = BaiBao.MaLoaiHinhCon
END

EXEC ShowBaiBao

CREATE PROCEDURE showMemBB 
@id CHAR(20)
AS
BEGIN
    SELECT TenGiaoVien,A.VaiTroTrongBaiBao,A.ThoiGianBatDau,A.ThoiGianHoanThanh FROM dbo.GiaoVien
	JOIN (
		SELECT * FROM dbo.GiaoVien_BaiBao
		WHERE MaBaiBao = @id
	)AS A
	ON A.MaGiaoVien = GiaoVien.MaGiaoVien
END
DROP PROCEDURE showmembb
EXEC showmembb 'bb0001'