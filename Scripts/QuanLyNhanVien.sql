USE BaiTapLonDB;
GO

-- VIEW: Hiển thị thông tin nhân viên đầy đủ
IF OBJECT_ID('vw_NhanVien_Detail', 'V') IS NOT NULL
    DROP VIEW vw_NhanVien_Detail;
GO

CREATE VIEW vw_NhanVien_Detail AS
SELECT 
    nv.MaNV,
    nv.HoTen,
    nv.NgaySinh,
    nv.GioiTinh,
    nv.SDT,
    nv.DiaChi,
    nv.CCCD,
    nv.ChucVu,
    nv.TrinhDo,
    bs.ChuyenKhoa,
    bs.ChuyenNganh,
    dd.ChuyenMon AS DieuDuong_ChuyenMon,
    dd.BoPhanLamViec AS DieuDuong_BoPhan,
    ds.ChuyenMon AS DuocSi_ChuyenMon,
    ds.BoPhanLamViec AS DuocSi_BoPhan,
    ktv.ChuyenMon AS KyThuatVien_ChuyenMon,
    ktv.BoPhanLamViec AS KyThuatVien_BoPhan,
    lt.KhuVucLamViec AS LeTan_KhuVuc
FROM NhanVien nv
LEFT JOIN BacSi bs ON nv.MaNV = bs.MaNV
LEFT JOIN DieuDuong dd ON nv.MaNV = dd.MaNV
LEFT JOIN DuocSi ds ON nv.MaNV = ds.MaNV
LEFT JOIN KyThuatVien ktv ON nv.MaNV = ktv.MaNV
LEFT JOIN LeTan lt ON nv.MaNV = lt.MaNV;
GO


-- STORED PROCEDURE: Thêm nhân viên
IF OBJECT_ID('sp_ThemNhanVien', 'P') IS NOT NULL
    DROP PROCEDURE sp_ThemNhanVien;
GO

CREATE PROCEDURE sp_ThemNhanVien
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(10),
    @SDT NVARCHAR(20),
    @DiaChi NVARCHAR(255),
    @CCCD NVARCHAR(20),
    @ChucVu NVARCHAR(50),
    @TrinhDo NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM NhanVien WHERE CCCD = @CCCD)
    BEGIN
        RAISERROR(N'CCCD đã tồn tại, không thể thêm nhân viên mới!', 16, 1);
        RETURN;
    END

    INSERT INTO NhanVien (HoTen, NgaySinh, GioiTinh, SDT, DiaChi, CCCD, ChucVu, TrinhDo)
    VALUES (@HoTen, @NgaySinh, @GioiTinh, @SDT, @DiaChi, @CCCD, @ChucVu, @TrinhDo);

    PRINT N'Đã thêm nhân viên thành công.';
END
GO


-- STORED PROCEDURE: Cập nhật nhân viên

IF OBJECT_ID('sp_CapNhatNhanVien', 'P') IS NOT NULL
    DROP PROCEDURE sp_CapNhatNhanVien;
GO

CREATE PROCEDURE sp_CapNhatNhanVien
    @MaNV INT,
    @HoTen NVARCHAR(100),
    @SDT NVARCHAR(20),
    @DiaChi NVARCHAR(255),
    @TrinhDo NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = @MaNV)
    BEGIN
        RAISERROR(N'Không tìm thấy nhân viên cần cập nhật!', 16, 1);
        RETURN;
    END

    UPDATE NhanVien
    SET HoTen = @HoTen,
        SDT = @SDT,
        DiaChi = @DiaChi,
        TrinhDo = @TrinhDo
    WHERE MaNV = @MaNV;

    PRINT N'Đã cập nhật thông tin nhân viên thành công.';
END
GO


-- STORED PROCEDURE: Xóa nhân viên

IF OBJECT_ID('sp_XoaNhanVien', 'P') IS NOT NULL
    DROP PROCEDURE sp_XoaNhanVien;
GO

CREATE PROCEDURE sp_XoaNhanVien
    @MaNV INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Xóa dữ liệu trong bảng con trước
    DELETE FROM BacSi WHERE MaNV = @MaNV;
    DELETE FROM DieuDuong WHERE MaNV = @MaNV;
    DELETE FROM KyThuatVien WHERE MaNV = @MaNV;
    DELETE FROM DuocSi WHERE MaNV = @MaNV;
    DELETE FROM LeTan WHERE MaNV = @MaNV;

    DELETE FROM NhanVien WHERE MaNV = @MaNV;

    PRINT N'Đã xóa nhân viên và dữ liệu liên quan.';
END
GO



-- STORED PROCEDURE: Tìm kiếm nhân viên

IF OBJECT_ID('sp_TimKiemNhanVien', 'P') IS NOT NULL
    DROP PROCEDURE sp_TimKiemNhanVien;
GO

CREATE PROCEDURE sp_TimKiemNhanVien
    @TuKhoa NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM vw_NhanVien_Detail
    WHERE HoTen LIKE N'%' + @TuKhoa + '%'
       OR ChucVu LIKE N'%' + @TuKhoa + '%'
       OR CCCD LIKE N'%' + @TuKhoa + '%';
END
GO



-- STORED PROCEDURE: Lấy danh sách toàn bộ nhân viên

IF OBJECT_ID('sp_LayDanhSachNhanVien', 'P') IS NOT NULL
    DROP PROCEDURE sp_LayDanhSachNhanVien;
GO

CREATE PROCEDURE sp_LayDanhSachNhanVien
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM vw_NhanVien_Detail
    ORDER BY MaNV;
END
GO
