USE BaiTapLonDB;
GO

DELETE FROM LeTan;

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
