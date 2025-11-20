USE BaiTapLonDB;
GO

DELETE FROM DonThuoc_ChiTiet;
GO

INSERT INTO DonThuoc_ChiTiet (MaDT, MaThuoc, SoLuong)
VALUES
-- ĐƠN 1: Viêm phổi (MaDT=1) → BS1, BN1
(1, 2, 20),   -- Amoxicillin 500mg x 20 viên
(1, 1, 30),   -- Paracetamol 500mg x 30 viên
(1, 6, 10),   -- Metformin (giả sử có dùng kèm)

-- ĐƠN 2: Tiêu chảy trẻ em (MaDT=2) → BS2, BN7
(2, 1, 15),   -- Paracetamol
(2, 4, 10),   -- Oresol (giả sử là thuốc)
(2, 3, 12),   -- Vitamin C

-- ĐƠN 3: Viêm loét dạ dày (MaDT=3) → BS10, BN3
(3, 5, 28),   -- Omeprazol 20mg x 28 viên
(3, 2, 21),   -- Amoxicillin
(3, 7, 21),   -- Clarithromycin (giả sử)

-- ĐƠN 4: Tăng huyết áp (MaDT=4) → BS14, BN12
(4, 8, 30),   -- Amlodipine (giả sử)
(4, 9, 30),   -- Aspirin 81mg x 30 viên

-- ĐƠN 5: Viêm ruột thừa (MaDT=5) → BS16, BN4
(5, 2, 14),   -- Amoxicillin
(5, 10, 20),  -- Cefixime (giả sử)
(5, 1, 20),   -- Paracetamol

-- ĐƠN 6: COPD (MaDT=6) → BS21, BN6
(6, 1, 30),   -- Paracetamol
(6, 6, 60),   -- Salbutamol (giả sử)
(6, 5, 30),   -- Prednisolone (giả sử)

-- ĐƠN 7: Sỏi mật (MaDT=7) → BS26, BN9
(7, 1, 20),   -- Paracetamol
(7, 10, 30),  -- Ursodiol (giả sử)

-- ĐƠN 8: Gãy xương (MaDT=8) → BS31, BN13
(8, 1, 30),   -- Paracetamol
(8, 9, 30),   -- Aspirin

-- ĐƠN 9: Viêm tiểu phế quản (MaDT=9) → BS2, BN7
(9, 1, 20),   -- Paracetamol
(9, 6, 40),   -- Salbutamol xịt

-- ĐƠN 10: Xơ gan (MaDT=10) → BS10, BN8
(10, 1, 30),  -- Paracetamol
(10, 5, 30),  -- Spironolactone (giả sử)
(10, 8, 30),  -- Furosemide (giả sử)
(10, 3, 30);  -- Vitamin C
GO

SELECT 
    MaDT,
    MaThuoc,
    SoLuong
FROM DonThuoc_ChiTiet
ORDER BY MaDT, MaThuoc;
GO