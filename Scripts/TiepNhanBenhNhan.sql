USE BaiTapLonDB;
GO

-- 1️. Tạo view hiển thị thông tin bệnh nhân đầy đủ
IF OBJECT_ID('v_BenhNhan_Detail', 'V') IS NOT NULL
    DROP VIEW v_BenhNhan_Detail;
GO

CREATE VIEW v_BenhNhan_Detail
AS
SELECT 
    bn.MaBN,
    bn.HoTen,
    bn.NgaySinh,
    bn.GioiTinh,
    bn.SDT,
    bn.DiaChi,
    bn.CCCD,
    bn.Tuoi,
    bn.SoTheBHYT,
    bn.HanBHYT,
    CASE 
        WHEN ntn.MaBN IS NOT NULL THEN N'NoiTru'
        WHEN ngoaitr.MaBN IS NOT NULL THEN N'NgoaiTru'
        ELSE N'Chưa xác định'
    END AS LoaiBenhNhan,
    ntn.NgayNhapVien,
    ntn.NgayXuatVien,
    ngoaitr.NgayKham,
    ngoaitr.ThoiGianKham
FROM BenhNhan bn
LEFT JOIN BenhNhanNoiTru ntn ON bn.MaBN = ntn.MaBN
LEFT JOIN BenhNhanNgoaiTru ngoaitr ON bn.MaBN = ngoaitr.MaBN;
GO


-- 2️. Tạo procedure tiếp nhận bệnh nhân
IF OBJECT_ID('sp_TiepNhanBenhNhan', 'P') IS NOT NULL
    DROP PROCEDURE sp_TiepNhanBenhNhan;
GO

CREATE PROCEDURE sp_TiepNhanBenhNhan
    @Action NVARCHAR(10),             -- 'INSERT' hoặc 'VIEW'
    @HoTen NVARCHAR(100) = NULL,
    @NgaySinh DATE = NULL,
    @GioiTinh NVARCHAR(10) = NULL,
    @SDT NVARCHAR(20) = NULL,
    @DiaChi NVARCHAR(255) = NULL,
    @CCCD NVARCHAR(20) = NULL,
    @Tuoi INT = NULL,
    @SoTheBHYT NVARCHAR(30) = NULL,
    @HanBHYT DATE = NULL,
    @LoaiBenhNhan NVARCHAR(20) = NULL, -- 'NoiTru' hoặc 'NgoaiTru'
    @NgayNhapVien DATE = NULL,
    @NgayXuatVien DATE = NULL,
    @NgayKham DATE = NULL,
    @ThoiGianKham NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️. Thêm mới bệnh nhân
    IF @Action = 'INSERT'
    BEGIN
        -- Kiểm tra CCCD trùng
        IF EXISTS (SELECT 1 FROM BenhNhan WHERE CCCD = @CCCD)
        BEGIN
            RAISERROR(N'Bệnh nhân với CCCD này đã tồn tại!', 16, 1);
            RETURN;
        END

        -- Thêm vào bảng BenhNhan
        INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, SDT, DiaChi, CCCD, Tuoi, SoTheBHYT, HanBHYT)
        VALUES (@HoTen, @NgaySinh, @GioiTinh, @SDT, @DiaChi, @CCCD, @Tuoi, @SoTheBHYT, @HanBHYT);

        DECLARE @NewMaBN INT = SCOPE_IDENTITY();

        -- Ghi vào nội trú hoặc ngoại trú
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
            RAISERROR(N'Loại bệnh nhân không hợp lệ! Chỉ "NoiTru" hoặc "NgoaiTru".', 16, 1);
            RETURN;
        END

        PRINT N'Tiếp nhận bệnh nhân thành công! Mã BN: ' + CAST(@NewMaBN AS NVARCHAR);
        RETURN;
    END

    -- 2️. Xem toàn bộ bệnh nhân (sử dụng view)
    IF @Action = 'VIEW'
    BEGIN
        SELECT * FROM v_BenhNhan_Detail
        ORDER BY MaBN DESC;
        RETURN;
    END

    RAISERROR(N'Hành động không hợp lệ! Chỉ dùng INSERT hoặc VIEW.', 16, 1);
END;
GO
