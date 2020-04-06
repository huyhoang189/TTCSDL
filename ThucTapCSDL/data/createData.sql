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
SELECT * FROM DangKiBangSoHuu
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
('bsc0003',  '111113', '2015',N'Trong nước',N'Cục Sở Hữu Trí Tuệ', 'duan003' )

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



------------------------
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
---------khoa cntt
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq001', 'cvcq003','dvcq001')--chu nhiem khoa
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq002', 'cvcq004','dvcq001')--pho khoa
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq003', 'cvcq009','dvcq001')--giao vien
-----khoa ktdk
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq004', 'cvcq003','dvcq002')--chu nhiem khoa
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq005', 'cvcq004','dvcq002')--pho khoa
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq006', 'cvcq009','dvcq002')--giao vien
---khoa hlkt
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq007', 'cvcq003','dvcq003')--chu nhiem khoa
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq008', 'cvcq004','dvcq003')--pho khoa
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq009', 'cvcq009','dvcq003')--giao vien
-----khoa vtdt
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq010', 'cvcq003','dvcq004')--chu nhiem khoa
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq011', 'cvcq004','dvcq004')--pho khoa
INSERT INTO dbo.ChinhQuyen( MaChinhQuyen, MaChucVuChinhQuyen, MaDonViChinhQuyen )VALUES  ( 'cq012', 'cvcq009','dvcq004')--giao vien


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
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0012', 'cq004', '1990-1-4')----thu id 12 la cua khoa khac
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0013', 'cq005', '1990-1-5')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0014', 'cq006', '1990-1-6')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0015', 'cq006', '1990-1-7')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0016', 'cq006', '1990-1-8')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0017', 'cq006', '1990-1-9')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0018', 'cq006', '1990-1-10')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0019', 'cq006', '1990-1-4')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0020', 'cq006', '1990-1-4')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0021', 'cq006', '1990-1-4')
INSERT INTO dbo.GiaoVien_ChinhQuyen  ( MaGiaoVien, MaChinhQuyen, ThoiGianNhan ) VALUES  ( 'gv0022', 'cq006', '1990-1-4')

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
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd004','dvd002', 'cvd001')--bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd005','dvd002', 'cvd002')--pho bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd006','dvd002', 'cvd005')--dang vien
------------------------khoa hlkt
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd007','dvd003', 'cvd001')--bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd008','dvd003', 'cvd002')--pho bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd009','dvd003', 'cvd005')--dang vien
----------khoa vtdt
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd010','dvd004', 'cvd001')--bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd011','dvd004', 'cvd002')--pho bi thu dang uy
INSERT INTO dbo.Dang ( MaDang, MaDonViDang, MaChucVuDang )VALUES  ( 'd012','dvd004', 'cvd005')--dang vien 


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
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0012', 'd004', '1990-3-21')----------
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0013', 'd005', '1990-4-21')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0014', 'd006', '1990-5-22')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0015', 'd006', '1990-6-23')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0016', 'd006', '1990-7-24')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0017', 'd006', '1990-8-22')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0018', 'd006', '1990-9-25')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0019', 'd006', '1990-10-26')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0020', 'd006', '1990-11-28')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0021', 'd006', '1990-11-21')
INSERT INTO dbo.GiaoVien_Dang ( MaGiaoVien, MaDang, ThoiGianNhan ) VALUES  ( 'gv0022', 'd006', '1990-11-20')

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


DELETE dbo.GiaoVien_ChucDanh
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
    ThoiGianBatDau,
	ThoiGianKetThuc
	)
VALUES
('gv0017','dmgdb001','2011','2014'),
('gv0019','dmgdb001','2015','2018')

---------------------------------------
insert into Khoa(MaKhoa, TenKhoa) values
('Khoa01', N'Công nghệ thông tin'),
('Khoa02', N'Kỹ thuật điều khiển'),
('Khoa03', N'Mac-Lenin'),
('Khoa04', N'Hóa Lý kỹ thuật'),
('Khoa05', N'Ngoại ngữ'),
('Khoa06', N'Viện Công trình đặc biệt')

go 
insert into chuongtrinhdaotao(Machuongtrinhdaotao, Tenchuongtrinhdaotao) values
('CTDT01', N'Giảng dạy đại học (CQ + VB2)'),
('CTDT02', N'Giảng dạy cao học'),
('CTDT03', N'Giảng dạy nghiên cứu sinh'),
('CTDT04', N'Giảng dạy cao đẳng')

SELECT * FROM chuongtrinhdaotao

-- data lop --- 
go
insert into Lop(MaLop, TenLop, SiSo, MaHe) values
('Lop01', N'An ninh hệ thống thông tin', 10, 'H01'),
('Lop02', N'Công nghệ thông tin', 74, 'H01'),
('Lop03', N'Đạn', 49, 'H02'),
('Lop04', N'Vũ khí',104, 'H02' ),
('Lop05', N'Oto', 84, 'H03'),
('Lop06', N'Pháo tàu', 26, 'H02'),
('Lop07', N'Điện tàu', 99, 'H03'),
('Lop08', N'Tên lửa phòng không', 160, 'H04'),
('Lop09', N'Thông tin', 75, 'H05'),
('Lop10', N'Kỹ thuật vật liệu', 77, 'H06'),
('Lop11', N'Tác chiến điện tử', 50, 'H07'),
('Lop12', N'Hóa học', 24, 'H08'),
('Lop13', N'Dịa tin học', 85, 'H09'),
('Lop14', N'Hải quân', 127, 'H11')

go

insert into HocVien(MaHocVien, TenHocVien, MaLop) values 
	('HV001', N'Nguyễn Mạnh Thiên', 'Lop01'),
	('HV002', N'Bùi Mạnh Hoài', 'Lop03'),
	('HV003', N'Võ Huy Hoàng', 'Lop02'),
	('HV004', N'Nguyễn Tú Ngọc', 'Lop04'),
	('HV005', N'Bùi Thanh Hoàng', 'Lop05'),
	('HV006', N'Hoàng Thị Thủy', 'Lop07'),
	('HV007', N'Nguyễn Đức Trường' , 'Lop08'),
	('HV009', N'Lê Ngọc Dự', 'Lop09'),
	('HV010', N'Đặng Xuân Trường', 'Lop10'),
	('HV011', N'Cao Minh Ngọc', 'Lop11')

go

insert into HocPhan(MaHocPhan, TenHocPhan, SoTinChi, SoTiet, MaBoMon, MaLoaiHinhCon) values
('HP01', N'Bảo đảm an toàn thông tin', 3, 50, 'BM01','QDLH01' ),
('HP02', N'Mạng máy tính', 3, 50, 'BM01', 'QDLH01' ),
('HP03', N'Đạo đức học', 3, 54, 'BM01', 'QDLH01' ),
('HP04', N'Tư tưởng Hồ Chí Minh', 4, 76, 'BM02', 'QDLH01' ),
('HP05', N'Triết học 1', 2, 65, 'BM03', 'QDLH01' ),
('HP06', N'Triết học 2', 1, 54, 'BM03', 'QDLH01' ),
('HP07', N'Cơ sở dữ liệu', 1, 34, 'BM05', 'QDLH01' ),
('HP08', N'Xác xuất thông kê', 4, 65, 'BM07', 'QDLH02' ),
('HP09', N'Lập trình 1', 2, 54, 'BM09', 'QDLH02' ),
('HP10', N'Lập trình 2', 1, 23, 'BM08', 'QDLH02' ),
('HP11', N'Vô tuyến điện tử', 2, 54, 'BM08', 'QDLH03' ),
('HP12', N'Siêu cao tần', 4, 35, 'BM10', 'QDLH03' ),
('HP13', N'Ăng ten', 2, 54, 'BM12', 'QDLH03' ),
('HP14', N'Điện tử tương tự', 4, 76, 'BM15', 'QDLH01' ),
('HP15', N'Lý thuyết mạch', 1, 65, 'BM15', 'QDLH01' ),
('HP16', N'Lập trình hợp ngữ', 2, 63, 'BM12', 'QDLH01' ),
('HP17', N'Đại số tuyến tính', 5, 63, 'BM13', 'QDLH01' ),
('HP18', N'Giải tích 1', 4, 65, 'BM05','QDLH01' ),
('HP19', N'Giải tích 2', 2, 63, 'BM01', 'QDLH04' ),
('HP20', N'Vật lý 1', 1, 74, 'BM05', 'QDLH04' ),
('HP21', N'Vật lý 2', 5, 36, 'BM02', 'QDLH04' ),
('HP22', N'vật lý 3', 2, 64, 'BM04', 'QDLH04' ),
('HP23', N'Giải tích 3', 5, 85, 'BM06', 'QDLH05' ),
('HP24', N'Toán chuyền đề', 1, 67, 'BM13', 'QDLH05' ),
('HP25', N'Thu phát', 3, 56, 'BM13', 'QDLH05' ),
('HP26', N'Tiếng anh a1', 2, 76, 'BM14', 'QDLH06' ),
('HP27', N'Tiếng anh a2', 3, 76, 'BM17', 'QDLH06' ),
('HP28', N'Tiếng nga', 1, 65, 'BM16','QDLH06' ),
('HP29', N'Tiếng pháp', 3, 84, 'BM17', 'QDLH06' ),
('HP30', N'Tiếng nhật', 2, 86, 'BM15', 'QDLH06' ),
('HP31', N'Lịch sử Đảng', 1, 58, 'BM11', 'QDLH06' ),
('HP32', N'Dân tộc học', 3, 76, 'BM02', 'QDLH06' ),
('HP33', N'Tâm lý', 4, 45, 'BM05', 'QDLH06' ),
('HP34', N'Giáo dục', 1, 32, 'BM06', 'QDLH06' )
go

insert into BoMon(MaBoMon, TenBoMon, MaKhoa) values
('BM01', N'An toàn thông tin',  'Khoa01'),
('BM02', N'Hệ thống thông tin',  'Khoa01'),
('BM03', N'Công nghệ mạng',  'Khoa01'),
('BM04', N'Công nghệ phần mềm',  'Khoa01'),
('BM05', N'Vô tuyến điện tử',  'Khoa02'),
('BM06', N'Điều khiển tự động',  'Khoa02'),
('BM07', N'Tư tưởng Hồ Chí Minh',  'Khoa03'),
('BM08', N'Công tác Đảng',  'Khoa03'),
('BM09', N'Triết học Mac-Lênin',  'Khoa03'),
('BM10', N'Vật lý',  'Khoa04'),
('BM11', N'Hóa học',  'Khoa04'),
('BM12', N'Tiếng anh',  'Khoa05'),
('BM13', N'An toàn thông tin',  'Khoa06'),
('BM14', N'Vật liệu xây dựng',  'Khoa06'),
('BM15', N'Tiếng nhật',  'Khoa05'),
('BM16', N'cầu đường',  'Khoa06'),
('BM17', N'Xây dựng dân dụng',  'Khoa06')

go 

-- them du lieu lop hoc  --
insert into LopHoc(MaLopHoc, TenLopHoc, CSN_CN, HocKy, MaLop, MaHocPhan, MaQuyDoi) values
('LH01', N'Công nghệ thông tin', 'CSN', N'Kỳ 2 năm 2015-2016', 'Lop01', 'HP01', NULL),
('LH02', N'Công nghệ thông tin 2', 'CN', N'Kỳ 2 năm 2015-2016', 'Lop02', 'HP02', NULL),
('LH03', N'Hệ thống thông tin', 'CSN', N'Kỳ 2 năm 2015-2016', 'Lop05', 'HP04', NULL),
('LH04', N'Điều khiển tự động', 'CN', N'Kỳ 2 năm 2015-2016', 'Lop12', 'HP12', 'DKLH06'),
('LH05', N'Công nghệ hóa', 'CN', N'Kỳ 2 năm 2015-2016', 'Lop13', 'HP22', NULL),
('LH06', N'Lý thuyết hệ điều hành', 'CSN', N'Kỳ 2 năm 2015-2016', 'Lop12', 'HP14', NULL),
('LH07', N'Công tác đảng', 'CSN', N'Kỳ 2 năm 2015-2016', 'Lop11', 'HP16', NULL),
('LH08', N'Điều lệnh', 'CN', N'Kỳ 2 năm 2015-2016', 'Lop12', 'HP08', NULL),
('LH09', N'Tổng hợp', 'CSN', N'Kỳ 2 năm 2015-2016', 'Lop07', 'HP17', NULL),
('LH10', N'Siêu cao tần', 'CN', N'Kỳ 2 năm 2015-2016', 'Lop08', 'HP32', 'DKLH10')

go


-- data hoc phan cham thi -- 
insert into HocPhanChamThi(MaHocPhanChamThi, GhiChu, SoBai, MaLopHoc, MaQuyDoi) values
('HPCT01', N'Công nghệ thông tin', 23, 'LH01', 'DKLH24'),
('HPCT02', N'Vật lý', 54, 'LH03', 'DKLH25'),
('HPCT03', N'Thi đại học môn toán', 167, 'LH10', 'DKLH30'),
('HPCT04', N'Giải tích', 124, 'LH01', 'DKLH26'),
('HPCT05', N'Thi giữa kỳ', 12, 'LH01', 'DKLH24'),
('HPCT06', N'Thi cuối kỳ', 46, 'LH03','DKLH29'),
('HPCT07', N'Phúc tra', 65, 'LH10', 'DKLH31'),
('HPCT08', N'Học sinh giỏi lý', 76, 'LH07', 'DKLH33'),
('HPCT09', N'Công nghệ số', 26, 'LH09', 'DKLH31'),
('HPCT10', N'An toàn thông tin', 13, 'LH06', 'DKLH28')
go


insert into HuongDan(MaHuongDan, TenDeTai_ChuDe, SoCanBoHuongDan, ThoiGianBatDau, ThoiGianKetThuc, MaHocVien, MaQuyDoi ) values
('HD01', N'Nhận diện khuân mặt', 5, '2017-2-2', '2017-8-1', 'HV002', 'QDLH07'),
('HD02', N'Phóng xạ mặt trời', 2, '2014-11-5', '2015-5-23', 'HV005', 'QDLH07'),
('HD03', N'An toàn mạng xã hội', 5, '2016-5-6', '2017-2-6', 'HV003', 'QDLH07'),
('HD04', N'Toán học trong quân sự', 3, '2018-3-30', '2018-5-4', 'HV010', 'QDLH07'),
('HD05', N'Điện hạt nhân', 5, '2017-8-3', '2017-10-12', 'HV003', 'QDLH07'),
('HD06', N'Thiên hà 42-62', 2, '2010-6-12', '2011-3-21', 'HV006', 'QDLH07'),
('HD07', N'Đạo đức trong đời sống', 5, '2012-2-22', '2013-7-26', 'HV007', 'QDLH07'),
('HD08', N'Mạng máy tính', 4, '2014-10-26', '2015-3-12', 'HV004', 'QDLH07'),
('HD09', N'Mã hóa- số hóa', 5, '2016-7-15', '2016-11-24', 'HV009', 'QDLH07'),
('HD10', N'Thiết bị IOT', 1, '2017-4-1', '2017-6-4', 'HV011', 'QDLH07'),
('HD11', N'Ý thức học tập', 5, '2012-1-24', '2012-3-8', 'HV010', 'QDLH07'),
('HD12', N'Tác phong mang mặc', 5, '2014-2-5', '2014-2-18', 'HV003', 'QDLH07'),
('HD13', N'Toán học trong quân sự lần 2', 3, '2018-3-30', '2018-5-4', 'HV010', 'QDLH07'),
('HD14', N'Điện hạt nhân lần 2', 5, '2017-8-3', '2017-10-12', 'HV003', 'QDLH07'),
('HD15', N'Thiên hà 42-62 lần 2', 2, '2010-6-12', '2011-3-21', 'HV006', 'QDLH07'),
('HD16', N'Đạo đức trong đời sống lần 2', 5, '2012-2-22', '2013-7-26', 'HV007', 'QDLH07'),
('HD17', N'Mạng máy tính lần 2', 4, '2014-10-26', '2015-3-12', 'HV004', 'QDLH07'),
('HD18', N'Mã hóa- số hóa lần 2', 5, '2016-7-15', '2016-11-24', 'HV009', 'QDLH07'),
('HD19', N'Thiết bị IOT lần 2', 1, '2017-4-1', '2017-6-4', 'HV011', 'QDLH08'),
('HD20', N'Ý thức học tập lần 2', 5, '2012-1-24', '2012-3-8', 'HV010', 'QDLH08'),
('HD21', N'Tác phong mang mặc lần 2', 5, '2014-2-5', '2014-2-18', 'HV003', 'QDLH08'),
('HD22', N'Nhận diện khuân mặt', 5, '2017-2-2', '2017-8-1', 'HV002', 'QDLH08'),
('HD23', N'Phóng xạ mặt trời', 2, '2014-11-5', '2015-5-23', 'HV005', 'QDLH08'),
('HD24', N'An toàn mạng xã hội', 5, '2016-5-6', '2017-2-6', 'HV003', 'QDLH08'),
('HD25', N'Toán học trong quân sự', 3, '2018-3-30', '2018-5-4', 'HV010', 'QDLH08'),
('HD26', N'Điện hạt nhân', 5, '2017-8-3', '2017-10-12', 'HV003', 'QDLH08'),
('HD27', N'Thiên hà 42-62', 2, '2010-6-12', '2011-3-21', 'HV006', 'QDLH08'),
('HD28', N'Đạo đức trong đời sống', 5, '2012-2-22', '2013-7-26', 'HV007', 'QDLH08'),
('HD29', N'Mạng máy tính', 4, '2014-10-26', '2015-3-12', 'HV004', 'QDLH08'),
('HD30', N'Mã hóa- số hóa', 5, '2016-7-15', '2016-11-24', 'HV009', 'QDLH08'),
('HD31', N'Thiết bị IOT', 1, '2017-4-1', '2017-6-4', 'HV011', 'QDLH08'),
('HD32', N'Ý thức học tập', 5, '2012-1-24', '2012-3-8', 'HV010', 'QDLH08'),
('HD33', N'Tác phong mang mặc', 5, '2014-2-5', '2014-2-18', 'HV003', 'QDLH08'),
('HD34', N'Toán học trong quân sự lần 2', 3, '2018-3-30', '2018-5-4', 'HV010', 'QDLH08'),
('HD35', N'Điện hạt nhân lần 2', 5, '2017-8-3', '2017-10-12', 'HV003', 'QDLH08'),
('HD36', N'Thiên hà 42-62 lần 2', 2, '2010-6-12', '2011-3-21', 'HV006', 'QDLH09'),
('HD37', N'Đạo đức trong đời sống lần 2', 5, '2012-2-22', '2013-7-26', 'HV007', 'QDLH09'),
('HD38', N'Mạng máy tính lần 2', 4, '2014-10-26', '2015-3-12', 'HV004', 'QDLH09'),
('HD39', N'Mã hóa- số hóa lần 2', 5, '2016-7-15', '2016-11-24', 'HV009', 'QDLH10'),
('HD40', N'Thiết bị IOT lần 2', 1, '2017-4-1', '2017-6-4', 'HV011', 'QDLH10'),
('HD41', N'Ý thức học tập lần 2', 5, '2012-1-24', '2012-3-8', 'HV010', 'QDLH09'),
('HD42', N'Tác phong mang mặc lần 2', 5, '2014-2-5', '2014-2-18', 'HV003', 'QDLH10')


go


insert into GiaoVien_LopHoc(GiaoVien_LopHoc, MaGiaoVien, MaLopHoc, ThoiGianBatDau, ThoiGianKetThuc) values
('GVLH15', 'gv0011', 'LH06', '2012-1-3', '2013-3-6'),
('GVLH14', 'gv0011', 'LH02', '2012-3-26', '2013-11-6'),
('GVLH13', 'gv0011', 'LH03', '2012-1-11', '2013-3-5'),
('GVLH12', 'gv0011', 'LH04', '2012-5-3', '2013-2-17'),
('GVLH11', 'gv0011', 'LH05', '2012-3-6', '2013-9-6'),
('GVLH01', 'gv0011', 'LH01', '2012-1-3', '2013-3-6'),
('GVLH02', 'gv0017', 'LH02', '2014-3-4', '2015-10-1'),
('GVLH03', 'gv0014', 'LH10', '2016-8-1', '2017-2-28'),
('GVLH04', 'gv0012', 'LH10', '2015-11-11', '2016-7-19'),
('GVLH05', 'gv0009', 'LH05', '2014-1-23', '2015-4-7'),
('GVLH06', 'gv0006', 'LH07', '2012-12-12', '2013-7-5'),
('GVLH07', 'gv0016', 'LH03', '2017-10-17', '2018-2-22'),
('GVLH08', 'gv0019', 'LH01', '2014-5-29', '2015-12-12'),
('GVLH09', 'gv0016', 'LH02', '2012-2-20', '2013-3-14'),
('GVLH10', 'gv0003', 'LH06', '2016-4-10', '2017-2-11')
go


-- them du lieu giao vien cham thi  -- 
insert into GiaoVien_HocPhanChamThi(GiaoVien_HocPhanChamThi, MaGiaoVien, MaHocPhanChamThi, ThoiGianBatDau, ThoiGianKetThuc) values
('GVHPCT01', 'gv0012', 'HPCT06', '2013-3-5', '2013-3-6'),
('GVHPCT02', 'gv0011', 'HPCT08', '2015-10-20', '2015-11-1'),
('GVHPCT03', 'gv0015', 'HPCT10', '2017-2-19', '2017-2-22'),
('GVHPCT04', 'gv0017', 'HPCT10', '2016-11-11', '2016-11-19'),
('GVHPCT05', 'gv0004', 'HPCT03', '2015-7-23', '2015-8-7'),
('GVHPCT06', 'gv0006', 'HPCT01', '2013-5-12', '2013-6-5'),
('GVHPCT07', 'gv0013', 'HPCT03', '2018-1-17', '2018-1-22'),
('GVHPCT08', 'gv0018', 'HPCT06', '2015-1-29', '2015-2-12'),
('GVHPCT09', 'gv0016', 'HPCT04', '2013-1-20', '2013-2-14'),
('GVHPCT10', 'gv0002', 'HPCT02', '2012-3-11', '2017-3-11'),
('GVHPCT11', 'gv0011', 'HPCT04', '2017-2-14', '2017-3-11'),
('GVHPCT12', 'gv0011', 'HPCT05', '2014-5-16', '2017-5-23'),
('GVHPCT13', 'gv0011', 'HPCT06', '2017-6-17', '2017-7-1'),
('GVHPCT14', 'gv0011', 'HPCT07', '2017-11-13', '2017-11-13'),
('GVHPCT15', 'gv0011', 'HPCT01', '2018-7-15', '2017-8-1'),
('GVHPCT16', 'gv0011', 'HPCT09', '2016-1-17', '2017-1-26'),
('GVHPCT17', 'gv0011', 'HPCT10', '2015-4-11', '2017-5-5')

go


insert into GiaoVien_HuongDan(GiaoVien_HuongDan, MaGiaoVien, MaHuongDan, ThoiGianBatDau, ThoiGianKetThuc) values
('GVHD01', 'gv0010', 'HD01', '2012-1-3', '2013-3-6'),
('GVHD02', 'gv0017', 'HD06', '2013-3-4', '2015-10-1'),
('GVHD03', 'gv0014', 'HD05', '2014-8-1', '2017-2-28'),
('GVHD04', 'gv0012', 'HD02', '2011-11-11', '2016-7-19'),
('GVHD05', 'gv0009', 'HD04', '2014-1-23', '2015-4-7'),
('GVHD06', 'gv0006', 'HD08', '2012-12-12', '2013-7-5'),
('GVHD07', 'gv0016', 'HD04', '2011-10-17', '2018-2-22'),
('GVHD08', 'gv0019', 'HD06', '2011-5-29', '2015-12-12'),
('GVHD09', 'gv0016', 'HD02', '2012-2-20', '2013-3-14'),
('GVHD10', 'gv0001', 'HD09', '2015-4-10', '2017-2-11'),
('GVHD11', 'gv0016', 'HD08', '2012-4-10', '2013-3-16'),
('GVHD12', 'gv0015', 'HD07', '2016-4-10', '2017-5-17'),
('GVHD13', 'gv0011', 'HD38', '2015-2-11', '2016-1-12'),
('GVHD14', 'gv0013', 'HD37', '2017-8-15', '2018-4-15'),
('GVHD15', 'gv0011', 'HD01', '2012-3-18', '2017-8-17'),
('GVHD16', 'gv0011', 'HD02', '2018-8-13', '2019-2-13'),
('GVHD17', 'gv0011', 'HD03', '2016-3-15', '2019-6-10'),
('GVHD18', 'gv0011', 'HD04', '2014-7-12', '2015-4-17'),
('GVHD19', 'gv0011', 'HD05', '2017-2-14', '2018-2-1'),
('GVHD20', 'gv0011', 'HD06', '2017-2-14', '2018-2-1'),
('GVHD21', 'gv0011', 'HD07', '2017-2-14', '2018-2-1'),
('GVHD22', 'gv0011', 'HD08', '2017-2-14', '2018-2-1'),
('GVHD23', 'gv0011', 'HD09', '2017-2-14', '2018-2-1'),
('GVHD24', 'gv0011', 'HD10', '2017-2-14', '2018-2-1'),
('GVHD25', 'gv0011', 'HD11', '2017-2-14', '2018-2-1'),
('GVHD26', 'gv0011', 'HD12', '2017-2-14', '2018-2-1'),
('GVHD27', 'gv0011', 'HD13', '2017-2-14', '2018-2-1'),
('GVHD28', 'gv0011', 'HD14', '2017-2-14', '2018-2-1'),
('GVHD29', 'gv0011', 'HD15', '2017-2-14', '2018-2-1'),
('GVHD30', 'gv0011', 'HD16', '2017-2-14', '2018-2-1'),
('GVHD31', 'gv0011', 'HD17', '2017-2-14', '2018-2-1'),
('GVHD32', 'gv0011', 'HD18', '2017-2-14', '2018-2-1'),
('GVHD33', 'gv0011', 'HD19', '2017-2-14', '2018-2-1'),
('GVHD34', 'gv0011', 'HD20', '2017-2-14', '2018-2-1'),
('GVHD35', 'gv0011', 'HD21', '2017-2-14', '2018-2-1'),
('GVHD36', 'gv0011', 'HD22', '2017-2-14', '2018-2-1'),
('GVHD37', 'gv0011', 'HD23', '2017-2-14', '2018-2-1'),
('GVHD38', 'gv0011', 'HD24', '2017-2-14', '2018-2-1'),
('GVHD39', 'gv0011', 'HD15', '2017-2-14', '2018-2-1'),
('GVHD40', 'gv0011', 'HD26', '2017-2-14', '2018-2-1'),
('GVHD41', 'gv0011', 'HD27', '2017-2-14', '2018-2-1'),
('GVHD42', 'gv0011', 'HD28', '2017-2-14', '2018-2-1'),
('GVHD43', 'gv0011', 'HD29', '2017-2-14', '2018-2-1'),
('GVHD44', 'gv0011', 'HD30', '2017-2-14', '2018-2-1'),
('GVHD45', 'gv0011', 'HD31', '2017-2-14', '2018-2-1'),
('GVHD46', 'gv0011', 'HD32', '2017-2-14', '2018-2-1'),
('GVHD47', 'gv0011', 'HD33', '2017-2-14', '2018-2-1'),
('GVHD48', 'gv0011', 'HD34', '2017-2-14', '2018-2-1'),
('GVHD49', 'gv0011', 'HD35', '2017-2-14', '2018-2-1'),
('GVHD50', 'gv0011', 'HD36', '2017-2-14', '2018-2-1'),
('GVHD51', 'gv0011', 'HD37', '2017-2-14', '2018-2-1'),
('GVHD52', 'gv0011', 'HD38', '2017-2-14', '2018-2-1'),
('GVHD53', 'gv0011', 'HD39', '2017-2-14', '2018-2-1'),
('GVHD54', 'gv0011', 'HD40', '2017-2-14', '2018-2-1'),
('GVHD55', 'gv0011', 'HD41', '2017-2-14', '2018-2-1'),
('GVHD56', 'gv0011', 'HD42', '2017-2-14', '2018-2-1')

go




insert into He(MaHe, TenHe, Machuongtrinhdaotao) values 
	('H01', N'Quân Sự', 'CTDT01'),
	('H02', N'Dân sự', 'CTDT01'),
	('H03', N'Văn bằng 2', 'CTDT01'),
	('H04', N'PTNC', 'CTDT02'),
	('H05', N'Ban ngày', 'CTDT02'),
	('H06', N'Buổi tối', 'CTDT02'),
	('H07', N'Tp.HCM', 'CTDT02'),
	('H08', N'Tập trung', 'CTDT03'),
	('H09', N'Không tập trung', 'CTDT03'),
	('H10', N'HV', 'CTDT04'),
	('H11', N'Tr10', 'CTDT04')


go
insert into CacLoaiHinhDaoTao(MaLoaiHinhDaoTao, TenLoaiHinhDaoTao) 
values ('LHDT01', N'Giờ lên lớp'),
('LHDT02', N'Hướng dẫn đồ án'),
('LHDT03', N'Chấm Thi và nghiệm thu, phản biện đề tài')


go
insert into QuyDoiLoaiHinh(MaLoaiHinhCon, TenLoaiHinhCon, MaLoaiHinhDaoTao)
values ('QDLH01', N'Giảng dạy lý thuyết', 'LHDT01'),
('QDLH02', N'Hướng dẫn bài tập, bài kiểm tra, thí nghiệm, thực hành, thảo luận', 'LHDT01'),
('QDLH03', N'Dạy ngoại ngữ', 'LHDT01'),
('QDLH04', N'Dạy vẽ kỹ thuật', 'LHDT01'),
('QDLH05', N'Dạy phụ đạo', 'LHDT01'),
('QDLH06', N'Dạy thể dục thể thao và giáo dục thể chất', 'LHDT01'),
('QDLH07', N'Đồ án môn cơ sở, tiểu luận các môn khoa học xã hội và nhân văn', 'LHDT02'),
('QDLH08', N'Đồ án môn học chuyên nghành', 'LHDT02'),
('QDLH09', N'Đồ án (Luân văn) tốt nghiệp', 'LHDT02'),
('QDLH10', N'Tiểu luận các lớp ngắn hạn', 'LHDT02'),
('QDLH11', N'Thi vấn đáp môn học', 'LHDT03'),
('QDLH12', N'Thi viết', 'LHDT03'),
('QDLH13', N'Thi tốt nghiệp', 'LHDT03'),
('QDLH14', N'Chấm đồ án, bài tập lớn', 'LHDT03'),
('QDLH15', N'Chấm thi tuyển sinh đại học', 'LHDT03'),
('QDLH16', N'Tham gia hội đồng bảo vệ đồ án tốt nghiệp đại học', 'LHDT03'),
('QDLH17', N'Sửa đổi, bổ sung ngân hành đề thi kết thúc học phần', 'LHDT03'),
('QDLH18', N'Tham gia hội đồng đánh giá nghiệm thu đề tài nghiên cứu hóa học của học viên', 'LHDT03')


go 
insert into DieuKienLoaiHinh(DieuKienLoaiHinh ,DieuKien, DonViTinh, QuyRaGioChuan, MaLoaiHinhCon)
values ('DKLH01', N'0-75', N'Học viên', 1.0, 'QDLH01'),
('DKLH02', N'76-100', N'Học viên', 1.1, 'QDLH01'),
('DKLH03', N'101-1000', N'Học viên', 1.2, 'QDLH01'),
('DKLH04', N'', N'Tiết', 0.5, 'QDLH02'),
('DKLH05', N'Cơ bản, cơ sở, ngành', N'Tiết', 0.8, 'QDLH03'),
('DKLH06', N'Chuyên nghành', N'Tiết', 1.0, 'QDLH03'),
('DKLH07', N'', N'Tiết', 0.75, 'QDLH04'),
('DKLH08', N'10', N'Phần trăm số tiết', 1.0, 'QDLH05'),
('DKLH09', N'Giảng dạy lý thuyết trên lớp, giảng dạy kỹ thuật ở sân bãi', N'Tiết', 1.2, 'QDLH06'),
('DKLH10', N'Bồi dưỡng cán sự thể dục thể thao', N'Tiết', 1.0, 'QDLH06'),
('DKLH11', N'Hướng dẫn ngoại khóa, khiểm tra sức khỏe kiểm tra rèn luyện thể lực, tổ chức thi trong Học viện hoặc dẫn đội thi đấu ngoài Học viện', N'Tiết', 2.5, 'QDLH06'),
('DKLH12', N'Trọng tài chính bóng đá', N'Trận', 3.0, 'QDLH06'),
('DKLH13', N'Trọng tài chính bóng rổ, bóng chuyền', N'Trận', 1.2, 'QDLH06'),
('DKLH14', N'Trọng tài chính bóng bàn', N'Trận', 1.0, 'QDLH06'),
('DKLH15', N'Trọng tài phụ, thư ký bóng đá', N'Trận', 1.5, 'QDLH06'),
('DKLH16', N'Trọng tài phụ, thư ký bóng rổ, bóng chuyền', N'Trận', 1.0, 'QDLH06'),
('DKLH17', N'Trọng tài phụ, thư ký bóng bàn', N'Trận', 0.5, 'QDLH06'),
('DKLH18', N'1-15', N'Học viên', 1.5, 'QDLH07'),
('DKLH19', N'16-1000', N'Học viên', 0.75, 'QDLH07'),
('DKLH20', N'1-15', N'Học viên', 2.0, 'QDLH08'),
('DKLH21', N'16-1000', N'Học viên', 1.0, 'QDLH08'),
('DKLH22', N'', N'Đồ án', 15.0, 'QDLH09'),
('DKLH23', N'', N'Tiểu luận', 4.0, 'QDLH10'),
('DKLH24', N'', N'Học viên', 0.333333, 'QDLH11'),
('DKLH25', N'', N'Học viên', 0.25, 'QDLH12'),
('DKLH26', N'', N'Học viên', 0.5, 'QDLH13'),
('DKLH27', N'Bài tập lớn, bài tập', N'BTL', 0.33333, 'QDLH14'),
('DKLH28', N'Đồ án môn cơ sở, tiểu luận môn khoa học xã hội và nhân văn', N'DA(TL)', 0.5, 'QDLH14'),
('DKLH29', N'Đồ án môn học chuyên ngành', N'BTL', 0.66666, 'QDLH14'),
('DKLH30', N'Đồ án tốt nghiệp đại học', N'BTL', 5.0, 'QDLH14'),
('DKLH31', N'', N'BTL', 0.2, 'QDLH15'),
('DKLH32', N'', N'Buổi', 2.0, 'QDLH16'),
('DKLH33', N'', N'Học phần', 15.0, 'QDLH17'),
('DKLH34', N'Chủ tịch', N'Đề tài', 0.666666, 'QDLH18'),
('DKLH35', N'Thư ký', N'Đề tài', 0.666666, 'QDLH18')

go