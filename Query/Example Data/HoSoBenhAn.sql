USE BaiTapLonDB;
GO

DELETE FROM HoSoBenhAn;
DBCC CHECKIDENT ('HoSoBenhAn', RESEED, 0);
GO

INSERT INTO HoSoBenhAn (MaBN, MaNV, ChanDoan, KetQuaXetNghiem, TienSuBenhLy, KetQuaKham, PhacDoDieuTri, NgayTaiKham)
VALUES
(1, 1, N'Viêm phổi cộng đồng', 
 N'Bạch cầu: 14.2, CRP: 58, Xquang: thâm nhiễm 2 bên', 
 N'Hút thuốc lá 15 năm', 
 N'Sốt 39°C, ran nứt 2 phổi, SpO2 92%', 
 N'Ceftriaxone 1g x 2 lần/ngày IV, Paracetamol, Oxy 2L/phút', 
 '2025-11-15'),

(7, 2, N'Tiêu chảy cấp do Rotavirus', 
 N'Phân lỏng >10 lần/ngày, xét nghiệm phân: Rotavirus (+)', 
 N'Không', 
 N'Trẻ 7 tuổi, mất nước nhẹ, bụng chướng', 
 N'Bù nước Oresol, kẽm 20mg/ngày, theo dõi phân', 
 '2025-11-14'),

(3, 10, N'Viêm loét dạ dày tá tràng', 
 N'Nội soi: loét hang vị 8mm', 
 N'NSAIDs lạm dụng', 
 N'Đau thượng vị, ợ chua', 
 N'PPI Omeprazole 40mg/ngày, Amoxicillin + Clarithromycin', 
 '2025-12-01'),

(12, 14, N'Tăng huyết áp cấp cứu', 
 N'HA: 190/115 mmHg, ECG: phì đại thất trái', 
 N'Tăng HA 8 năm, hút thuốc', 
 N'Đau đầu dữ dội, chóng mặt', 
 N'Nifedipine 10mg ngậm, Labetalol IV, nhập viện theo dõi', 
 '2025-11-20'),

(4, 16, N'Viêm ruột thừa cấp', 
 N'Bạch cầu: 16.5, Siêu âm: ruột thừa sưng', 
 N'Không', 
 N'Đau hố chậu phải, sốt 38.2°C', 
 N'Phẫu thuật nội soi cắt ruột thừa', 
 '2025-11-25'),

(6, 21, N'COPD đợt cấp', 
 N'Khí máu: pO2 55, pCO2 60', 
 N'COPD 10 năm, hút thuốc', 
 N'Khó thở tăng, ran rít', 
 N'Salbutamol xịt, Prednisolone 40mg, kháng sinh', 
 '2025-11-22'),

(9, 26, N'Sỏi mật 15mm', 
 N'Siêu âm: sỏi túi mật, thành dày', 
 N'Không', 
 N'Đau hạ sườn phải sau ăn dầu', 
 N'Phẫu thuật nội soi cắt túi mật', 
 '2025-12-10'),

(13, 31, N'Gãy xương đòn trái', 
 N'Xquang: gãy 1/3 giữa xương đòn', 
 N'Té ngã', 
 N'Đau vai trái, biến dạng', 
 N'Bó bột số 8, giảm đau, theo dõi', 
 '2025-12-05'),

(7, 2, N'Viêm tiểu phế quản', 
 N'Xquang: tăng sáng phổi', 
 N'Không', 
 N'Trẻ 2 tuổi, khò khè, co kéo lồng ngực', 
 N'Salbutamol xịt, nhập viện theo dõi', 
 NULL),

(8, 10, N'Xơ gan mất bù', 
 N'SGOT 120, SGPT 95, Albumin 28', 
 N'Uống rượu 20 năm', 
 N'Cổ trướng, vàng da', 
 N'Spironolactone, Furosemide, hạn chế muối', 
 '2025-11-28');
GO

PRINT '=== DANH SÁCH 10 HỒ SƠ BỆNH ÁN – CHỈ THEO CREATE TABLE ===';
SELECT 
    MaHSBA,
    MaBN,
    MaNV,
    ChanDoan,
    KetQuaXetNghiem,
    TienSuBenhLy,
    KetQuaKham,
    PhacDoDieuTri,
    NgayTaiKham
FROM HoSoBenhAn
ORDER BY MaHSBA;
GO