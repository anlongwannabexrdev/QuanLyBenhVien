
-- Bảng Nhân viên (cha)
CREATE TABLE NhanVien (
    MaNV INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE NOT NULL,
    GioiTinh NVARCHAR(10),
    SDT NVARCHAR(20),
    DiaChi NVARCHAR(255),
    CCCD NVARCHAR(20) UNIQUE,
    ChucVu NVARCHAR(50),
    TrinhDo NVARCHAR(100)
);
GO

-- Bảng Bác sĩ
CREATE TABLE BacSi (
    MaNV INT PRIMARY KEY REFERENCES NhanVien(MaNV),
    ChuyenKhoa NVARCHAR(100),
    ChuyenNganh NVARCHAR(100)
);
GO

-- Bảng Điều dưỡng
CREATE TABLE DieuDuong (
    MaNV INT PRIMARY KEY REFERENCES NhanVien(MaNV),
    ChuyenMon NVARCHAR(100),
    BoPhanLamViec NVARCHAR(100)
);
GO

-- Bảng Dược sĩ
CREATE TABLE DuocSi (
    MaNV INT PRIMARY KEY REFERENCES NhanVien(MaNV),
    ChuyenMon NVARCHAR(100),
    BoPhanLamViec NVARCHAR(100)
);
GO

-- Bảng Kỹ thuật viên
CREATE TABLE KyThuatVien (
    MaNV INT PRIMARY KEY REFERENCES NhanVien(MaNV),
    ChuyenMon NVARCHAR(100),
    BoPhanLamViec NVARCHAR(100)
);
GO

-- Bảng Lễ tân
CREATE TABLE LeTan (
    MaNV INT PRIMARY KEY REFERENCES NhanVien(MaNV),
    KhuVucLamViec NVARCHAR(100)
);
GO

-- Bệnh nhân (cha)
CREATE TABLE BenhNhan (
    MaBN INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE NOT NULL,
    GioiTinh NVARCHAR(10),
    SDT NVARCHAR(20),
    DiaChi NVARCHAR(255),
    CCCD NVARCHAR(20) UNIQUE,
    Tuoi INT,
    SoTheBHYT NVARCHAR(30),
    HanBHYT DATE
);
GO

-- Bệnh nhân nội trú
CREATE TABLE BenhNhanNoiTru (
    MaBN INT PRIMARY KEY REFERENCES BenhNhan(MaBN),
    NgayNhapVien DATE,
    NgayXuatVien DATE
);
GO

-- Bệnh nhân ngoại trú
CREATE TABLE BenhNhanNgoaiTru (
    MaBN INT PRIMARY KEY REFERENCES BenhNhan(MaBN),
    NgayKham DATE,
    ThoiGianKham NVARCHAR(50)
);
GO

-- Hồ sơ bệnh án
CREATE TABLE HoSoBenhAn (
    MaHSBA INT IDENTITY(1,1) PRIMARY KEY,
    MaBN INT REFERENCES BenhNhan(MaBN),
    MaNV INT REFERENCES BacSi(MaNV),
    ChanDoan NVARCHAR(255),
    KetQuaXetNghiem NVARCHAR(MAX),
    TienSuBenhLy NVARCHAR(MAX),
    KetQuaKham NVARCHAR(MAX),
    PhacDoDieuTri NVARCHAR(MAX),
    NgayTaiKham DATE
);
GO

-- Hóa đơn viện phí
CREATE TABLE HoaDonVienPhi (
    MaHD INT IDENTITY(1,1) PRIMARY KEY,
    MaBN INT REFERENCES BenhNhan(MaBN),
    PhiThuoc MONEY DEFAULT 0,
    PhiKham MONEY DEFAULT 0,
    PhiPhatSinh MONEY DEFAULT 0,
    TongTien AS (PhiThuoc + PhiKham + PhiPhatSinh)
);
GO

-- Thuốc điều trị
CREATE TABLE Thuoc (
    MaThuoc INT IDENTITY(1,1) PRIMARY KEY,
    TenThuoc NVARCHAR(100),
    HanSuDung DATE,
    NhaSanXuat NVARCHAR(100),
    GiaThuoc MONEY,
    SoLo NVARCHAR(50)
);
GO

-- Dụng cụ y tế
CREATE TABLE DungCuYTe (
    MaDC INT IDENTITY(1,1) PRIMARY KEY,
    TenDC NVARCHAR(100),
    NhaSanXuat NVARCHAR(100),
    GiaDC MONEY,
    SoLo NVARCHAR(50),
    LoaiDC NVARCHAR(20) CHECK (LoaiDC IN ('MuonTra', '1Lan'))
);
GO

-- Dụng cụ mượn trả
CREATE TABLE MuonTraDungCu (
    MaNV INT REFERENCES NhanVien(MaNV),
    MaDC INT REFERENCES DungCuYTe(MaDC),
    NgayMuon DATE,
    HanTra DATE,
    PRIMARY KEY (MaNV, MaDC, NgayMuon)
);
GO

-- Dụng cụ dùng 1 lần
CREATE TABLE LayDungCu1Lan (
    MaNV INT REFERENCES NhanVien(MaNV),
    MaDC INT REFERENCES DungCuYTe(MaDC),
    NgayLay DATE,
    PRIMARY KEY (MaNV, MaDC)
);
GO

-- Phòng bệnh
CREATE TABLE PhongBenh (
    MaPhong INT IDENTITY(1,1) PRIMARY KEY,
    LoaiPhong NVARCHAR(50),
    GiaPhong MONEY
);
GO

-- Ca trực
CREATE TABLE CaTruc (
    MaCa INT IDENTITY(1,1) PRIMARY KEY,
    ThoiGianBatDau DATETIME,
    ThoiGianKetThuc DATETIME
);
GO

-- Điều dưỡng trực nhiều phòng
CREATE TABLE DieuDuong_PhongBenh (
    MaNV INT REFERENCES DieuDuong(MaNV),
    MaPhong INT REFERENCES PhongBenh(MaPhong),
    MaCa INT REFERENCES CaTruc(MaCa),
    PRIMARY KEY (MaNV, MaPhong, MaCa)
);
GO

-- Kỹ thuật viên xét nghiệm bệnh nhân
CREATE TABLE KyThuatVien_BenhNhan (
    MaNV INT REFERENCES KyThuatVien(MaNV),
    MaBN INT REFERENCES BenhNhan(MaBN),
    NgayXetNghiem DATE NOT NULL,
    PRIMARY KEY (MaNV, MaBN, NgayXetNghiem)
);
GO

-- Đơn thuốc
CREATE TABLE DonThuoc (
    MaDT INT IDENTITY(1,1) PRIMARY KEY,
    MaNV_BacSi INT REFERENCES BacSi(MaNV),
    MaNV_DuocSi INT REFERENCES DuocSi(MaNV),
    MaBN INT REFERENCES BenhNhan(MaBN),
    NgayKeDon DATE
);
GO

-- Chi tiết đơn thuốc
CREATE TABLE DonThuoc_ChiTiet (
    MaDT INT REFERENCES DonThuoc(MaDT),
    MaThuoc INT REFERENCES Thuoc(MaThuoc),
    SoLuong INT,
    PRIMARY KEY (MaDT, MaThuoc)
);
GO
