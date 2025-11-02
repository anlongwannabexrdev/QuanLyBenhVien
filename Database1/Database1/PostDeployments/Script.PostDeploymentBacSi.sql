USE BaiTapLonDB;
GO

DELETE FROM BacSi;

INSERT INTO BacSi (MaNV, ChuyenKhoa, ChuyenNganh)
SELECT 
    MaNV,
    CASE 
        WHEN MaNV % 5 = 0 THEN N'Nội tổng quát'
        WHEN MaNV % 5 = 1 THEN N'Ngoại tổng quát'
        WHEN MaNV % 5 = 2 THEN N'Nhi khoa'
        WHEN MaNV % 5 = 3 THEN N'Sản khoa'
        ELSE N'Tim mạch'
    END AS ChuyenKhoa,
    CASE 
        WHEN MaNV % 4 = 0 THEN N'Thần kinh'
        WHEN MaNV % 4 = 1 THEN N'Hô hấp'
        WHEN MaNV % 4 = 2 THEN N'Tiêu hóa'
        ELSE N'Chấn thương chỉnh hình'
    END AS ChuyenNganh
FROM NhanVien
WHERE ChucVu = N'Bác sĩ';
GO
