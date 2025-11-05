USE BaiTapLonDB;
GO

-- Xóa dữ liệu cũ để tránh trùng
DELETE FROM Thuoc;
GO

-- Thêm danh sách thuốc điều trị mẫu
INSERT INTO Thuoc (TenThuoc, HanSuDung, NhaSanXuat, GiaThuoc, SoLo)
VALUES
    (N'Paracetamol 500mg', '2027-05-01', N'Traphaco', 2000, N'LO001'),
    (N'Amoxicillin 500mg', '2026-11-15', N'Mekophar', 3500, N'LO002'),
    (N'Vitamin C 100mg', '2027-01-10', N'Dược Hậu Giang', 1500, N'LO003'),
    (N'Omeprazol 20mg', '2026-09-20', N'Imexpharm', 4000, N'LO004'),
    (N'Insulin 100IU/ml', '2026-06-30', N'Sanofi', 120000, N'LO005'),
    (N'Metformin 500mg', '2027-02-01', N'Pharbaco', 5000, N'LO006'),
    (N'Aspirin 81mg', '2027-07-15', N'Trung Nam Pharma', 2500, N'LO007'),
    (N'Cefixime 200mg', '2026-12-30', N'Pymepharco', 9000, N'LO008'),
    (N'Loratadin 10mg', '2027-03-05', N'Dược Bình Định', 1800, N'LO009'),
    (N'Acetylcystein 200mg', '2026-08-25', N'Trường Thọ', 3000, N'LO010');
GO
