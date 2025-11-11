USE BaiTapLonDB;
GO


-- Tạo VIEW báo cáo theo tháng
IF OBJECT_ID('View_BaoCaoDoanhThuThang', 'V') IS NOT NULL
    DROP VIEW View_BaoCaoDoanhThuThang;
GO

CREATE VIEW View_BaoCaoDoanhThuThang AS
SELECT 
    YEAR(dt.NgayKeDon) AS Nam,
    MONTH(dt.NgayKeDon) AS Thang,
    SUM(hd.TongTien) AS TongDoanhThu,
    COUNT(hd.MaHD) AS SoHoaDon
FROM HoaDonVienPhi hd
JOIN BenhNhan bn ON hd.MaBN = bn.MaBN
LEFT JOIN DonThuoc dt ON dt.MaBN = bn.MaBN
GROUP BY YEAR(dt.NgayKeDon), MONTH(dt.NgayKeDon);
GO


-- Tạo VIEW báo cáo theo năm
IF OBJECT_ID('View_BaoCaoDoanhThuNam', 'V') IS NOT NULL
    DROP VIEW View_BaoCaoDoanhThuNam;
GO

CREATE VIEW View_BaoCaoDoanhThuNam AS
SELECT 
    YEAR(dt.NgayKeDon) AS Nam,
    SUM(hd.TongTien) AS TongDoanhThu,
    COUNT(hd.MaHD) AS SoHoaDon
FROM HoaDonVienPhi hd
JOIN BenhNhan bn ON hd.MaBN = bn.MaBN
LEFT JOIN DonThuoc dt ON dt.MaBN = bn.MaBN
GROUP BY YEAR(dt.NgayKeDon);
GO



-- Tạo VIEW báo cáo chi phí bệnh nhân
IF OBJECT_ID('View_BaoCaoBenhNhan', 'V') IS NOT NULL
    DROP VIEW View_BaoCaoBenhNhan;
GO

CREATE VIEW View_BaoCaoBenhNhan AS
SELECT 
    bn.MaBN,
    bn.HoTen,
    COUNT(hd.MaHD) AS SoHoaDon,
    SUM(hd.TongTien) AS TongChiPhi
FROM HoaDonVienPhi hd
JOIN BenhNhan bn ON hd.MaBN = bn.MaBN
GROUP BY bn.MaBN, bn.HoTen;
GO



-- Stored Procedure dùng View
IF OBJECT_ID('sp_BaoCaoThongKeTongHop', 'P') IS NOT NULL
    DROP PROCEDURE sp_BaoCaoThongKeTongHop;
GO

CREATE PROCEDURE sp_BaoCaoThongKeThongHop
    @LoaiBaoCao NVARCHAR(20),  -- 'THANG', 'NAM', 'BENHNHAN'
    @Nam INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @LoaiBaoCao = 'THANG'
    BEGIN
        SELECT Thang, TongDoanhThu, SoHoaDon
        FROM View_BaoCaoDoanhThuThang
        WHERE Nam = @Nam
        ORDER BY Thang;
        RETURN;
    END

    IF @LoaiBaoCao = 'NAM'
    BEGIN
        SELECT Nam, TongDoanhThu, SoHoaDon
        FROM View_BaoCaoDoanhThuNam
        ORDER BY Nam;
        RETURN;
    END

    IF @LoaiBaoCao = 'BENHNHAN'
    BEGIN
        SELECT *
        FROM View_BaoCaoBenhNhan
        ORDER BY TongChiPhi DESC;
        RETURN;
    END

    RAISERROR(N'Loại báo cáo không hợp lệ! Dùng THANG, NAM hoặc BENHNHAN.', 16, 1);
END;
GO