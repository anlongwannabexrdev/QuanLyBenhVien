USE BaiTapLonDB;
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'MuonTraDungCu')
BEGIN
    DROP TABLE MuonTraDungCu;
    PRINT N'ĐÃ XÓA BẢNG MuonTraDungCu CŨ';
END
GO

CREATE TABLE MuonTraDungCu (
    MaNV INT REFERENCES NhanVien(MaNV),
    MaDC INT REFERENCES DungCuYTe(MaDC),
    NgayMuon DATE,
    HanTra DATE,
    PRIMARY KEY (MaNV, MaDC, NgayMuon)
);
GO
PRINT N'ĐÃ TẠO THÀNH CÔNG BẢNG MuonTraDungCu – MaDC KIỂU INT';
GO

INSERT INTO MuonTraDungCu (MaNV, MaDC, NgayMuon, HanTra)
VALUES
(1, 1, '2025-11-01', '2025-11-01'),   -- Bơm tiêm 5ml
(3, 2, '2025-11-02', '2025-11-03'),   -- Nhiệt kế
(4, 3, '2025-11-03', '2025-11-03'),   -- Ống nghiệm
(10, 4, '2025-11-04', '2025-11-06'),  -- Máy đo huyết áp
(11, 5, '2025-11-05', '2025-11-07'),  -- Máy siêu âm
(6, 6, '2025-11-06', '2025-11-08'),   -- Ghế khám bệnh
(1, 1, '2025-11-07', '2025-11-07'),   -- Bơm tiêm (lần 2)
(3, 2, '2025-11-08', '2025-11-09'),   -- Nhiệt kế (lần 2)
(4, 3, '2025-11-09', '2025-11-09'),   -- Ống nghiệm (lần 2)
(10, 4, '2025-11-10', '2025-11-12');  -- Máy đo HA (lần 2)
GO

SELECT 
    MaNV,
    MaDC,
    FORMAT(NgayMuon, 'dd/MM/yyyy') AS NgayMuon,
    FORMAT(HanTra, 'dd/MM/yyyy') AS HanTra
FROM MuonTraDungCu
ORDER BY NgayMuon DESC, MaNV;
GO