USE BaiTapLonDB;
GO

IF OBJECT_ID('sp_QuanLyThuoc', 'P') IS NOT NULL
    DROP PROCEDURE sp_QuanLyThuoc;
GO

CREATE PROCEDURE sp_QuanLyThuoc
    @Action NVARCHAR(10),              -- 'INSERT', 'UPDATE', 'DELETE', 'VIEW', 'SEARCH'
    @MaThuoc INT = NULL,
    @TenThuoc NVARCHAR(100) = NULL,
    @HanSuDung DATE = NULL,
    @NhaSanXuat NVARCHAR(100) = NULL,
    @GiaThuoc MONEY = NULL,
    @SoLo NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️. Thêm mới thuốc

    IF @Action = 'INSERT'
    BEGIN
        IF @TenThuoc IS NULL OR @HanSuDung IS NULL OR @GiaThuoc IS NULL
        BEGIN
            RAISERROR(N'Tên thuốc, hạn sử dụng và giá thuốc không được để trống!', 16, 1);
            RETURN;
        END

        INSERT INTO Thuoc (TenThuoc, HanSuDung, NhaSanXuat, GiaThuoc, SoLo)
        VALUES (@TenThuoc, @HanSuDung, @NhaSanXuat, @GiaThuoc, @SoLo);

        PRINT N'Thêm thuốc mới thành công!';
        RETURN;
    END

    -- 2️. Cập nhật thông tin thuốc

    IF @Action = 'UPDATE'
    BEGIN
        IF @MaThuoc IS NULL
        BEGIN
            RAISERROR(N'Cần nhập Mã thuốc để cập nhật!', 16, 1);
            RETURN;
        END

        UPDATE Thuoc
        SET TenThuoc = ISNULL(@TenThuoc, TenThuoc),
            HanSuDung = ISNULL(@HanSuDung, HanSuDung),
            NhaSanXuat = ISNULL(@NhaSanXuat, NhaSanXuat),
            GiaThuoc = ISNULL(@GiaThuoc, GiaThuoc),
            SoLo = ISNULL(@SoLo, SoLo)
        WHERE MaThuoc = @MaThuoc;

        PRINT N'Cập nhật thông tin thuốc thành công!';
        RETURN;
    END

    -- 3️. Xóa thuốc khỏi danh mục

    IF @Action = 'DELETE'
    BEGIN
        IF @MaThuoc IS NULL
        BEGIN
            RAISERROR(N'Cần nhập Mã thuốc để xóa!', 16, 1);
            RETURN;
        END

        DELETE FROM Thuoc WHERE MaThuoc = @MaThuoc;
        PRINT N'Xóa thuốc thành công!';
        RETURN;
    END

    -- 4️. Xem danh sách thuốc

    IF @Action = 'VIEW'
    BEGIN
        SELECT 
            MaThuoc, TenThuoc, HanSuDung, NhaSanXuat, GiaThuoc, SoLo,
            CASE 
                WHEN HanSuDung < GETDATE() THEN N'Hết hạn'
                WHEN DATEDIFF(DAY, GETDATE(), HanSuDung) <= 30 THEN N'Sắp hết hạn'
                ELSE N'Còn hạn'
            END AS TrangThai
        FROM Thuoc
        ORDER BY HanSuDung ASC;
        RETURN;
    END

    -- 5️. Tìm kiếm thuốc theo tên / số lô / nhà sản xuất
 
    IF @Action = 'SEARCH'
    BEGIN
        SELECT * FROM Thuoc
        WHERE (@TenThuoc IS NULL OR TenThuoc LIKE '%' + @TenThuoc + '%')
           OR (@SoLo IS NULL OR SoLo LIKE '%' + @SoLo + '%')
           OR (@NhaSanXuat IS NULL OR NhaSanXuat LIKE '%' + @NhaSanXuat + '%');
        RETURN;
    END

    RAISERROR(N'Hành động không hợp lệ! Chỉ được dùng INSERT, UPDATE, DELETE, VIEW, hoặc SEARCH.', 16, 1);
END;
GO
