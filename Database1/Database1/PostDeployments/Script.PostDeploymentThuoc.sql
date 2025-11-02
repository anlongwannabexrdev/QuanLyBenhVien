USE BaiTapLonDB;
GO

DELETE FROM Thuoc;

INSERT INTO Thuoc (TenThuoc, HanSuDung, NhaSanXuat, GiaThuoc, SoLo)
VALUES
(N'Paracetamol', '2027-12-31', N'Dược Hậu Giang', 2000, N'T001'),
(N'Amoxicillin', '2026-11-15', N'Mekophar', 5000, N'T002'),
(N'Vitamin C', '2028-05-20', N'Trung Nguyên Pharma', 3000, N'T003'),
(N'Insulin', '2026-09-10', N'Sanofi', 15000, N'T004'),
(N'Omeprazol', '2027-03-30', N'Pymepharco', 4000, N'T005'),
(N'Metformin', '2028-01-25', N'Pharbaco', 3500, N'T006');
GO
