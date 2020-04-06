	----tai dao tao


	-- tinh dieu kien Si So -- 
	go
	CREATE FUNCTION QuyDoiDieuKien(@MaDieuKien char(20), @DieuKien nvarchar(200), @SiSo int) 
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

	go
	print [dbo].[QuyDoiDieuKien]('DKLH15', N'Trọng tài phụ, thư ký bóng đá',  200)


	--drop function QuyDoiDieuKien
	-- tinh si so -- 

	go
	create function GiangDay(@MaGiaoVien char(20), @starttime DATETIME, @endtime DATE)
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

	go
	--drop function GiangDay

	--select * from  GiangDay('gv0011', '2000-1-1', '2019-1-1')

	--sELECT Tenchuongtrinhdaotao as Loaidaotao, TenHocPhan,SiSo , He, Lop, SoTC, SoTiet, GioChuan FROM GiangDay('gv0011', '1900-1-1', '2014')


	-- tinh tai cham thi -- 

	go
	create  function  TinhChamThi (@MaGiaoVien char(20), @starttime DATETIME, @endtime DATE)
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
	go
	--drop function TinhChamThi


	--select TenHocPhan as HocPhan , TenLop as Lop , SoBai, SoGio as GioChuan from TinhChamThi('gv0011', '2000-1-1', '2019-1-1')

	-- huong dan 

	go

	create function  TinhHuongDan (@MaGiaoVien char(20), @starttime DATETIME, @endtime DATE)
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

	go
	--drop function TinhHuongDan


	select * from  TinhHuongDan('gv0011', '2000-1-1', '2019-1-1')
	select TenLoaiHinh as LoaiHinh, TenHV as HocVien, TenLop as Lop,  TenHe as He, SoCanBoHD as SoCanBoHuongDan, GioChuan from  TinhHuongDan('gv0011', '2000-1-1', '2019-1-1')

	create function TongGD(@magv char(20), @time datetime )
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
	-- drop function TongGD
	go
	create function TongGiangDayTheoNam(@magv char(20), @time date )
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
	--drop function TongGiangDayTheoNam
	print dbo.TongGiangDayTheoNam('gv0011', '2015')
	go 
	CREATE PROCEDURE TongTaiGD
	AS 
	BEGIN
		SELECT	TenDonViChinhQuyen AS [Tên đơn vị], SUM(dbo.TongGD(GiaoVien.MaGiaoVien, getdate())) AS [Số giờ chuẩn đã thực hiện]  FROM dbo.GiaoVien,dbo.GiaoVien_ChinhQuyen,dbo.ChinhQuyen,dbo.DonViChinhQuyen
		WHERE GiaoVien.MaGiaoVien = GiaoVien_ChinhQuyen.MaGiaoVien
		AND ChinhQuyen.MaChinhQuyen = GiaoVien_ChinhQuyen.MaChinhQuyen
		AND ChinhQuyen.MaDonViChinhQuyen = DonViChinhQuyen.MaDonViChinhQuyen
		GROUP BY TenDonViChinhQuyen
	END


	exec TongTaiGD


	select TenHocHam, MaGiaoVien, GiaoVien_HocHam.ThoiGianNhan from HocHam, GiaoVien_HocHam where HocHam.MaHocHam = GiaoVien_HocHam.MaHocHam 

	select * from GiaoVien_HocHam, HocHam, DinhMucChucDanh where GiaoVien_HocHam.MaHocHam = HocHam.MaHocHam and TenHocHam like DinhMucChucDanh.TenChucDanh

	select * from DinhMucChucDanh 


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


	select * from TinhDinhMucChucDanh(getdate())


	go 
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
	--DROP FUNCTION THONGKE_MIENGIAMDANG
	go 
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

	--DROP FUNCTION THONGKE_MIENGIAMCHINHQUYEN
	go 
	CREATE FUNCTION MIENGIAM_GIAOVIEN (@time date )
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
	  SELECT X.MaGiaoVien,X.chinhquyen,X.dang,Y.db FROM   (SELECT A.MaGiaoVien,chinhquyen,dang FROM (SELECT MaGiaoVien,TyLeGiam AS chinhquyen  FROM THONGKE_MIENGIAMCHINHQUYEN()
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


	select * from MIENGIAM_GIAOVIEN('1999')
	go 

	create function ThongKeGiaoVienDaoTao(@time date)
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

	-- drop function ThongKeGiaoVienDaoTao
	select TenKhoa,SUM(ThucTai) AS ThucTai,SUM(YeuCau) AS YeuCau,SUM(Phantramdatduoc)/ COUNT(TenKhoa) AS  [%Tong]FROM ThongKeGiaoVienDaoTao('2015')
	GROUP BY TenKhoa



