use BaiTapLonDB;
go

select nv.MaNV, nv.HoTen
from NhanVien nv
where nv.MaNV in (select MaNV from KyThuatVien)
and nv.MaNV not in (select MaNV from KyThuatVien_BenhNhan);
go