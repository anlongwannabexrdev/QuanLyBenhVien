USE BaiTapLonDB;
GO

IF OBJECT_ID('sp_BaoCaoThongKeTongHop', 'P') IS NOT NULL
    DROP PROCEDURE sp_BaoCaoThongKeTongHop;
GO

CREATE PROCEDURE sp_BaoCaoThongKeTongHop
    @LoaiBaoCao NVARCHAR(20),      -- 'THANG', 'NAM', 'BENHNHAN'
    @Nam INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️ Báo cáo doanh thu theo tháng
    IF @LoaiBaoCao = 'THANG'
    BEGIN
        SELECT 
            MONTH(dt.NgayKeDon) AS Thang,
            SUM(hd.TongTien) AS TongDoanhThu,
            COUNT(hd.MaHD) AS SoHoaDon
        FROM HoaDonVienPhi hd
        JOIN BenhNhan bn ON hd.MaBN = bn.MaBN
        LEFT JOIN DonThuoc dt ON dt.MaBN = bn.MaBN
        WHERE YEAR(dt.NgayKeDon) = @Nam
        GROUP BY MONTH(dt.NgayKeDon)
        ORDER BY Thang;
        RETURN;
    END

    -- 2️ Báo cáo doanh thu theo năm
    IF @LoaiBaoCao = 'NAM'
    BEGIN
        SELECT 
            YEAR(dt.NgayKeDon) AS Nam,
            SUM(hd.TongTien) AS TongDoanhThu,
            COUNT(hd.MaHD) AS SoHoaDon
        FROM HoaDonVienPhi hd
        JOIN BenhNhan bn ON hd.MaBN = bn.MaBN
        LEFT JOIN DonThuoc dt ON dt.MaBN = bn.MaBN
        GROUP BY YEAR(dt.NgayKeDon)
        ORDER BY Nam;
        RETURN;
    END

    -- 3️ Báo cáo chi tiết bệnh nhân (số hóa đơn, tổng chi phí)
    IF @LoaiBaoCao = 'BENHNHAN'
    BEGIN
        SELECT 
            bn.MaBN,
            bn.HoTen,
            COUNT(hd.MaHD) AS SoHoaDon,
            SUM(hd.TongTien) AS TongChiPhi
        FROM HoaDonVienPhi hd
        JOIN BenhNhan bn ON hd.MaBN = bn.MaBN
        GROUP BY bn.MaBN, bn.HoTen
        ORDER BY TongChiPhi DESC;
        RETURN;
    END

    RAISERROR(N'Loại báo cáo không hợp lệ! Dùng THANG, NAM hoặc BENHNHAN.', 16, 1);
END;
GO
