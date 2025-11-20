USE BaiTapLonDB;
GO

DELETE FROM DonThuoc;
DBCC CHECKIDENT ('DonThuoc', RESEED, 0);
GO

INSERT INTO DonThuoc (MaNV_BacSi, MaNV_DuocSi, MaBN, NgayKeDon)
VALUES
-- Đơn 1: Viêm phổi - BS Ngoại tổng quát, DS Quầy phát thuốc
(1, 5, 1, '2025-11-01'),     -- BS1 → BN1

-- Đơn 2: Tiêu chảy trẻ em - BS Nhi khoa, DS Tư vấn
(2, 11, 7, '2025-11-02'),    -- BS2 → BN7

-- Đơn 3: Viêm loét dạ dày - BS Nội tổng quát, DS Kho chính
(10, 17, 3, '2025-11-03'),   -- BS10 → BN3

-- Đơn 4: Tăng huyết áp - BS Tim mạch, DS Quầy
(14, 24, 12, '2025-11-04'),  -- BS14 → BN12

-- Đơn 5: Viêm ruột thừa - BS Ngoại tổng quát, DS Tư vấn
(16, 28, 4, '2025-11-05'),   -- BS16 → BN4

-- Đơn 6: COPD - BS Ngoại tổng quát, DS Kho
(21, 32, 6, '2025-11-06'),   -- BS21 → BN6

-- Đơn 7: Sỏi mật - BS Ngoại tổng quát, DS Quầy
(26, 5, 9, '2025-11-07'),    -- BS26 → BN9

-- Đơn 8: Gãy xương - BS Ngoại tổng quát, DS Tư vấn
(31, 11, 13, '2025-11-08'),  -- BS31 → BN13

-- Đơn 9: Viêm tiểu phế quản - BS Nhi khoa, DS Kho
(2, 17, 7, '2025-11-09'),    -- BS2 → BN7 (lần 2)

-- Đơn 10: Xơ gan - BS Nội tổng quát, DS Quầy
(10, 24, 8, '2025-11-10');   -- BS10 → BN8
GO

PRINT N'=== DANH SÁCH 10 ĐƠN THUỐC – CHỈ THEO CREATE TABLE ===';
SELECT 
    MaDT,
    MaNV_BacSi,
    MaNV_DuocSi,
    MaBN,
    FORMAT(NgayKeDon, 'dd/MM/yyyy') AS NgayKeDon
FROM DonThuoc
ORDER BY MaDT;
GO