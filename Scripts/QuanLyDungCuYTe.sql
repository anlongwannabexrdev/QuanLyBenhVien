USE BaiTapLonDB;
GO

IF OBJECT_ID('v_DungCuYTe_Detail', 'V') IS NOT NULL
    DROP VIEW v_DungCuYTe_Detail;
GO

-- Tạo view hiển thị thông tin dụng cụ y tế
CREATE VIEW v_DungCuYTe_Detail
AS
SELECT 
    MaDC,
    TenDC,
    NhaSanXuat,
    GiaDC,
    SoLo,
    LoaiDC
FROM DungCuYTe;
GO


IF OBJECT_ID('sp_QuanLyDungCuYTe', 'P') IS NOT NULL
    DROP PROCEDURE sp_QuanLyDungCuYTe;
GO

-- Tạo lại procedure có sử dụng view
CREATE PROCEDURE sp_QuanLyDungCuYTe
    @Action NVARCHAR(10),              -- 'INSERT', 'UPDATE', 'DELETE', 'VIEW', 'SEARCH'
    @MaDC INT = NULL,
    @TenDC NVARCHAR(100) = NULL,
    @NhaSanXuat NVARCHAR(100) = NULL,
    @GiaDC MONEY = NULL,
    @SoLo NVARCHAR(50) = NULL,
    @LoaiDC NVARCHAR(20) = NULL,
    @TuKhoa NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Thêm dụng cụ y tế
    IF @Action = 'INSERT'
    BEGIN
        IF @TenDC IS NULL OR @LoaiDC IS NULL
        BEGIN
            RAISERROR(N'Tên và loại dụng cụ không được để trống!', 16, 1);
            RETURN;
        END

        IF @LoaiDC NOT IN ('MuonTra', '1Lan')
        BEGIN
            RAISERROR(N'Loại dụng cụ chỉ được là MuonTra hoặc 1Lan.', 16, 1);
            RETURN;
        END

        INSERT INTO DungCuYTe (TenDC, NhaSanXuat, GiaDC, SoLo, LoaiDC)
        VALUES (@TenDC, @NhaSanXuat, @GiaDC, @SoLo, @LoaiDC);

        DECLARE @NewMaDC INT = SCOPE_IDENTITY();
        PRINT N'Đã thêm dụng cụ y tế mới, mã dụng cụ: ' + CAST(@NewMaDC AS NVARCHAR);
        RETURN;
    END

    -- 2. Cập nhật dụng cụ y tế
    ELSE IF @Action = 'UPDATE'
    BEGIN
        IF @MaDC IS NULL
        BEGIN
            RAISERROR(N'Phải nhập mã dụng cụ cần cập nhật!', 16, 1);
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM DungCuYTe WHERE MaDC = @MaDC)
        BEGIN
            RAISERROR(N'Không tồn tại dụng cụ có mã này!', 16, 1);
            RETURN;
        END

        UPDATE DungCuYTe
        SET TenDC = ISNULL(@TenDC, TenDC),
            NhaSanXuat = ISNULL(@NhaSanXuat, NhaSanXuat),
            GiaDC = ISNULL(@GiaDC, GiaDC),
            SoLo = ISNULL(@SoLo, SoLo),
            LoaiDC = ISNULL(@LoaiDC, LoaiDC)
        WHERE MaDC = @MaDC;

        PRINT N'Cập nhật thông tin dụng cụ thành công!';
        RETURN;
    END

    -- 3. Xóa dụng cụ y tế
    ELSE IF @Action = 'DELETE'
    BEGIN
        IF @MaDC IS NULL
        BEGIN
            RAISERROR(N'Cần nhập Mã dụng cụ để xóa!', 16, 1);
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM DungCuYTe WHERE MaDC = @MaDC)
        BEGIN
            RAISERROR(N'Không tồn tại dụng cụ có mã này!', 16, 1);
            RETURN;
        END

        DELETE FROM DungCuYTe WHERE MaDC = @MaDC;

        PRINT N'Đã xóa dụng cụ y tế thành công!';
        RETURN;
    END

    -- 4. Xem toàn bộ danh sách dụng cụ (dùng VIEW)
    ELSE IF @Action = 'VIEW'
    BEGIN
        SELECT * 
        FROM v_DungCuYTe_Detail
        ORDER BY TenDC;
        RETURN;
    END

    -- 5. Tìm kiếm dụng cụ theo tên / loại / nhà sản xuất (dùng VIEW)
    ELSE IF @Action = 'SEARCH'
    BEGIN
        IF @TuKhoa IS NULL
        BEGIN
            RAISERROR(N'Vui lòng nhập từ khóa tìm kiếm!', 16, 1);
            RETURN;
        END

        SELECT * 
        FROM v_DungCuYTe_Detail
        WHERE TenDC LIKE N'%' + @TuKhoa + N'%'
           OR LoaiDC LIKE N'%' + @TuKhoa + N'%'
           OR NhaSanXuat LIKE N'%' + @TuKhoa + N'%'
        ORDER BY TenDC;
        RETURN;
    END

    ELSE
        RAISERROR(N'Hành động không hợp lệ! Hãy dùng INSERT, UPDATE, DELETE, VIEW hoặc SEARCH.', 16, 1);
END;
GO
