use BaiTapLonDB;
go

select
    nv.HoTen as BacSi,
    COUNT(hs.MaHSBA) as SoBenhNhan
from HoSoBenhAn hs
join BacSi bs on hs.MaNV = bs.MaNV
join NhanVien nv on bs.MaNV = nv.MaNV
group by nv.HoTen
order by SoBenhNhan DESC;
go