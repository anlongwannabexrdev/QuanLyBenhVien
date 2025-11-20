use BaiTapLonDB;
go

select 
    bn.HoTen AS [Họ tên],
    bn.DiaChi AS [Địa chỉ]
from HoSoBenhAn hs
join BenhNhan bn ON hs.MaBN = bn.MaBN
where hs.ChanDoan like N'%viêm phổi%';
go