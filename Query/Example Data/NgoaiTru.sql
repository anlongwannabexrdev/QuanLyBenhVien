USE BaiTapLonDB;
GO

INSERT INTO BenhNhanNgoaiTru (MaBN, NgayKham, ThoiGianKham)
VALUES
(2, '2025-11-12', N'Sáng 8:30'),     -- Trần Thị Bình
(4, '2025-11-10', N'Chiều 14:00'),   -- Phạm Thị Dung
(7, '2025-11-11', N'Sáng 9:15'),     -- Đặng Minh Khang
(9, '2025-11-09', N'Chiều 15:30'),   -- Bùi Văn Minh
(13, '2025-11-08', N'Sáng 10:00');   -- Nguyễn Thị Quyên
GO

PRINT '=== DANH SÁCH BỆNH NHÂN NGOẠI TRÚ (MaBN số) ===';
SELECT 
    nt.MaBN,
    bn.HoTen,
    FORMAT(nt.NgayKham, 'dd/MM/yyyy') AS NgayKham,
    nt.ThoiGianKham
FROM BenhNhanNgoaiTru nt
JOIN BenhNhan bn ON nt.MaBN = bn.MaBN
ORDER BY nt.NgayKham DESC, nt.ThoiGianKham;
GO