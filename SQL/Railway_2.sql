SET AUTOCOMMIT = OFF;
START TRANSACTION;

DROP DATABASE IF EXISTS GIAOHANGNHANH;
CREATE DATABASE GIAOHANGNHANH;
USE GIAOHANGNHANH;

create table LOAIMATHANG (
	MaLoaiMatHang INT PRIMARY KEY,
	TenLoaiMatHang VARCHAR(50)
);
insert into LOAIMATHANG (MaLoaiMatHang, TenLoaiMatHang) values (1, 'Diplotomma Lichen');
insert into LOAIMATHANG (MaLoaiMatHang, TenLoaiMatHang) values (2, 'Appalachian Polytrichum Moss');
insert into LOAIMATHANG (MaLoaiMatHang, TenLoaiMatHang) values (3, 'Maroon Carolina Milkvine');
insert into LOAIMATHANG (MaLoaiMatHang, TenLoaiMatHang) values (4, 'Western Ragwort');
insert into LOAIMATHANG (MaLoaiMatHang, TenLoaiMatHang) values (5, 'Wildrye');

create table KHUVUC (
	MaKhuVuc INT PRIMARY KEY,
	TenKhuVuc VARCHAR(50)
);
insert into KHUVUC (MaKhuVuc, TenKhuVuc) values (1, 'Walton');
insert into KHUVUC (MaKhuVuc, TenKhuVuc) values (2, 'Melody');
insert into KHUVUC (MaKhuVuc, TenKhuVuc) values (3, 'Summer Ridge');
insert into KHUVUC (MaKhuVuc, TenKhuVuc) values (4, 'La Follette');
insert into KHUVUC (MaKhuVuc, TenKhuVuc) values (5, 'Paget');

create table KHOANGTHOIGIAN (
	MaKhoangThoiGianGiaoHang INT PRIMARY KEY,
	MoTa VARCHAR(50)
);
insert into KHOANGTHOIGIAN (MaKhoangThoiGianGiaoHang, MoTa) values (1, 'Rice-Sauer');
insert into KHOANGTHOIGIAN (MaKhoangThoiGianGiaoHang, MoTa) values (2, 'Tremblay, Funk and Mayer');
insert into KHOANGTHOIGIAN (MaKhoangThoiGianGiaoHang, MoTa) values (3, 'Cummerata and Sons');
insert into KHOANGTHOIGIAN (MaKhoangThoiGianGiaoHang, MoTa) values (4, 'Wilkinson-Harris');
insert into KHOANGTHOIGIAN (MaKhoangThoiGianGiaoHang, MoTa) values (5, 'Erdman Inc');

create table DICHVU (
	MaDichVu INT  PRIMARY KEY,
	TenDichVu VARCHAR(50)
);
insert into DICHVU (MaDichVu, TenDichVu) values (1, 'Tin');
insert into DICHVU (MaDichVu, TenDichVu) values (2, 'Zamit');
insert into DICHVU (MaDichVu, TenDichVu) values (3, 'Alphazap');
insert into DICHVU (MaDichVu, TenDichVu) values (4, 'Bitwolf');
insert into DICHVU (MaDichVu, TenDichVu) values (5, 'Greenlam');

create table THANHVIENGIAOHANG (
	MaThanhVienGiaoHang INT PRIMARY KEY,
	TenThanhVienGiaoHang VARCHAR(50),
	NgaySinh DATE,
	GioiTinh VARCHAR(50),
	SoDTThanhVien VARCHAR(50),
	DiaChiThanhVien VARCHAR(50)
);
insert into THANHVIENGIAOHANG (MaThanhVienGiaoHang, TenThanhVienGiaoHang, NgaySinh, GioiTinh, SoDTThanhVien, DiaChiThanhVien) values (1, 'Chalmers Cocci', '1993-12-2', 'Male', '8956208141', '0 Grover Terrace');
insert into THANHVIENGIAOHANG (MaThanhVienGiaoHang, TenThanhVienGiaoHang, NgaySinh, GioiTinh, SoDTThanhVien, DiaChiThanhVien) values (2, 'Cly Penniall', '1993-6-25', 'Male', '6754745074', '5 Miller Terrace');
insert into THANHVIENGIAOHANG (MaThanhVienGiaoHang, TenThanhVienGiaoHang, NgaySinh, GioiTinh, SoDTThanhVien, DiaChiThanhVien) values (3, 'Wynne Deaton', '1997-2-12', 'Female', '2788649933', '03044 Corscot Trail');
insert into THANHVIENGIAOHANG (MaThanhVienGiaoHang, TenThanhVienGiaoHang, NgaySinh, GioiTinh, SoDTThanhVien, DiaChiThanhVien) values (4, 'Yuri Purslow', '1998-5-21', 'Male', '2334599367', '08483 Karstens Drive');
insert into THANHVIENGIAOHANG (MaThanhVienGiaoHang, TenThanhVienGiaoHang, NgaySinh, GioiTinh, SoDTThanhVien, DiaChiThanhVien) values (5, 'Leora Skaife', '1998-9-13', 'Female', '1269502161', '75 Shelley Road');

create table DANGKYGIAOHANG (
	MaThanhVienGiaoHang INT,
	MaKhoangThoiGianDKGiaoHang INT,
    FOREIGN KEY (MaThanhVienGiaoHang) REFERENCES ThanhVienGiaoHang(MaThanhVienGiaoHang) ON DELETE CASCADE,
    FOREIGN KEY (MaKhoangThoiGianDKGiaoHang) REFERENCES KhoangThoiGian(MaKhoangThoiGianGiaoHang) ON DELETE NO ACTION
);
insert into DANGKYGIAOHANG (MaThanhVienGiaoHang, MaKhoangThoiGianDKGiaoHang) values (1, 1);
insert into DANGKYGIAOHANG (MaThanhVienGiaoHang, MaKhoangThoiGianDKGiaoHang) values (3, 3);
insert into DANGKYGIAOHANG (MaThanhVienGiaoHang, MaKhoangThoiGianDKGiaoHang) values (5, 5);
insert into DANGKYGIAOHANG (MaThanhVienGiaoHang, MaKhoangThoiGianDKGiaoHang) values (4, 5);
insert into DANGKYGIAOHANG (MaThanhVienGiaoHang, MaKhoangThoiGianDKGiaoHang) values (5, 3);


create table KHACHHANG (
	MaKhachHang INT PRIMARY KEY,
	MaKhuVuc INT,
	TenKhachHang VARCHAR(50),
	TenCuaHang VARCHAR(50),
	SoDTKhachHang VARCHAR(50),
	DiaChiEmail VARCHAR(50),
	DiaChiNhanHang VARCHAR(50),
    FOREIGN KEY (MaKhuVuc) REFERENCES KhuVuc(MaKhuVuc) ON DELETE SET NULL
);
insert into KHACHHANG (MaKhachHang, MaKhuVuc, TenKhachHang, TenCuaHang, SoDTKhachHang, DiaChiEmail, DiaChiNhanHang) values (1, 5, 'Nerissa Bricksey', 'Gigamon Inc.', '5404750423', 'nbricksey0@newyorker.com', '93185 Logan Circle');
insert into KHACHHANG (MaKhachHang, MaKhuVuc, TenKhachHang, TenCuaHang, SoDTKhachHang, DiaChiEmail, DiaChiNhanHang) values (2, 1, 'Silas Bloyes', 'NantKwest, Inc.', '6568536205', 'sbloyes1@freewebs.com', '6179 Hanover Junction');
insert into KHACHHANG (MaKhachHang, MaKhuVuc, TenKhachHang, TenCuaHang, SoDTKhachHang, DiaChiEmail, DiaChiNhanHang) values (3, 3, 'Doll Blanking', 'Syros Pharmaceuticals, Inc.', '6255286700', 'dblanking2@cnbc.com', '3503 Victoria Court');
insert into KHACHHANG (MaKhachHang, MaKhuVuc, TenKhachHang, TenCuaHang, SoDTKhachHang, DiaChiEmail, DiaChiNhanHang) values (4, 3, 'Leyla Lease', 'Western Union Company (The)', '9181605246', 'llease3@jalbum.net', '8 Mitchell Circle');
insert into KHACHHANG (MaKhachHang, MaKhuVuc, TenKhachHang, TenCuaHang, SoDTKhachHang, DiaChiEmail, DiaChiNhanHang) values (5, 4, 'Marillin Barbier', 'Foundation Medicine, Inc.', '6144279508', 'mbarbier4@surveymonkey.com', '7 Cordelia Plaza');

create table DONHANG_GIAOHANG (
	MaDonHangGiaoHang INT PRIMARY KEY,
	MaKhachHang INT,
	MaThanhVienGiaoHang INT,
	MaDichVu INT,
	MaKhuVucGiaoHang INT,
	TenNguoiNhan VARCHAR(50),
	DiaChiGiaoHang VARCHAR(50),
	SoDTNguoiNhan VARCHAR(50),
	MaKhoangThoiGianGiaoHang INT,
	NgayGiaoHang DATE,
	PhuongThucThanhToan VARCHAR(50),
	TrangThaiPheDuyet VARCHAR(50),
	TrangThaiGiaoHang VARCHAR(50),
	FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang) ON DELETE CASCADE,
	FOREIGN KEY (MaThanhVienGiaoHang) REFERENCES ThanhVienGiaoHang(MaThanhVienGiaoHang)  ON DELETE NO ACTION,
	FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu) ON DELETE NO ACTION,
	FOREIGN KEY (MaKhuVucGiaoHang) REFERENCES KhuVuc(MaKhuVuc) ON DELETE SET NULL,
	FOREIGN KEY (MaKhoangThoiGianGiaoHang) REFERENCES KhoangThoiGian(MaKhoangThoiGianGiaoHang) ON DELETE NO ACTION
);
insert into DONHANG_GIAOHANG (MaDonHangGiaoHang, MaKhachHang, MaThanhVienGiaoHang, MaDichVu, MaKhuVucGiaoHang, TenNguoiNhan, DiaChiGiaoHang, SoDTNguoiNhan, MaKhoangThoiGianGiaoHang, NgayGiaoHang, PhuongThucThanhToan, TrangThaiPheDuyet, TrangThaiGiaoHang) values (1, 5, 3, 4, 4, 'Jodi Porritt', '974 Graceland Lane', '5867329125', 2, '2016-12-19', 'EUR', 'M', 'XS');
insert into DONHANG_GIAOHANG (MaDonHangGiaoHang, MaKhachHang, MaThanhVienGiaoHang, MaDichVu, MaKhuVucGiaoHang, TenNguoiNhan, DiaChiGiaoHang, SoDTNguoiNhan, MaKhoangThoiGianGiaoHang, NgayGiaoHang, PhuongThucThanhToan, TrangThaiPheDuyet, TrangThaiGiaoHang) values (2, 4, 5, 2, 3, 'Abbey Sacks', '12094 Porter Terrace', '6172773210', 2, '2019-11-30', 'UAH', 'M', 'S');
insert into DONHANG_GIAOHANG (MaDonHangGiaoHang, MaKhachHang, MaThanhVienGiaoHang, MaDichVu, MaKhuVucGiaoHang, TenNguoiNhan, DiaChiGiaoHang, SoDTNguoiNhan, MaKhoangThoiGianGiaoHang, NgayGiaoHang, PhuongThucThanhToan, TrangThaiPheDuyet, TrangThaiGiaoHang) values (3, 1, 4, 4, 5, 'Alyson Kaiser', '558 Upham Parkway', '6863872335', 3, '2016-3-31', 'NGN', 'F', '2XL');
insert into DONHANG_GIAOHANG (MaDonHangGiaoHang, MaKhachHang, MaThanhVienGiaoHang, MaDichVu, MaKhuVucGiaoHang, TenNguoiNhan, DiaChiGiaoHang, SoDTNguoiNhan, MaKhoangThoiGianGiaoHang, NgayGiaoHang, PhuongThucThanhToan, TrangThaiPheDuyet, TrangThaiGiaoHang) values (4, 4, 5, 4, 3, 'Orelia Eyton', '5 Kipling Pass', '3512891538', 2, '2020-10-28', 'COP', 'F', 'XS');
insert into DONHANG_GIAOHANG (MaDonHangGiaoHang, MaKhachHang, MaThanhVienGiaoHang, MaDichVu, MaKhuVucGiaoHang, TenNguoiNhan, DiaChiGiaoHang, SoDTNguoiNhan, MaKhoangThoiGianGiaoHang, NgayGiaoHang, PhuongThucThanhToan, TrangThaiPheDuyet, TrangThaiGiaoHang) values (5, 2, 2, 5, 2, 'Abbi McCaskill', '98223 Forest Dale Circle', '9097084635', 3, '2017-7-14', 'LBP', 'F', 'L');

create table CHITIET_DONHANG (
	MaDonHangGiaoHang INT,
	TenSanPhamDuocGiao VARCHAR(50),
	SoLuong INT,
	`TrongLuong (Kg)` DECIMAL(3,2),
	MaLoaiMatHang INT,
	`TienThuHo (VND)` INT,
	FOREIGN KEY (MaDonHangGiaoHang) REFERENCES DonHang_GiaoHang(MaDonHangGiaoHang) ON DELETE CASCADE,
    FOREIGN KEY (MaLoaiMatHang) REFERENCES LoaiMatHang(MaLoaiMatHang) ON DELETE NO ACTION
);
insert into CHITIET_DONHANG (MaDonHangGiaoHang, TenSanPhamDuocGiao, SoLuong, `TrongLuong (Kg)`, MaLoaiMatHang, `TienThuHo (VND)`) values (2, 'Lime Cordial - Roses', 1, 0.69, 3, 1005016);
insert into CHITIET_DONHANG (MaDonHangGiaoHang, TenSanPhamDuocGiao, SoLuong, `TrongLuong (Kg)`, MaLoaiMatHang, `TienThuHo (VND)`) values (3, 'French Pastries', 2, 0.5, 3, 1413057);
insert into CHITIET_DONHANG (MaDonHangGiaoHang, TenSanPhamDuocGiao, SoLuong, `TrongLuong (Kg)`, MaLoaiMatHang, `TienThuHo (VND)`) values (3, 'Water - Spring 1.5lit', 1, 0.08, 2, 1804692);
insert into CHITIET_DONHANG (MaDonHangGiaoHang, TenSanPhamDuocGiao, SoLuong, `TrongLuong (Kg)`, MaLoaiMatHang, `TienThuHo (VND)`) values (5, 'Sugar - Crumb', 5, 0.76, 4, 1911187);
insert into CHITIET_DONHANG (MaDonHangGiaoHang, TenSanPhamDuocGiao, SoLuong, `TrongLuong (Kg)`, MaLoaiMatHang, `TienThuHo (VND)`) values (4, 'Oranges - Navel, 72', 4, 0.31, 2, 1721282);

COMMIT;

-- Câu 1: Xóa những khách hàng có tên là “Le Thi A”.
DELETE FROM khachhang WHERE TenKhachHang = 'Leyla Lease';

-- Câu 2: Cập nhật những khách hàng đang thường trú ở khu vực “Son Tra” thành khu vực “Ngu Hanh Son”.
UPDATE khachhang
SET MaKhuVuc = (SELECT MaKhuVuc FROM khuvuc WHERE TenKhuVuc = 'Ngu Hanh Son')
WHERE MaKhuVuc = (SELECT MaKhuVuc FROM khuvuc WHERE TenKhuVuc = 'Son Tra');

-- Câu 3: Liệt kê những thành viên (shipper) có họ tên bắt đầu là ký tự ‘Tr’ và có độ dài ít nhất là 25 ký tự (kể cả ký tự trắng).
SELECT * FROM thanhviengiaohang WHERE TenThanhVienGiaoHang LIKE 'Tr%' AND char_length(TenThanhVienGiaoHang) >= 25;

-- Câu 4: Liệt kê những đơn hàng có NgayGiaoHang nằm trong năm 2017 và có khu vực giao hàng là “Hai Chau”.
SELECT * FROM donhang_giaohang WHERE year(NgayGiaoHang) = 2017 AND MaKhuVucGiaoHang = (SELECT MaKhuVuc FROM khuvuc WHERE TenKhuVuc = 'Hai Chau');

/* Câu 5: Liệt kê MaDonHangGiaoHang, MaThanhVienGiaoHang, TenThanhVienGiaoHang,
NgayGiaoHang, PhuongThucThanhToan của tất cả những đơn hàng có trạng thái là “Da giao
hang”. Kết quả hiển thị được sắp xếp tăng dần theo NgayGiaoHang và giảm dần theo
PhuongThucThanhToan */
SELECT MaDonHangGiaoHang, D.MaThanhVienGiaoHang, TenThanhVienGiaoHang, NgayGiaoHang, PhuongThucThanhToan
FROM donhang_giaohang D
LEFT JOIN thanhviengiaohang T ON D.MaThanhVienGiaoHang = T.MaThanhVienGiaoHang
WHERE TrangThaiGiaoHang = 'Da giao hang'
ORDER BY NgayGiaoHang ASC, PhuongThucThanhToan DESC;

-- Câu 6: Liệt kê những thành viên có giới tính là “Nam” và chưa từng được giao hàng lần nào.
SELECT * FROM thanhviengiaohang T
LEFT JOIN donhang_giaohang D ON T.MaThanhVienGiaoHang = D.MaThanhVienGiaoHang
WHERE GioiTinh = 'Nam' AND D.MaThanhVienGiaoHang IS NULL;

/* Câu 7: Liệt kê họ tên của những khách hàng đang có trong hệ thống. Nếu họ tên trùng nhau
thì chỉ hiển thị 1 lần. Học viên cần thực hiện yêu cầu này bằng 2 cách khác nhau (mỗi cách
được tính 0.5 điểm) */
SELECT DISTINCT TenKhachHang FROM khachhang;
SELECT TenKhachHang FROM khachhang GROUP BY TenKhachHang;

/* Câu 8: Liệt kê MaKhachHang, TenKhachHang, DiaChiNhanHang, MaDonHangGiaoHang,
PhuongThucThanhToan, TrangThaiGiaoHang của tất cả các khách hàng đang có trong hệ thống */
SELECT K.MaKhachHang, TenKhachHang, DiaChiNhanHang, MaDonHangGiaoHang, PhuongThucThanhToan, TrangThaiGiaoHang
FROM khachhang K LEFT JOIN donhang_giaohang D ON K.MaKhachHang = D.MaKhachHang;

/* Câu 9: Liệt kê những thành viên giao hàng có giới tính là “Nu” và từng giao hàng cho 10
khách hàng khác nhau ở khu vực giao hàng là “Hai Chau” */
WITH D AS (
	SELECT MaThanhVienGiaoHang, count(DISTINCT MaKhachHang) AS C
    FROM donhang_giaohang
    WHERE MaKhuVucGiaoHang = (SELECT MaKhuVuc FROM khuvuc WHERE TenKhuVuc = 'Hai Chau')
    GROUP BY MaThanhVienGiaoHang
)
SELECT * FROM thanhviengiaohang T
JOIN D ON T.MaThanhVienGiaoHang = D.MaThanhVienGiaoHang
WHERE GioiTinh = 'Nu' AND C >= 10;

/* Câu 10: Liệt kê những khách hàng đã từng yêu cầu giao hàng tại khu vực “Lien Chieu” và
chưa từng được một thành viên giao hàng nào có giới tính là “Nam” nhận giao hàng */
SELECT * FROM khachhang WHERE MaKhachHang IN
(SELECT MaKhachHang FROM donhang_giaohang
WHERE MaKhuVucGiaoHang = (SELECT MaKhuVuc FROM khuvuc WHERE TenKhuVuc = 'Lien Chieu'))
AND MaKhachHang NOT IN
(SELECT MaKhachHang FROM donhang_giaohang D
JOIN thanhviengiaohang T ON D.MaThanhVienGiaoHang = T.MaThanhVienGiaoHang
WHERE GioiTinh = 'Nam');

ROLLBACK;