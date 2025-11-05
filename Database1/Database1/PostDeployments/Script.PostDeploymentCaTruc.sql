USE BaiTapLonDB;
GO

-- Xóa dữ liệu cũ nếu có
DELETE FROM CaTruc;
GO

-- Thêm dữ liệu ca trực mẫu
INSERT INTO CaTruc (ThoiGianBatDau, ThoiGianKetThuc)
VALUES
    ('2025-11-05T06:00:00', '2025-11-05T14:00:00'), -- Ca sáng
    ('2025-11-05T14:00:00', '2025-11-05T22:00:00'), -- Ca chiều
    ('2025-11-05T22:00:00', '2025-11-06T06:00:00'); -- Ca đêm
GO
