USE BaiTapLonDB;
GO

-- Nếu view đã tồn tại thì xóa
IF OBJECT_ID('v_HoSoBenhAn_Detail', 'V') IS NOT NULL
    DROP VIEW v_HoSoBenhAn_Detail;
GO

-- Tạo VIEW hiển thị thông tin hồ sơ bệnh án chi tiết
CREATE VIEW v_HoSoBenhAn_Detail
AS
SELECT 
    hs.MaHSBA,
    hs.MaBN,
    bn.HoTen AS TenBenhNhan,
    bs.MaNV AS MaBacSi,
    nv.HoTen AS TenBacSi,
    hs.ChanDoan,
    hs.KetQuaXetNghiem,
    hs.TienSuBenhLy,
    hs.KetQuaKham,
    hs.PhacDoDieuTri,
    hs.NgayTaiKham
FROM HoSoBenhAn hs
JOIN BenhNhan bn ON hs.MaBN = bn.MaBN
JOIN BacSi bs ON hs.MaNV = bs.MaNV
JOIN NhanVien nv ON nv.MaNV = bs.MaNV;
GO

-- Xóa procedure cũ nếu có
IF OBJECT_ID('sp_QuanLyHoSoBenhAn', 'P') IS NOT NULL
    DROP PROCEDURE sp_QuanLyHoSoBenhAn;
GO

-- Tạo lại procedure
CREATE PROCEDURE sp_QuanLyHoSoBenhAn
    @Action NVARCHAR(10),          -- 'INSERT', 'UPDATE', hoặc 'VIEW'
    @MaHSBA INT = NULL,
    @MaBN INT = NULL,
    @MaNV INT = NULL,
    @ChanDoan NVARCHAR(255) = NULL,
    @KetQuaXetNghiem NVARCHAR(MAX) = NULL,
    @TienSuBenhLy NVARCHAR(MAX) = NULL,
    @KetQuaKham NVARCHAR(MAX) = NULL,
    @PhacDoDieuTri NVARCHAR(MAX) = NULL,
    @NgayTaiKham DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Thêm hồ sơ bệnh án mới
    IF @Action = 'INSERT'
    BEGIN
        IF @MaBN IS NULL OR @MaNV IS NULL
        BEGIN
            RAISERROR(N'Phải có Mã Bệnh nhân và Mã Bác sĩ để tạo hồ sơ bệnh án!', 16, 1);
            RETURN;
        END

        INSERT INTO HoSoBenhAn (MaBN, MaNV, ChanDoan, KetQuaXetNghiem, TienSuBenhLy, KetQuaKham, PhacDoDieuTri, NgayTaiKham)
        VALUES (@MaBN, @MaNV, @ChanDoan, @KetQuaXetNghiem, @TienSuBenhLy, @KetQuaKham, @PhacDoDieuTri, @NgayTaiKham);

        PRINT N'Tạo hồ sơ bệnh án thành công!';
    END

    -- Cập nhật hồ sơ bệnh án
    ELSE IF @Action = 'UPDATE'
    BEGIN
        IF @MaHSBA IS NULL
        BEGIN
            RAISERROR(N'Phải nhập Mã hồ sơ bệnh án để cập nhật!', 16, 1);
            RETURN;
        END

        UPDATE HoSoBenhAn
        SET ChanDoan = ISNULL(@ChanDoan, ChanDoan),
            KetQuaXetNghiem = ISNULL(@KetQuaXetNghiem, KetQuaXetNghiem),
            TienSuBenhLy = ISNULL(@TienSuBenhLy, TienSuBenhLy),
            KetQuaKham = ISNULL(@KetQuaKham, KetQuaKham),
            PhacDoDieuTri = ISNULL(@PhacDoDieuTri, PhacDoDieuTri),
            NgayTaiKham = ISNULL(@NgayTaiKham, NgayTaiKham)
        WHERE MaHSBA = @MaHSBA;

        PRINT N'Cập nhật hồ sơ bệnh án thành công!';
    END

    -- Xem hồ sơ bệnh án qua VIEW
    ELSE IF @Action = 'VIEW'
    BEGIN
        IF @MaBN IS NULL
        BEGIN
            RAISERROR(N'Phải nhập Mã bệnh nhân để xem hồ sơ bệnh án!', 16, 1);
            RETURN;
        END

        SELECT *
        FROM v_HoSoBenhAn_Detail
        WHERE MaBN = @MaBN
        ORDER BY MaHSBA DESC;
    END

    ELSE
        RAISERROR(N'Giá trị @Action không hợp lệ! Chỉ dùng INSERT, UPDATE hoặc VIEW.', 16, 1);
END;
GO
