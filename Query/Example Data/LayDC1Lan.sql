USE BaiTapLonDB;
GO

DELETE FROM LayDungCu1Lan;
GO

INSERT INTO LayDungCu1Lan (MaNV, MaDC, NgayLay)
VALUES
-- Bơm tiêm 5ml (MaDC = 1)
(1, 1, '2025-11-01'),   -- BS Nguyễn Thị Lan
(3, 1, '2025-11-02'),   -- Điều dưỡng Phạm Thị Hồng
(10, 1, '2025-11-03'),  -- BS Phan Văn Long

-- Nhiệt kế (MaDC = 2) – dù là 1 lần, nhưng có thể mượn lại
(4, 2, '2025-11-04'),   -- KTV Vũ Văn Dũng
(11, 2, '2025-11-05'),  -- Dược sĩ Bùi Thị Hạnh

-- Ống nghiệm (MaDC = 3)
(6, 3, '2025-11-06'),   -- Lễ tân Nguyễn Văn Bảo
(14, 3, '2025-11-07'),  -- BS Hoàng Văn Phúc
(21, 3, '2025-11-08');  -- BS Trần Quang Huy
GO

PRINT N'=== DANH SÁCH 8 BẢN GHI LẤY DỤNG CỤ 1 LẦN ===';
SELECT 
    MaNV,
    MaDC,
    FORMAT(NgayLay, 'dd/MM/yyyy') AS NgayLay
FROM LayDungCu1Lan
ORDER BY MaDC, NgayLay;
GO