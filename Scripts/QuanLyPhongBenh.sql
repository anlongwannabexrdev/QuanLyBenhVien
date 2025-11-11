USE BaiTapLonDB;
GO

IF OBJECT_ID('v_PhongBenh_Detail', 'V') IS NOT NULL
    DROP VIEW v_PhongBenh_Detail;
GO

-- Tạo view hiển thị thông tin chi tiết phòng
CREATE VIEW v_PhongBenh_Detail
AS
SELECT 
    pb.MaPhong,
    pb.LoaiPhong,
    pb.GiaPhong,
    ISNULL(COUNT(bn.MaBN), 0) AS SoBenhNhanDangNam,
    10 - ISNULL(COUNT(bn.MaBN), 0) AS SoGiuongTrong  -- giả định mỗi phòng có 10 giường
FROM PhongBenh pb
LEFT JOIN DieuDuong_PhongBenh dp ON pb.MaPhong = dp.MaPhong
LEFT JOIN BenhNhan bn ON dp.MaNV IS NOT NULL
GROUP BY pb.MaPhong, pb.LoaiPhong, pb.GiaPhong;
GO


IF OBJECT_ID('sp_QuanLyPhongBenh', 'P') IS NOT NULL
    DROP PROCEDURE sp_QuanLyPhongBenh;
GO

-- Tạo procedure quản lý phòng bệnh sử dụng view
CREATE PROCEDURE sp_QuanLyPhongBenh
    @Action NVARCHAR(10),              -- 'VIEW', 'SEARCH', 'TRONG', 'THONGKE'
    @TuKhoa NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️. Xem toàn bộ phòng (dùng view)
    IF @Action = 'VIEW'
    BEGIN
        SELECT * 
        FROM v_PhongBenh_Detail
        ORDER BY MaPhong;
        RETURN;
    END

    -- 2️. Tìm kiếm phòng theo loại (dùng view)
    ELSE IF @Action = 'SEARCH'
    BEGIN
        IF @TuKhoa IS NULL
        BEGIN
            RAISERROR(N'Vui lòng nhập từ khóa tìm kiếm.', 16, 1);
            RETURN;
        END

        SELECT * 
        FROM v_PhongBenh_Detail
        WHERE LoaiPhong LIKE N'%' + @TuKhoa + N'%'
        ORDER BY MaPhong;
        RETURN;
    END

    -- 3️.Kiểm tra phòng còn giường
    ELSE IF @Action = 'TRONG'
    BEGIN
        SELECT MaPhong, LoaiPhong, SoBenhNhanDangNam, SoGiuongTrong, GiaPhong
        FROM v_PhongBenh_Detail
        ORDER BY SoGiuongTrong DESC;
        RETURN;
    END

    -- 4️.Thống kê số giường đang sử dụng theo loại phòng
    ELSE IF @Action = 'THONGKE'
    BEGIN
        SELECT 
            LoaiPhong,
            SUM(SoBenhNhanDangNam) AS SoLuotSuDung,
            SUM(GiaPhong) AS TongGiaTriSuDung
        FROM v_PhongBenh_Detail
        GROUP BY LoaiPhong
        ORDER BY TongGiaTriSuDung DESC;
        RETURN;
    END

    ELSE
        RAISERROR(N'Hành động không hợp lệ! Hãy dùng VIEW, SEARCH, TRONG hoặc THONGKE.', 16, 1);
END;
GO
