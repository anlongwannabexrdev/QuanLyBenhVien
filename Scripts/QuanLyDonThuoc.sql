USE BaiTapLonDB;
GO

IF OBJECT_ID('sp_QuanLyDonThuoc', 'P') IS NOT NULL
    DROP PROCEDURE sp_QuanLyDonThuoc;
GO

CREATE PROCEDURE sp_QuanLyDonThuoc
    @Action NVARCHAR(10),              -- 'INSERT', 'UPDATE', 'DELETE', 'VIEW', 'SEARCH'
    @MaDT INT = NULL,
    @MaNV_BacSi INT = NULL,
    @MaNV_DuocSi INT = NULL,
    @MaBN INT = NULL,
    @NgayKeDon DATE = NULL,
    @MaThuoc INT = NULL,
    @SoLuong INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️. Thêm đơn thuốc mới
    
    IF @Action = 'INSERT'
    BEGIN
        IF @MaNV_BacSi IS NULL OR @MaNV_DuocSi IS NULL OR @MaBN IS NULL
        BEGIN
            RAISERROR(N'Vui lòng nhập đầy đủ Mã bác sĩ, dược sĩ và bệnh nhân!', 16, 1);
            RETURN;
        END

        INSERT INTO DonThuoc (MaNV_BacSi, MaNV_DuocSi, MaBN, NgayKeDon)
        VALUES (@MaNV_BacSi, @MaNV_DuocSi, @MaBN, ISNULL(@NgayKeDon, GETDATE()));

        DECLARE @NewID INT = SCOPE_IDENTITY();
        PRINT N'Tạo đơn thuốc mới thành công! Mã đơn thuốc: ' + CAST(@NewID AS NVARCHAR);

        -- Nếu có thuốc kèm theo thì thêm luôn vào chi tiết
        IF @MaThuoc IS NOT NULL AND @SoLuong IS NOT NULL
        BEGIN
            INSERT INTO DonThuoc_ChiTiet (MaDT, MaThuoc, SoLuong)
            VALUES (@NewID, @MaThuoc, @SoLuong);
            PRINT N'Đã thêm thuốc đầu tiên vào đơn.';
        END
        RETURN;
    END

    -- 2️. Cập nhật số lượng thuốc trong đơn

    IF @Action = 'UPDATE'
    BEGIN
        IF @MaDT IS NULL OR @MaThuoc IS NULL
        BEGIN
            RAISERROR(N'Cần nhập Mã đơn thuốc và Mã thuốc để cập nhật!', 16, 1);
            RETURN;
        END

        UPDATE DonThuoc_ChiTiet
        SET SoLuong = ISNULL(@SoLuong, SoLuong)
        WHERE MaDT = @MaDT AND MaThuoc = @MaThuoc;

        PRINT N'Cập nhật đơn thuốc thành công!';
        RETURN;
    END

    -- 3️. Xóa đơn thuốc hoặc chi tiết
    
    IF @Action = 'DELETE'
    BEGIN
        IF @MaDT IS NULL
        BEGIN
            RAISERROR(N'Cần nhập Mã đơn thuốc để xóa!', 16, 1);
            RETURN;
        END

        -- Xóa chi tiết trước
        DELETE FROM DonThuoc_ChiTiet WHERE MaDT = @MaDT;

        -- Rồi xóa đơn chính
        DELETE FROM DonThuoc WHERE MaDT = @MaDT;

        PRINT N'Đã xóa đơn thuốc và toàn bộ chi tiết!';
        RETURN;
    END

    -- 4️. Xem toàn bộ đơn thuốc

    IF @Action = 'VIEW'
    BEGIN
        SELECT 
            dt.MaDT,
            bn.HoTen AS TenBenhNhan,
            bs.MaNV AS MaBacSi,
            nv1.HoTen AS TenBacSi,
            ds.MaNV AS MaDuocSi,
            nv2.HoTen AS TenDuocSi,
            dt.NgayKeDon,
            t.TenThuoc,
            ct.SoLuong,
            t.GiaThuoc,
            (ct.SoLuong * t.GiaThuoc) AS ThanhTien
        FROM DonThuoc dt
        JOIN BenhNhan bn ON dt.MaBN = bn.MaBN
        JOIN BacSi bs ON dt.MaNV_BacSi = bs.MaNV
        JOIN DuocSi ds ON dt.MaNV_DuocSi = ds.MaNV
        JOIN NhanVien nv1 ON bs.MaNV = nv1.MaNV
        JOIN NhanVien nv2 ON ds.MaNV = nv2.MaNV
        JOIN DonThuoc_ChiTiet ct ON dt.MaDT = ct.MaDT
        JOIN Thuoc t ON ct.MaThuoc = t.MaThuoc
        ORDER BY dt.NgayKeDon DESC;
        RETURN;
    END

    -- 5️. Tìm kiếm theo tên bệnh nhân hoặc bác sĩ

    IF @Action = 'SEARCH'
    BEGIN
        SELECT 
            dt.MaDT, bn.HoTen AS TenBenhNhan, nv1.HoTen AS TenBacSi, nv2.HoTen AS TenDuocSi,
            dt.NgayKeDon
        FROM DonThuoc dt
        JOIN BenhNhan bn ON dt.MaBN = bn.MaBN
        JOIN BacSi bs ON dt.MaNV_BacSi = bs.MaNV
        JOIN DuocSi ds ON dt.MaNV_DuocSi = ds.MaNV
        JOIN NhanVien nv1 ON bs.MaNV = nv1.MaNV
        JOIN NhanVien nv2 ON ds.MaNV = nv2.MaNV
        WHERE bn.HoTen LIKE N'%' + ISNULL(@TenThuoc, '') + '%'
           OR nv1.HoTen LIKE N'%' + ISNULL(@TenThuoc, '') + '%'
        ORDER BY dt.NgayKeDon DESC;
        RETURN;
    END

    RAISERROR(N'Hành động không hợp lệ! Hãy dùng INSERT, UPDATE, DELETE, VIEW, hoặc SEARCH.', 16, 1);
END;
GO
