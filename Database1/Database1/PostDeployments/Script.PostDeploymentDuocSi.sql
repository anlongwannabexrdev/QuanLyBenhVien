USE BaiTapLonDB;
GO

DELETE FROM DuocSi;

INSERT INTO DuocSi (MaNV, ChuyenMon, BoPhanLamViec)
SELECT 
    MaNV,
    CASE 
        WHEN MaNV % 3 = 0 THEN N'Pha chế thuốc tiêm truyền'
        WHEN MaNV % 3 = 1 THEN N'Quản lý kho thuốc'
        ELSE N'Tư vấn sử dụng thuốc'
    END AS ChuyenMon,
    CASE 
        WHEN MaNV % 2 = 0 THEN N'Kho chính'
        ELSE N'Quầy phát thuốc'
    END AS BoPhanLamViec
FROM NhanVien
WHERE ChucVu = N'Dược sĩ';
GO
