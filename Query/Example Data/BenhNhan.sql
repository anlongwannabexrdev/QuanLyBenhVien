USE BaiTapLonDB;
GO

ALTER TABLE HoaDonVienPhi      NOCHECK CONSTRAINT ALL;
ALTER TABLE BenhNhanNgoaiTru  NOCHECK CONSTRAINT ALL;
ALTER TABLE BenhNhanNoiTru    NOCHECK CONSTRAINT ALL;
ALTER TABLE HoSoBenhAn        NOCHECK CONSTRAINT ALL;
ALTER TABLE DonThuoc_ChiTiet  NOCHECK CONSTRAINT ALL;
ALTER TABLE DonThuoc          NOCHECK CONSTRAINT ALL;
ALTER TABLE BenhNhan          NOCHECK CONSTRAINT ALL;
GO

DELETE FROM HoaDonVienPhi;
DELETE FROM BenhNhanNgoaiTru;
DELETE FROM BenhNhanNoiTru;
DELETE FROM HoSoBenhAn;
DELETE FROM DonThuoc_ChiTiet;
DELETE FROM DonThuoc;
DELETE FROM BenhNhan;
DBCC CHECKIDENT ('BenhNhan', RESEED, 0);
GO

INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, SDT, DiaChi, CCCD, SoTheBHYT, HanBHYT)
VALUES
(N'Nguyễn Văn An',     '1990-03-15', N'Nam',  '0912345671', N'Số 10 Trần Duy Hưng, Cầu Giấy, Hà Nội',    '001190003456', 'BH123456789', '2026-12-31'),
(N'Trần Thị Bình',     '1985-07-22', N'Nữ',   '0912345672', N'Số 25 Đường Láng, Đống Đa, Hà Nội',         '001185007891', NULL, NULL),
(N'Lê Văn Cường',      '1998-11-10', N'Nam',  '0912345673', N'Số 88 Nguyễn Trãi, Thanh Xuân, Hà Nội',    '001198011789', 'BH123456790', '2025-11-30'),
(N'Phạm Thị Dung',     '2002-01-30', N'Nữ',   '0912345674', N'Số 120 Kim Mã, Ba Đình, Hà Nội',           '001202015678', NULL, NULL),
(N'Hoàng Văn Em',      '1975-12-18', N'Nam',  '0912345675', N'Số 5 Phố Huế, Hai Bà Trưng, Hà Nội',       '001175019234', 'BH123456791', '2026-06-15'),
(N'Vũ Thị Hoa',        '1995-09-08', N'Nữ',   '0912345676', N'Số 33 Tây Sơn, Đống Đa, Hà Nội',           '001195023456', 'BH123456792', '2025-12-31'),
(N'Đặng Minh Khang',   '2018-06-20', N'Nam',  '0912345677', N'Số 77 Giải Phóng, Hoàng Mai, Hà Nội',      '001218027890', NULL, NULL),
(N'Nguyễn Thị Lan',    '1950-04-12', N'Nữ',   '0912345678', N'Số 200 Cầu Giấy, Hà Nội',                  '001150031234', 'BH123456793', '2026-03-31'),
(N'Bùi Văn Minh',      '1988-08-08', N'Nam',  '0912345679', N'Số 15 Hàng Bông, Hoàn Kiếm, Hà Nội',       '001188035678', 'BH123456794', '2025-10-10'),
(N'Trần Văn Nam',      '1993-05-05', N'Nam',  '0912345680', N'Số 45 Lê Duẩn, Ba Đình, Hà Nội',           '001193039012', NULL, NULL),
(N'Phạm Thị Oanh',     '1997-02-14', N'Nữ',   '0912345681', N'Số 60 Nguyễn Thái Học, Ba Đình, Hà Nội',   '001197042345', 'BH123456795', '2026-02-28'),
(N'Hoàng Văn Phú',     '1980-11-11', N'Nam',  '0912345682', N'Số 88 Trần Phú, Hà Đông, Hà Nội',          '001180046789', 'BH123456796', '2025-09-30'),
(N'Nguyễn Thị Quyên',  '2000-07-07', N'Nữ',   '0912345683', N'Số 25 Phạm Văn Đồng, Cầu Giấy, Hà Nội',    '001200050123', NULL, NULL),
(N'Lê Văn Sơn',        '1970-10-25', N'Nam',  '0912345684', N'Số 100 Hoàng Quốc Việt, Cầu Giấy, Hà Nội', '001170054567', 'BH123456797', '2026-01-15'),
(N'Trần Thị Thảo',     '1991-12-03', N'Nữ',   '0912345685', N'Số 33 Nguyễn Chí Thanh, Đống Đa, Hà Nội',  '001191058901', 'BH123456798', '2025-08-20');
GO

ALTER TABLE HoaDonVienPhi      CHECK CONSTRAINT ALL;
ALTER TABLE BenhNhanNgoaiTru  CHECK CONSTRAINT ALL;
ALTER TABLE BenhNhanNoiTru    CHECK CONSTRAINT ALL;
ALTER TABLE HoSoBenhAn        CHECK CONSTRAINT ALL;
ALTER TABLE DonThuoc_ChiTiet  CHECK CONSTRAINT ALL;
ALTER TABLE DonThuoc          CHECK CONSTRAINT ALL;
ALTER TABLE BenhNhan          CHECK CONSTRAINT ALL;
GO

PRINT '=== 15 BỆNH NHÂN ĐÃ CHÈN THÀNH CÔNG – 1 BẢNG DUY NHẤT ===';
SELECT 
    MaBN AS [Mã BN],
    HoTen AS [Họ tên],
    FORMAT(NgaySinh, 'dd/MM/yyyy') AS [Ngày sinh],
    Tuoi AS [Tuổi],
    GioiTinh AS [Giới tính],
    SDT AS [SĐT],
    DiaChi AS [Địa chỉ],
    CCCD,
    ISNULL(SoTheBHYT, N'Không có') AS [Số BHYT],
    ISNULL(FORMAT(HanBHYT, 'dd/MM/yyyy'), N'Không có') AS [Hạn BHYT]
FROM BenhNhan
ORDER BY MaBN;
GO