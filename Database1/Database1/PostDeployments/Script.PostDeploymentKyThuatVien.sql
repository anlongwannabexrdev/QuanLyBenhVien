USE BaiTapLonDB;
GO

DELETE FROM KyThuatVien;

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
