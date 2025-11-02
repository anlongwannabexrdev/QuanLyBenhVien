USE BaiTapLonDB;
GO

-- 1️ Xóa dữ liệu cũ (đảm bảo không trùng khóa chính)
DELETE FROM BacSi;
DELETE FROM DieuDuong;
DELETE FROM KyThuatVien;
DELETE FROM DuocSi;
DELETE FROM LeTan;
GO

-- 2️ Phân loại nhân viên

-- Bác sĩ
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

-- Điều dưỡng
INSERT INTO DieuDuong (MaNV, ChuyenMon, BoPhanLamViec)
SELECT 
    MaNV,
    CASE 
        WHEN MaNV % 3 = 0 THEN N'Chăm sóc bệnh nhân nặng'
        WHEN MaNV % 3 = 1 THEN N'Hỗ trợ thủ thuật ngoại khoa'
        ELSE N'Theo dõi phục hồi chức năng'
    END AS ChuyenMon,
   N'Khoa Nội trú' AS BoPhanLamViec
FROM NhanVien
WHERE ChucVu = N'Điều dưỡng';
GO

-- Kỹ thuật viên
INSERT INTO KyThuatVien (MaNV, ChuyenMon, BoPhanLamViec)
SELECT 
    MaNV,
    CASE 
        WHEN MaNV % 4 = 0 THEN N'Xét nghiệm huyết học'
        WHEN MaNV % 4 = 1 THEN N'Chẩn đoán hình ảnh'
        WHEN MaNV % 4 = 2 THEN N'Sinh hóa'
        ELSE N'Vi sinh'
    END AS ChuyenMon,
    CASE 
        WHEN MaNV % 2 = 0 THEN N'Phòng xét nghiệm trung tâm'
        ELSE N'Phòng X-quang'
    END AS BoPhanLamViec
FROM NhanVien
WHERE ChucVu = N'Kỹ thuật viên';
GO

-- Dược sĩ
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

-- Lễ tân
INSERT INTO LeTan (MaNV, KhuVucLamViec)
SELECT 
    MaNV,
    CASE 
        WHEN MaNV % 3 = 0 THEN N'Sảnh chính'
        WHEN MaNV % 3 = 1 THEN N'Khu tiếp nhận bệnh nhân'
        ELSE N'Quầy thanh toán'
    END AS KhuVucLamViec
FROM NhanVien
WHERE ChucVu = N'Lễ tân';
GO
