USE BaiTapLonDB;
GO

DELETE FROM DieuDuong_PhongBenh;
GO

INSERT INTO DieuDuong_PhongBenh (MaNV, MaPhong, MaCa)
VALUES
-- Ca sáng (MaCa = 1): 06:00 - 14:00
(3, 1, 1),   -- Phạm Thị Hồng - Nội tổng quát
(7, 2, 1),   -- Trần Thị Phương - Ngoại tổng quát
(9, 3, 1),   -- Lê Thị Thanh - Sản khoa

-- Ca chiều (MaCa = 2): 14:00 - 22:00
(3, 4, 2),   -- Phạm Thị Hồng - Nhi khoa
(19, 5, 2),  -- Trần Thị Ngọc - Tim mạch
(27, 6, 2),  -- Hoàng Minh Anh - Thần kinh

-- Ca đêm (MaCa = 3): 22:00 - 06:00
(7, 1, 3),   -- Trần Thị Phương - Nội tổng quát (đêm)
(9, 2, 3),   -- Lê Thị Thanh - Ngoại tổng quát (đêm)
(19, 3, 3),  -- Trần Thị Ngọc - Sản khoa (đêm)
(34, 4, 3);  -- Trần Thanh Hà - Nhi khoa (đêm)
GO

SELECT 
    MaNV,
    MaPhong,
    MaCa
FROM DieuDuong_PhongBenh
ORDER BY MaCa, MaPhong;
GO