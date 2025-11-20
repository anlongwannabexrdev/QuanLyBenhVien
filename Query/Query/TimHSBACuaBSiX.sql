use BaiTapLonDB;
go

select bn.HoTen as BenhNhan, 
nv.HoTen as BacSi,
hs.ChanDoan,
hs.NgayTaiKham
from HoSoBenhAn hs
join BenhNhan bn on hs.MaBN = bn.MaBN
join BacSi bs on hs.MaNV = bs.MaNV
join NhanVien nv on bs.MaNV = nv.MaNV
where hs.MaNV = 1;
go