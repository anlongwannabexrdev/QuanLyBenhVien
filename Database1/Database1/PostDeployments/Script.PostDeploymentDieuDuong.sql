USE BaiTapLonDB;
GO

DELETE FROM DieuDuong;

INSERT INTO DieuDuong (MaNV, ChuyenMon, BoPhanLamViec)
SELECT 
    MaNV,
    CASE 
        WHEN MaNV % 3 = 0 THEN N'Chăm sóc bệnh nhân nặng'
        WHEN MaNV % 3 = 1 THEN N'Hỗ trợ thủ thuật ngoại khoa'
        ELSE N'Theo dõi phục hồi chức năng'
    END AS ChuyenMon,
    CASE 
        WHEN MaNV % 2 = 0 THEN N'Khoa Nội trú'
        ELSE N'Khoa Ngoại trú'
    END AS BoPhanLamViec
FROM NhanVien
WHERE ChucVu = N'Điều dưỡng';
GO
