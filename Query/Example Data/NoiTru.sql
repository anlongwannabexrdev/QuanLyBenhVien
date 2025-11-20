USE BaiTapLonDB;
GO

INSERT INTO BenhNhanNoiTru (MaBN, NgayNhapVien, NgayXuatVien)
VALUES
(1, '2025-11-01', '2025-11-05'),   -- MaBN = 1
(3, '2025-10-28', NULL),          -- MaBN = 3 (đang nằm)
(6, '2025-10-15', '2025-10-20'),  -- MaBN = 6
(8, '2025-11-08', NULL),          -- MaBN = 8 (đang nằm)
(12, '2025-09-01', '2025-09-10'); -- MaBN = 12
GO

PRINT '=== DANH SÁCH BỆNH NHÂN NỘI TRÚ (MaBN số) ===';
SELECT 
    nt.MaBN,
    bn.HoTen,
    FORMAT(nt.NgayNhapVien, 'dd/MM/yyyy') AS NgayNhapVien,
    ISNULL(FORMAT(nt.NgayXuatVien, 'dd/MM/yyyy'), N'Đang nằm viện') AS NgayXuatVien
FROM BenhNhanNoiTru nt
JOIN BenhNhan bn ON nt.MaBN = bn.MaBN
ORDER BY nt.NgayNhapVien DESC;
GO