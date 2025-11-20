USE BaiTapLonDB;
GO

DELETE FROM HoaDonVienPhi;
DBCC CHECKIDENT ('HoaDonVienPhi', RESEED, 0);
GO

INSERT INTO HoaDonVienPhi (MaBN, PhiThuoc, PhiKham, PhiPhatSinh)
VALUES
-- HD1: Nội trú, thuốc đắt
(1, 1500000, 200000, 300000),     -- Viêm phổi: thuốc IV + oxy

-- HD2: Ngoại trú, khám + thuốc nhẹ
(2, 180000, 150000, 0),           -- Viêm họng: khám + kháng sinh

-- HD3: Trẻ em, khám + thuốc
(7, 95000, 120000, 25000),        -- Tiêu chảy: Oresol + kẽm

-- HD4: Cấp cứu, phí phát sinh cao
(12, 500000, 300000, 1200000),    -- Tăng HA: thuốc cấp cứu + theo dõi

-- HD5: Phẫu thuật
(4, 800000, 500000, 2500000),     -- Cắt ruột thừa: thuốc + phòng mổ

-- HD6: COPD đợt cấp
(6, 1200000, 200000, 400000),     -- Thuốc xịt + kháng sinh

-- HD7: Sỏi mật
(9, 600000, 300000, 1800000),     -- Phẫu thuật nội soi

-- HD8: Gãy xương
(13, 300000, 200000, 800000),     -- Bó bột + Xquang

-- HD9: Viêm tiểu phế quản (trẻ em)
(7, 450000, 150000, 200000),      -- Nhập viện, thuốc xịt

-- HD10: Xơ gan
(8, 700000, 180000, 500000);      -- Thuốc lợi tiểu + xét nghiệm
GO

SELECT 
    MaHD,
    MaBN,
    PhiThuoc,
    PhiKham,
    PhiPhatSinh,
    TongTien
FROM HoaDonVienPhi
ORDER BY MaHD;
GO