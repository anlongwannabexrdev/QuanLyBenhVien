USE BaiTapLonDB;
GO

IF OBJECT_ID('sp_TiepNhanBenhNhan', 'P') IS NOT NULL
    DROP PROCEDURE sp_TiepNhanBenhNhan;
GO

CREATE PROCEDURE sp_TiepNhanBenhNhan
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(10),
    @SDT NVARCHAR(20),
    @DiaChi NVARCHAR(255),
    @CCCD NVARCHAR(20),
    @Tuoi INT,
    @SoTheBHYT NVARCHAR(30) = NULL,
    @HanBHYT DATE = NULL,
    @LoaiBenhNhan NVARCHAR(20), -- 'NoiTru' hoặc 'NgoaiTru'
    @NgayNhapVien DATE = NULL,
    @NgayXuatVien DATE = NULL,
    @NgayKham DATE = NULL,
    @ThoiGianKham NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Kiểm tra CCCD trùng lặp
    IF EXISTS (SELECT 1 FROM BenhNhan WHERE CCCD = @CCCD)
    BEGIN
        RAISERROR(N'Bệnh nhân với CCCD này đã tồn tại trong hệ thống!', 16, 1);
        RETURN;
    END

    -- 2. Thêm mới bệnh nhân vào bảng BenhNhan
    INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, SDT, DiaChi, CCCD, Tuoi, SoTheBHYT, HanBHYT)
    VALUES (@HoTen, @NgaySinh, @GioiTinh, @SDT, @DiaChi, @CCCD, @Tuoi, @SoTheBHYT, @HanBHYT);

    DECLARE @NewMaBN INT = SCOPE_IDENTITY(); -- lấy mã bệnh nhân vừa thêm

    -- 3. Ghi vào bảng nội trú hoặc ngoại trú tùy loại
    IF @LoaiBenhNhan = N'NoiTru'
    BEGIN
        INSERT INTO BenhNhanNoiTru (MaBN, NgayNhapVien, NgayXuatVien)
        VALUES (@NewMaBN, ISNULL(@NgayNhapVien, GETDATE()), @NgayXuatVien);
    END
    ELSE IF @LoaiBenhNhan = N'NgoaiTru'
    BEGIN
        INSERT INTO BenhNhanNgoaiTru (MaBN, NgayKham, ThoiGianKham)
        VALUES (@NewMaBN, ISNULL(@NgayKham, GETDATE()), ISNULL(@ThoiGianKham, N'Buổi sáng'));
    END
    ELSE
    BEGIN
        RAISERROR(N'Loại bệnh nhân không hợp lệ! Chỉ được nhập "NoiTru" hoặc "NgoaiTru".', 16, 1);
        RETURN;
    END

    PRINT N'Tiếp nhận bệnh nhân thành công!';
END;
GO
