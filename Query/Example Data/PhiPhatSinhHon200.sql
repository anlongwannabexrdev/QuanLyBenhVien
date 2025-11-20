use BaiTapLonDB;
go

select bn.HoTen, h.PhiPhatSinh, h.TongTien
from HoaDonVienPhi h
join BenhNhan bn on h.MaBN = bn.MaBN
where PhiPhatSinh > 200000;
go