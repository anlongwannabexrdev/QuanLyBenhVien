USE BaiTapLonDB;
GO

-- Xóa thủ tục cũ nếu có
IF OBJECT_ID('sp_PhanCaTrucNhanVien', 'P') IS NOT NULL
    DROP PROCEDURE sp_PhanCaTrucNhanVien;
GO

CREATE PROCEDURE sp_PhanCaTrucNhanVien
    @MaNV INT,
    @MaPhong INT,
    @MaCa INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem nhân viên có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = @MaNV)
    BEGIN
        RAISERROR(N'Nhân viên không tồn tại!', 16, 1);
        RETURN;
    END

    -- Kiểm tra xem phòng có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM PhongBenh WHERE MaPhong = @MaPhong)
    BEGIN
        RAISERROR(N'Phòng bệnh không tồn tại!', 16, 1);
        RETURN;
    END

    -- Kiểm tra xem ca trực có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM CaTruc WHERE MaCa = @MaCa)
    BEGIN
        RAISERROR(N'Ca trực không tồn tại!', 16, 1);
        RETURN;
    END

    -- Kiểm tra xem nhân viên đã được phân ca trong khoảng thời gian này chưa
    IF EXISTS (
        SELECT 1
        FROM DieuDuong_PhongBenh dp
        JOIN CaTruc c ON dp.MaCa = c.MaCa
        WHERE dp.MaNV = @MaNV
        AND c.ThoiGianBatDau BETWEEN 
            (SELECT ThoiGianBatDau FROM CaTruc WHERE MaCa = @MaCa)
            AND (SELECT ThoiGianKetThuc FROM CaTruc WHERE MaCa = @MaCa)
    )
    BEGIN
        RAISERROR(N'Nhân viên này đã có ca trực trùng thời gian!', 16, 1);
        RETURN;
    END

    -- Thêm phân ca
    INSERT INTO DieuDuong_PhongBenh (MaNV, MaPhong, MaCa)
    VALUES (@MaNV, @MaPhong, @MaCa);

    PRINT N'Phân ca trực thành công!';
END;
GO
