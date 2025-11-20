use BaiTapLonDB;
go

select top 3 bn.HoTen, h.TongTien
from HoaDonVienPhi h
join BenhNhan bn on h.MaBN = bn.MaBN
order by h.TongTien desc;
go