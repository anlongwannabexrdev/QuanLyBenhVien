use BaiTapLonDB;
go

select * from NhanVien
where GioiTinh = N'Nam'
and DATEDIFF(year, NgaySinh, '2025-12-31') > 30;
go