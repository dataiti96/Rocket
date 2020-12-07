DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

CREATE TABLE Khoa (
	makhoa char(10) PRIMARY KEY,
    tenkhoa char(30),
    dienthoai char(10)
);

insert into Khoa (makhoa, tenkhoa, dienthoai) values (1, 'DIALY', '6147092793');
insert into Khoa (makhoa, tenkhoa, dienthoai) values (2, 'QLTN', '2344369879');
insert into Khoa (makhoa, tenkhoa, dienthoai) values (3, 'CONG NGHE SINH HOC', '5152697562');
insert into Khoa (makhoa, tenkhoa, dienthoai) values (4, 'TOAN', '9822334821');

CREATE TABLE GiangVien (
	magv int PRIMARY KEY,
    hotengv char(30),
    luong decimal(5,2),
    makhoa char(10),
    FOREIGN KEY (makhoa) REFERENCES Khoa(makhoa)
);

insert into GiangVien (magv, hotengv, luong, makhoa) values (1, 'Cathrin Wolfart', '989.67', 3);
insert into GiangVien (magv, hotengv, luong, makhoa) values (2, 'Lombard Westbrook', '507.78', 2);
insert into GiangVien (magv, hotengv, luong, makhoa) values (3, 'Aguistin Crackett', '686.01', 4);
insert into GiangVien (magv, hotengv, luong, makhoa) values (4, 'Constantin Keymar', '715.50', 1);
insert into GiangVien (magv, hotengv, luong, makhoa) values (5, 'Goldi Chree', '387.64', 2);
insert into GiangVien (magv, hotengv, luong, makhoa) values (6, 'Zorah de Wilde', '319.23', 4);
insert into GiangVien (magv, hotengv, luong, makhoa) values (7, 'Tran son', '754.61', 3);
insert into GiangVien (magv, hotengv, luong, makhoa) values (8, 'Shellie Minihan', '865.57', 1);
insert into GiangVien (magv, hotengv, luong, makhoa) values (9, 'Dalenna Greenslade', '417.50', 4);
insert into GiangVien (magv, hotengv, luong, makhoa) values (10, 'Gherardo Breming', '596.65', 2);

CREATE TABLE SinhVien (
	masv int PRIMARY KEY,
    hotensv char(30),
    makhoa char(10),
    namsinh int,
    quequan char(30),
    FOREIGN KEY (makhoa) REFERENCES Khoa(makhoa)
);

insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (1, 'Dominic Barthrup', 4, 1994, 'Philippines');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (2, 'Carline Romagosa', 3, 1991, 'Russia');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (3, 'Lionello Messruther', 3, 1994, 'Thailand');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (4, 'Valentine Richardes', 1, 1990, 'Pakistan');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (5, 'Sigismond Ariss', 1, 1992, 'China');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (6, 'Vlad Lodo', 3, 1990, 'Tanzania');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (7, 'Filbert Ashness', 2, 1994, 'Portugal');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (8, 'Le van son', 1, 2000, 'Vietnam');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (9, 'Suzanna Gadney', 4, 1991, 'France');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (10, 'Mikol Frend', 2, 1996, 'Philippines');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (11, 'Allan Clayill', 2, 1995, 'China');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (12, 'Angelika Fishpool', 1, 1994, 'Portugal');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (13, 'Lezley Kezor', 1, 1999, 'China');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (14, 'Cy Puddan', 2, 1996, 'Sweden');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (15, 'Codie Caustick', 1, 1990, 'China');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (16, 'Symon Jeacop', 2, 1991, 'China');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (17, 'Louisa Melonby', 2, 1994, 'China');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (18, 'Alecia Lantiff', 1, 1991, 'China');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (19, 'Otha Goodinson', 1, 1997, 'Serbia');
insert into SinhVien (masv, hotensv, makhoa, namsinh, quequan) values (20, 'Granny Yerson', 2, 1993, 'Canada');

CREATE TABLE DeTai (
	madt char(10) PRIMARY KEY,
    tendt char(30),
    kinhphi int,
    NoiThucTap char(30)
);

insert into DeTai (madt, tendt, kinhphi, NoiThucTap) values (1, 'Hoppe Group', 709, 'Japan');
insert into DeTai (madt, tendt, kinhphi, NoiThucTap) values (2, 'Romaguera LLC', 518, 'Czech Republic');
insert into DeTai (madt, tendt, kinhphi, NoiThucTap) values (3, 'Nolan and Sons', 960, 'China');
insert into DeTai (madt, tendt, kinhphi, NoiThucTap) values (4, 'Moore, Erdman and Dare', 784, 'Russia');
insert into DeTai (madt, tendt, kinhphi, NoiThucTap) values (5, 'Gibson Group', 798, 'Mexico');
insert into DeTai (madt, tendt, kinhphi, NoiThucTap) values (6, 'Heathcote, Herman and Fahey', 703, 'Ukraine');
insert into DeTai (madt, tendt, kinhphi, NoiThucTap) values (7, 'Ferry-Baumbach', 724, 'Czech Republic');
insert into DeTai (madt, tendt, kinhphi, NoiThucTap) values (8, 'Stehr Group', 796, 'Philippines');
insert into DeTai (madt, tendt, kinhphi, NoiThucTap) values (9, 'Schneider-Graham', 967, 'Indonesia');
insert into DeTai (madt, tendt, kinhphi, NoiThucTap) values (10, 'Hudson-McCullough', 568, 'Vietnam');

CREATE TABLE HuongDan (
	masv int,
    madt char(10),
    magv int,
    ketqua decimal(5,2),
    FOREIGN KEY (masv) REFERENCES SinhVien(masv),
    FOREIGN KEY (madt) REFERENCES DeTai(madt),
    FOREIGN KEY (magv) REFERENCES GiangVien(magv)
);

insert into HuongDan (masv, madt, magv, ketqua) values (20, 9, 9, '3.04');
insert into HuongDan (masv, madt, magv, ketqua) values (17, 1, 7, '2.27');
insert into HuongDan (masv, madt, magv, ketqua) values (15, 2, 10, '5.85');
insert into HuongDan (masv, madt, magv, ketqua) values (16, 8, 2, '0');
insert into HuongDan (masv, madt, magv, ketqua) values (4, 7, 9, '2.30');
insert into HuongDan (masv, madt, magv, ketqua) values (18, 5, 10, null);
insert into HuongDan (masv, madt, magv, ketqua) values (11, 1, 6, null);
insert into HuongDan (masv, madt, magv, ketqua) values (5, 6, 5, '4.76');
insert into HuongDan (masv, madt, magv, ketqua) values (1, 10, 9, '6.15');
insert into HuongDan (masv, madt, magv, ketqua) values (3, 2, 1, '0');
insert into HuongDan (masv, madt, magv, ketqua) values (7, 4, 1, '1.66');
insert into HuongDan (masv, madt, magv, ketqua) values (6, 9, 1, '1.45');
insert into HuongDan (masv, madt, magv, ketqua) values (9, 2, 3, '2.61');
insert into HuongDan (masv, madt, magv, ketqua) values (8, 10, 3, '6.75');

-- 2.	Đưa ra thông tin gồm mã số, họ tên và tên khoa của tất cả các giảng viên
SELECT G.MAGV, G.HOTENGV, K.TENKHOA
FROM GIANGVIEN G
LEFT JOIN KHOA K
ON G.MAKHOA = K.MAKHOA;

-- 3.	Đưa ra thông tin gồm mã số, họ tên và tên khoa của các giảng viên của khoa ‘DIALY va QLTN’
SELECT G.MAGV, G.HOTENGV, K.TENKHOA
FROM GIANGVIEN G
JOIN KHOA K
ON G.MAKHOA = K.MAKHOA
WHERE K.TENKHOA IN ('DIALY', 'QLTN');

-- 4.	Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’
SELECT count(1) AS `số sinh viên của khoa ‘CONG NGHE SINH HOC’`
FROM SINHVIEN S
JOIN KHOA K
ON S.MAKHOA = K.MAKHOA
WHERE K.TENKHOA = 'CONG NGHE SINH HOC';

-- 5.	Đưa ra danh sách gồm mã số, họ tên và tuổi của các sinh viên khoa ‘TOAN’
SELECT S.MASV, S.HOTENSV, (year(now()) - S.NAMSINH) AS TUOI, K.TENKHOA
FROM SINHVIEN S
JOIN KHOA K
ON S.MAKHOA = K.MAKHOA
WHERE K.TENKHOA = 'TOAN';

-- 6.	Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’
SELECT count(1) AS `số giảng viên của khoa ‘CONG NGHE SINH HOC’`
FROM GIANGVIEN G
JOIN KHOA K
ON G.MAKHOA = K.MAKHOA
WHERE K.TENKHOA = 'CONG NGHE SINH HOC';

-- 7.	Cho biết thông tin về sinh viên không tham gia thực tập
SELECT *
FROM SINHVIEN S
LEFT JOIN HUONGDAN H
ON S.MASV = H.MASV
WHERE H.MASV IS NULL;

-- 8.	Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
SELECT K.MAKHOA, K.TENKHOA, count(G.MAGV) AS `số giảng viên`
FROM KHOA K
LEFT JOIN GIANGVIEN G
ON K.MAKHOA = G.MAKHOA
GROUP BY K.MAKHOA;

-- 9.	Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
SELECT K.TENKHOA, K.DIENTHOAI, S.HOTENSV
FROM KHOA K
JOIN SINHVIEN S
ON K.MAKHOA = S.MAKHOA
WHERE S.HOTENSV = 'Le van son';

-- 10.	Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
SELECT D.MADT, D.TENDT, G.HOTENGV
FROM DETAI D
JOIN GIANGVIEN G
JOIN HUONGDAN H
ON D.MADT = H.MADT
AND G.MAGV = H.MAGV
WHERE G.HOTENGV = 'Tran son';

-- 11.	Cho biết tên đề tài không có sinh viên nào thực tập
SELECT D.TENDT, H.MASV
FROM DETAI D
LEFT JOIN HUONGDAN H
ON D.MADT = H.MADT
WHERE H.MASV IS NULL;

-- 12.	Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
WITH A AS (
SELECT MAGV, count(MASV) AS `SO SVHD`
FROM HUONGDAN
GROUP BY MAGV
)
SELECT G.MAGV, G.HOTENGV, K.TENKHOA, A.`SO SVHD`
FROM GIANGVIEN G
LEFT JOIN KHOA K
ON G.MAKHOA = K.MAKHOA
JOIN A
ON G.MAGV = A.MAGV
WHERE A.`SO SVHD` >= 3;

-- 13.	Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
SELECT MADT, TENDT, KINHPHI
FROM DETAI
WHERE KINHPHI = (SELECT max(KINHPHI) FROM DETAI);

-- 14.	Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
WITH A AS (
SELECT MADT, count(MASV) AS `SO SVTG`
FROM HUONGDAN
GROUP BY MADT
)
SELECT D.MADT, D.TENDT, A.`SO SVTG`
FROM DETAI D
JOIN A
ON D.MADT = A.MADT
WHERE A.`SO SVTG` > 2;

-- 15.	Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
SELECT S.MASV, S.HOTENSV, IF(H.MASV IS NULL, 'KTT', ifnull(H.KETQUA, 'CCD')) AS KETQUA, K.TENKHOA
FROM SINHVIEN S
JOIN KHOA K
ON S.MAKHOA = K.MAKHOA
LEFT JOIN HUONGDAN H
ON S.MASV = H.MASV
WHERE K.TENKHOA IN ('DIALY', 'QLTN');

-- 16.	Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
SELECT K.TENKHOA, count(1) AS `số lượng sinh viên`
FROM KHOA K
LEFT JOIN SINHVIEN S
ON K.MAKHOA = S.MAKHOA
GROUP BY K.MAKHOA;

-- 17.	Cho biết thông tin về các sinh viên thực tập tại quê nhà
SELECT *
FROM SINHVIEN S
JOIN DETAI D
JOIN HUONGDAN H
ON S.MASV = H.MASV
AND D.MADT = H.MADT
WHERE S.QUEQUAN = D.NOITHUCTAP;

-- 18.	Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
SELECT *
FROM SINHVIEN S
LEFT JOIN HUONGDAN H
ON S.MASV = H.MASV
WHERE H.KETQUA IS NULL;

-- 19.	Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
SELECT S.MASV, S.HOTENSV, H.KETQUA
FROM SINHVIEN S
JOIN HUONGDAN H
ON S.MASV = H.MASV
WHERE H.KETQUA = 0;