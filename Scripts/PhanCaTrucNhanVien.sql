USE BaiTapLonDB;
GO


-- VIEW 1: Thông tin phân ca trực đầy đủ
IF OBJECT_ID('View_PhanCaTruc_ThongTin', 'V') IS NOT NULL
    DROP VIEW View_PhanCaTruc_ThongTin;
GO

CREATE VIEW View_PhanCaTruc_ThongTin AS
SELECT 
    dp.MaNV,
    nv.HoTen AS TenNhanVien,
    dp.MaPhong,
    pb.LoaiPhong AS TenPhong,        -- sửa tên cột theo bảng PhongBenh
    dp.MaCa,
    c.ThoiGianBatDau,
    c.ThoiGianKetThuc
FROM DieuDuong_PhongBenh dp
JOIN NhanVien nv ON dp.MaNV = nv.MaNV
JOIN PhongBenh pb ON dp.MaPhong = pb.MaPhong
JOIN CaTruc c ON dp.MaCa = c.MaCa;
GO


-- VIEW 2: Lịch trực theo từng nhân viên
IF OBJECT_ID('View_LichTrucNhanVien', 'V') IS NOT NULL
    DROP VIEW View_LichTrucNhanVien;
GO

CREATE VIEW View_LichTrucNhanVien AS
SELECT 
    nv.MaNV,
    nv.HoTen,
    pb.LoaiPhong AS TenPhong,      
    c.MaCa,
    c.ThoiGianBatDau,
    c.ThoiGianKetThuc
FROM DieuDuong_PhongBenh dp
JOIN NhanVien nv ON dp.MaNV = nv.MaNV
JOIN PhongBenh pb ON dp.MaPhong = pb.MaPhong
JOIN CaTruc c ON dp.MaCa = c.MaCa;
GO


-- Thủ tục phân ca trực

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

    -- kiểm tra nhân viên tồn tại
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = @MaNV)
    BEGIN
        RAISERROR(N'Nhân viên không tồn tại!', 16, 1);
        RETURN;
    END

    -- kiểm tra phòng tồn tại
    IF NOT EXISTS (SELECT 1 FROM PhongBenh WHERE MaPhong = @MaPhong)
    BEGIN
        RAISERROR(N'Phòng bệnh không tồn tại!', 16, 1);
        RETURN;
    END

    -- kiểm tra ca trực tồn tại
    IF NOT EXISTS (SELECT 1 FROM CaTruc WHERE MaCa = @MaCa)
    BEGIN
        RAISERROR(N'Ca trực không tồn tại!', 16, 1);
        RETURN;
    END

    -- kiểm tra trùng ca trực
    IF EXISTS (
        SELECT 1
        FROM DieuDuong_PhongBenh dp
        JOIN CaTruc c ON dp.MaCa = c.MaCa
        WHERE dp.MaNV = @MaNV
        AND c.ThoiGianBatDau < (SELECT ThoiGianKetThuc FROM CaTruc WHERE MaCa = @MaCa)
        AND c.ThoiGianKetThuc > (SELECT ThoiGianBatDau FROM CaTruc WHERE MaCa = @MaCa)
    )
    BEGIN
        RAISERROR(N'Nhân viên này đã có ca trực trùng thời gian!', 16, 1);
        RETURN;
    END

    -- thêm ca trực
    INSERT INTO DieuDuong_PhongBenh (MaNV, MaPhong, MaCa)
    VALUES (@MaNV, @MaPhong, @MaCa);

    PRINT N'Phân ca trực thành công!';
END;
GO
