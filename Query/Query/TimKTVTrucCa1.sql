use BaiTapLonDB;
go

select nv.HoTen, pb.LoaiPhong
from DieuDuong_PhongBenh dp
join NhanVien nv on dp.MaNV = nv.MaNV
join PhongBenh pb on dp.MaPhong = pb.MaPhong
where dp.MaCa = 1;
go