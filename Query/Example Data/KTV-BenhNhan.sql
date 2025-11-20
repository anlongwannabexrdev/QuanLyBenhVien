USE BaiTapLonDB;
GO

DELETE FROM KyThuatVien_BenhNhan;
GO

INSERT INTO KyThuatVien_BenhNhan (MaNV, MaBN, NgayXetNghiem)
VALUES
-- KTV Vũ Văn Dũng (MaNV=4)
(4, 1, '2025-11-01'),   -- XN máu cho Nguyễn Văn An
(4, 7, '2025-11-02'),   -- XN tiểu cầu cho Đặng Minh Khang

-- KTV Đặng Văn Sơn (MaNV=8)
(8, 3, '2025-11-03'),   -- XN nước tiểu cho Lê Văn Cường
(8, 12, '2025-11-04'),  -- XN sinh hóa cho Hoàng Văn Phú

-- KTV Ngô Văn Kiên (MaNV=12)
(12, 6, '2025-11-05'),  -- XN công thức máu cho Vũ Thị Hoa
(12, 9, '2025-11-06'),  -- XN CRP cho Bùi Văn Minh

-- KTV Lê Văn Hải (MaNV=18)
(18, 8, '2025-11-07'),  -- XN chức năng gan cho Nguyễn Thị Lan
(18, 13, '2025-11-08'), -- XN điện giải cho Nguyễn Thị Quyên

-- KTV Lê Minh Tuấn (MaNV=23)
(23, 4, '2025-11-09'),  -- XN HbA1c cho Phạm Thị Dung
(23, 2, '2025-11-10');  -- XN lipid máu cho Trần Thị Bình
GO

SELECT 
    MaNV,
    MaBN,
    FORMAT(NgayXetNghiem, 'dd/MM/yyyy') AS NgayXetNghiem
FROM KyThuatVien_BenhNhan
ORDER BY NgayXetNghiem DESC, MaNV;
GO