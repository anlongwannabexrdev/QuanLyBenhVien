USE BaiTapLonDB;
GO
-- Tắt ràng buộc tạm thời
ALTER TABLE LeTan NOCHECK CONSTRAINT ALL;
ALTER TABLE BacSi NOCHECK CONSTRAINT ALL;
ALTER TABLE DieuDuong NOCHECK CONSTRAINT ALL;
ALTER TABLE KyThuatVien NOCHECK CONSTRAINT ALL;
ALTER TABLE DuocSi NOCHECK CONSTRAINT ALL;
ALTER TABLE NhanVien NOCHECK CONSTRAINT ALL;

-- Xóa dữ liệu theo thứ tự phụ thuộc
DELETE FROM LeTan;
DELETE FROM BacSi;
DELETE FROM DieuDuong;
DELETE FROM KyThuatVien;
DELETE FROM DuocSi;
DELETE FROM NhanVien;

-- Bật lại ràng buộc
ALTER TABLE LeTan CHECK CONSTRAINT ALL;
ALTER TABLE BacSi CHECK CONSTRAINT ALL;
ALTER TABLE DieuDuong CHECK CONSTRAINT ALL;
ALTER TABLE KyThuatVien CHECK CONSTRAINT ALL;
ALTER TABLE DuocSi CHECK CONSTRAINT ALL;
ALTER TABLE NhanVien CHECK CONSTRAINT ALL;

INSERT INTO NhanVien (HoTen, NgaySinh, GioiTinh, SDT, DiaChi, CCCD, ChucVu, TrinhDo)
VALUES
(N'Nguyễn Thị Lan', '1986-02-14', N'Nữ', '0902000001', N'Hà Nội', '022345000001', N'Bác sĩ', N'ĐH Y Hà Nội'),
(N'Lê Minh Hoàng', '1984-07-30', N'Nam', '0902000002', N'Đà Nẵng', '022345000002', N'Bác sĩ', N'ĐH Y Dược TPHCM'),
(N'Phạm Thị Hồng', '1992-03-12', N'Nữ', '0902000003', N'Hải Phòng', '022345000003', N'Điều dưỡng', N'CĐ Điều dưỡng'),
(N'Vũ Văn Dũng', '1989-11-25', N'Nam', '0902000004', N'Cần Thơ', '022345000004', N'Kỹ thuật viên', N'CĐ Kỹ thuật y học'),
(N'Hoàng Thị Mai', '1995-01-05', N'Nữ', '0902000005', N'Bình Dương', '022345000005', N'Dược sĩ', N'ĐH Dược Hà Nội'),
(N'Nguyễn Văn Bảo', '1987-06-18', N'Nam', '0902000006', N'Hà Nội', '022345000006', N'Lễ tân', N'Trung cấp'),
(N'Trần Thị Phương', '1990-09-09', N'Nữ', '0902000007', N'Quảng Ninh', '022345000007', N'Điều dưỡng', N'CĐ Điều dưỡng'),
(N'Đặng Văn Sơn', '1988-12-22', N'Nam', '0902000008', N'Hồ Chí Minh', '022345000008', N'Kỹ thuật viên', N'CĐ Kỹ thuật y học'),
(N'Lê Thị Thanh', '1993-04-15', N'Nữ', '0902000009', N'Hòa Bình', '022345000009', N'Điều dưỡng', N'TC Điều dưỡng'),
(N'Phan Văn Long', '1985-10-30', N'Nam', '0902000010', N'Bắc Ninh', '022345000010', N'Bác sĩ', N'ĐH Y Hà Nội'),
(N'Bùi Thị Hạnh', '1994-08-20', N'Nữ', '0902000011', N'Hưng Yên', '022345000011', N'Dược sĩ', N'ĐH Dược'),
(N'Ngô Văn Kiên', '1986-05-05', N'Nam', '0902000012', N'Nam Định', '022345000012', N'Kỹ thuật viên', N'CĐ Kỹ thuật'),
(N'Trịnh Thị Thu', '1991-03-03', N'Nữ', '0902000013', N'Hải Dương', '022345000013', N'Lễ tân', N'Trung cấp'),
(N'Hoàng Văn Phúc', '1989-07-12', N'Nam', '0902000014', N'Vĩnh Long', '022345000014', N'Bác sĩ', N'ĐH Y Dược TPHCM'),
(N'Phạm Thị Lan', '1996-02-28', N'Nữ', '0902000015', N'Kon Tum', '022345000015', N'Điều dưỡng', N'CĐ Điều dưỡng'),
(N'Nguyễn Văn Tùng', '1983-09-17', N'Nam', '0902000016', N'Thái Bình', '022345000016', N'Bác sĩ', N'ĐH Y Hà Nội'),
(N'Vũ Thị Hồng', '1997-01-09', N'Nữ', '0902000017', N'Bình Thuận', '022345000017', N'Dược sĩ', N'ĐH Dược'),
(N'Lê Văn Hải', '1990-12-05', N'Nam', '0902000018', N'Quảng Nam', '022345000018', N'Kỹ thuật viên', N'CĐ Kỹ thuật y học'),
(N'Trần Thị Ngọc', '1992-06-21', N'Nữ', '0902000019', N'Hà Nam', '022345000019', N'Điều dưỡng', N'CĐ Điều dưỡng'),
(N'Phạm Văn Khôi', '1988-11-11', N'Nam', '0902000020', N'Đồng Tháp', '022345000020', N'Lễ tân', N'Trung cấp'),
(N'Trần Quang Huy', '1991-08-25', N'Nam', '0902000021', N'Hà Nội', '022345000021', N'Bác sĩ', N'ĐH Y Hà Nội'),
(N'Nguyễn Thị Thảo', '1993-10-10', N'Nữ', '0902000022', N'Hải Phòng', '022345000022', N'Điều dưỡng', N'CĐ Điều dưỡng'),
(N'Lê Minh Tuấn', '1987-04-04', N'Nam', '0902000023', N'TP.HCM', '022345000023', N'Kỹ thuật viên', N'CĐ Kỹ thuật'),
(N'Phạm Thị Hằng', '1994-02-19', N'Nữ', '0902000024', N'Đà Nẵng', '022345000024', N'Dược sĩ', N'ĐH Dược Hà Nội'),
(N'Nguyễn Đức Anh', '1990-07-09', N'Nam', '0902000025', N'Hà Tĩnh', '022345000025', N'Lễ tân', N'Trung cấp'),
(N'Vũ Hồng Sơn', '1988-11-30', N'Nam', '0902000026', N'Nam Định', '022345000026', N'Bác sĩ', N'ĐH Y Dược Hải Phòng'),
(N'Hoàng Minh Anh', '1996-09-15', N'Nữ', '0902000027', N'Ninh Bình', '022345000027', N'Điều dưỡng', N'CĐ Điều dưỡng'),
(N'Đặng Thị Hòa', '1995-12-25', N'Nữ', '0902000028', N'Hòa Bình', '022345000028', N'Dược sĩ', N'ĐH Dược'),
(N'Ngô Minh Quân', '1992-03-07', N'Nam', '0902000029', N'Quảng Trị', '022345000029', N'Kỹ thuật viên', N'CĐ Kỹ thuật y học'),
(N'Lê Ngọc Yến', '1998-06-20', N'Nữ', '0902000030', N'Bắc Giang', '022345000030', N'Điều dưỡng', N'CĐ Điều dưỡng'),
(N'Phạm Văn Cường', '1989-10-01', N'Nam', '0902000031', N'Hà Nội', '022345000031', N'Bác sĩ', N'ĐH Y Hà Nội'),
(N'Nguyễn Thị Kim', '1993-03-18', N'Nữ', '0902000032', N'Hải Dương', '022345000032', N'Dược sĩ', N'ĐH Dược'),
(N'Bùi Văn Nam', '1991-02-10', N'Nam', '0902000033', N'Thanh Hóa', '022345000033', N'Kỹ thuật viên', N'CĐ Kỹ thuật y học'),
(N'Trần Thanh Hà', '1997-07-23', N'Nữ', '0902000034', N'Nghệ An', '022345000034', N'Điều dưỡng', N'CĐ Điều dưỡng'),
(N'Vũ Minh Đức', '1986-12-29', N'Nam', '0902000035', N'Hà Nam', '022345000035', N'Lễ tân', N'Trung cấp');
GO
