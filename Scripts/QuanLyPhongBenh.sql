USE BaiTapLonDB;
GO

IF OBJECT_ID('sp_QuanLyPhongBenh', 'P') IS NOT NULL
    DROP PROCEDURE sp_QuanLyPhongBenh;
GO

CREATE PROCEDURE sp_QuanLyPhongBenh
    @Action NVARCHAR(10),              -- 'VIEW', 'SEARCH', 'TRONG', 'THONGKE'
    @TuKhoa NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️ Xem toàn bộ phòng
    IF @Action = 'VIEW'
    BEGIN
        SELECT 
            MaPhong,
            LoaiPhong,
            GiaPhong
        FROM PhongBenh
        ORDER BY MaPhong;
        RETURN;
    END

    -- 2️ Tìm kiếm phòng theo loại
    IF @Action = 'SEARCH'
    BEGIN
        IF @TuKhoa IS NULL
        BEGIN
            RAISERROR(N'Vui lòng nhập từ khóa tìm kiếm.', 16, 1);
            RETURN;
        END

        SELECT 
            MaPhong,
            LoaiPhong,
            GiaPhong
        FROM PhongBenh
        WHERE LoaiPhong LIKE N'%' + @TuKhoa + N'%'
        ORDER BY MaPhong;
        RETURN;
    END

    -- 3️ Kiểm tra phòng còn giường (giả định mỗi phòng có 10 giường)
    IF @Action = 'TRONG'
    BEGIN
        SELECT 
            pb.MaPhong,
            pb.LoaiPhong,
            COUNT(bn.MaBN) AS SoBenhNhanDangNam,
            10 - COUNT(bn.MaBN) AS SoGiuongTrong,
            pb.GiaPhong
        FROM PhongBenh pb
        LEFT JOIN DieuDuong_PhongBenh dp ON pb.MaPhong = dp.MaPhong
        LEFT JOIN BenhNhan bn ON dp.MaNV IS NOT NULL  -- giả lập số bệnh nhân
        GROUP BY pb.MaPhong, pb.LoaiPhong, pb.GiaPhong
        ORDER BY SoGiuongTrong DESC;
        RETURN;
    END

    -- 4️ Thống kê số giường đang sử dụng theo loại phòng
    IF @Action = 'THONGKE'
    BEGIN
        SELECT 
            pb.LoaiPhong,
            COUNT(dp.MaPhong) AS SoLuotSuDung,
            SUM(pb.GiaPhong) AS TongGiaTriSuDung
        FROM PhongBenh pb
        LEFT JOIN DieuDuong_PhongBenh dp ON pb.MaPhong = dp.MaPhong
        GROUP BY pb.LoaiPhong
        ORDER BY TongGiaTriSuDung DESC;
        RETURN;
    END

    RAISERROR(N'Hành động không hợp lệ! Hãy dùng VIEW, SEARCH, TRONG hoặc THONGKE.', 16, 1);
END;
GO
