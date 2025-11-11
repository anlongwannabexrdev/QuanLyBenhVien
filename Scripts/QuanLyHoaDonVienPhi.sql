USE BaiTapLonDB;
GO

IF OBJECT_ID('v_HoaDonVienPhi_Detail', 'V') IS NOT NULL
    DROP VIEW v_HoaDonVienPhi_Detail;
GO

-- Tạo view hiển thị thông tin chi tiết hóa đơn
CREATE VIEW v_HoaDonVienPhi_Detail
AS
SELECT 
    hd.MaHD,
    hd.MaBN,
    bn.HoTen AS TenBenhNhan,
    hd.PhiThuoc,
    hd.PhiKham,
    hd.PhiPhatSinh,
    hd.TongTien
FROM HoaDonVienPhi hd
JOIN BenhNhan bn ON hd.MaBN = bn.MaBN;
GO


IF OBJECT_ID('sp_QuanLyHoaDonVienPhi', 'P') IS NOT NULL
    DROP PROCEDURE sp_QuanLyHoaDonVienPhi;
GO

-- Tạo procedure quản lý hóa đơn sử dụng view
CREATE PROCEDURE sp_QuanLyHoaDonVienPhi
    @Action NVARCHAR(10),             -- 'INSERT', 'UPDATE', 'DELETE', 'VIEW', 'SEARCH'
    @MaHD INT = NULL,
    @MaBN INT = NULL,
    @PhiThuoc MONEY = NULL,
    @PhiKham MONEY = NULL,
    @PhiPhatSinh MONEY = NULL,
    @TuKhoa NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️ Thêm hóa đơn mới
    IF @Action = 'INSERT'
    BEGIN
        IF @MaBN IS NULL
        BEGIN
            RAISERROR(N'Cần nhập mã bệnh nhân để tạo hóa đơn.', 16, 1);
            RETURN;
        END

        INSERT INTO HoaDonVienPhi (MaBN, PhiThuoc, PhiKham, PhiPhatSinh)
        VALUES (@MaBN, ISNULL(@PhiThuoc, 0), ISNULL(@PhiKham, 0), ISNULL(@PhiPhatSinh, 0));

        DECLARE @NewID INT = SCOPE_IDENTITY();
        PRINT N'Tạo hóa đơn thành công, mã hóa đơn: ' + CAST(@NewID AS NVARCHAR);
        RETURN;
    END

    -- 2️ Cập nhật hóa đơn
    ELSE IF @Action = 'UPDATE'
    BEGIN
        IF @MaHD IS NULL
        BEGIN
            RAISERROR(N'Cần nhập mã hóa đơn để cập nhật.', 16, 1);
            RETURN;
        END

        UPDATE HoaDonVienPhi
        SET PhiThuoc = ISNULL(@PhiThuoc, PhiThuoc),
            PhiKham = ISNULL(@PhiKham, PhiKham),
            PhiPhatSinh = ISNULL(@PhiPhatSinh, PhiPhatSinh)
        WHERE MaHD = @MaHD;

        PRINT N'Cập nhật hóa đơn thành công.';
        RETURN;
    END

    -- 3️ Xóa hóa đơn
    ELSE IF @Action = 'DELETE'
    BEGIN
        IF @MaHD IS NULL
        BEGIN
            RAISERROR(N'Cần nhập mã hóa đơn để xóa.', 16, 1);
            RETURN;
        END

        DELETE FROM HoaDonVienPhi WHERE MaHD = @MaHD;

        PRINT N'Đã xóa hóa đơn thành công.';
        RETURN;
    END

    -- 4️ Xem toàn bộ hóa đơn (dùng view)
    ELSE IF @Action = 'VIEW'
    BEGIN
        SELECT *
        FROM v_HoaDonVienPhi_Detail
        ORDER BY MaHD DESC;
        RETURN;
    END

    -- 5️ Tìm kiếm theo tên bệnh nhân (dùng view)
    ELSE IF @Action = 'SEARCH'
    BEGIN
        IF @TuKhoa IS NULL
        BEGIN
            RAISERROR(N'Vui lòng nhập từ khóa tìm kiếm.', 16, 1);
            RETURN;
        END

        SELECT *
        FROM v_HoaDonVienPhi_Detail
        WHERE TenBenhNhan LIKE N'%' + @TuKhoa + N'%'
        ORDER BY MaHD DESC;
        RETURN;
    END

    ELSE
        RAISERROR(N'Hành động không hợp lệ! Dùng INSERT, UPDATE, DELETE, VIEW hoặc SEARCH.', 16, 1);
END;
GO
