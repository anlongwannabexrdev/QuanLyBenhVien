USE BaiTapLonDB;
GO

DELETE FROM PhongBenh;

INSERT INTO PhongBenh (LoaiPhong, GiaPhong)
VALUES
(N'Nội tổng quát', 500000),
(N'Ngoại tổng quát', 600000),
(N'Sản khoa', 700000),
(N'Nhi khoa', 550000),
(N'Tim mạch', 750000),
(N'Thần kinh', 800000);
GO
