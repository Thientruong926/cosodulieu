create database QLSinhVien

use QLSinhVien

create table khoa
(
	MAKHOA varchar(10) constraint pk_khoa primary key,
	TENKHOA nvarchar(100) not null unique,
	NAMTHANHLAP int,
)
go
create table svien
(
	MASV varchar(8) constraint pk_sinhvien primary key,
	TEN varchar(100) not null unique,
	NAM int,
	MAKH varchar(10) constraint fk_makhoa foreign key references khoa(MAKHOA),
)
go
create table mhoc
(
	MAMH varchar(6) constraint pk_mhoc primary key,
	TENMH varchar(100) not null,
	TINCHI int,
	MAKHOA varchar(10) constraint fk_mhoc foreign key references khoa(MAKHOA),
)
go
create table dkien
(
	MAMH varchar(6),
	MAMH_TRUOC varchar(6),
	constraint pk_dkien primary key(MAMH, MAMH_TRUOC),
	constraint fk_dkiemmhoc foreign key (MAMH) references mhoc(MAMH),
	constraint fk_dkiemmhoc_truoc foreign key (MAMH_TRUOC) references mhoc(MAMH),
)
go
create table hphan
(
	MAHP int constraint pk_hphan primary key,
	MAMH varchar(6) constraint fk_hphan foreign key references mhoc(MAMH),
	HOCKY int,
	NAM int,
	GV varchar(50),
)
go
create table kqua
(
	MASV varchar(8),
	MAHP int,
	DIEM float,
	constraint pk_kqua primary key (MASV, MAHP),
	constraint fk_masvkqua foreign key (MASV) references svien(MASV),
	constraint fk_mahpkqua foreign key (MAHP) references hphan(MAHP),
)
go

insert into khoa values
('TOAN',N'Toán', 1976),
('HOA',N'hóa', 1980),
('SINH',N'sinh', 1981),
('VLY',N'lý', 1982)
go
select * from khoa;

insert into svien values
('K27.0017', N'Nguyễn Công Phú', 1 ,'TOAN'),
('K26.0008', N' Phan Anh Khanh', 2 ,'TOAN'),
('K25.0005', N'Lý Thành', 3 ,'HOA'),
('K27.0018', N'Hàn Quốc Việt', 2 ,'VLY')
go
SELECT * FROM svien;

insert into mhoc values
('TH0001', N'Tin học đại cương Al', 4 ,'TOAN'),
('TH0002', N'Cấu trúc dữ liệu', 4 ,'TOAN'),
('TO0001', N'Toán rời rạc', 3 ,'TOAN'),
('HH0001', N'Hoá đại cương Al', 5 ,'HOA'),
('HH0002', N'Hoá đại cương A2', 5 ,'HOA'),
('VL0002', N'Vật lý đại cương A2', 4 ,'VLY'),
('TH0003', N'Cơ sở dữ liệu', 5 ,'TOAN'),
('VL0001', N'Vật lý đại cương Al', 5 ,'VLY')
go
SELECT * FROM mhoc;

insert into hphan values
('1', 'TH0001', '1', 1996 ,N'N.D. Lâm'),
('2', 'VL0001', '1', 1996 ,N'T. N. Dung'),
('3', 'TH0002', '1', 1997 ,N'H. Tuân'),
('4', 'TH0001', '1', 1997 ,N'N.D. Lâm'),
('5', 'TH0003', '2', 1997 ,N'N.C.Phú'),
('6', 'HH0001', '1', 1996 ,N'L.T.Phúc'),
('7', 'TH0002', '1', 1998 ,N'P.T.Như'),
('8', 'TO0001', '1', 1996 ,N'N.C.Phú')
go
SELECT * FROM hphan;

insert into dkien values
('TH0003', 'TO0001'),
('TH0003', 'TH0002'),
('TH0002', 'TH0001'),
('HH0002', 'HH0001'),
('VL0002', 'VL0001')
go
SELECT * FROM dkien;

insert into kqua values
('K27.0017', 4, 9.5),
('K26.0008', 1, 10),
('K25.0005', 6, 6),
('K27.0018', 2, 8),
('K26.0008', 3, 9)
go
SELECT * FROM kqua;

--Cau 1
--Cach 1
select TEN
from svien, khoa
where svien.MAKH = khoa.MAKHOA and TENKHOA like N'%TOÁN%'

--Cach 2
select TEN
from svien s inner join khoa k on s.MAKH = k.MAKHOA
where TENKHOA like N'%TOÁN%'

--Cau 2
select TENMH, TINCHI
from mhoc

--Cau 3
select svien.MASV, svien.TEN, mhoc.TENMH, kqua.DIEM
from svien inner join kqua on svien.MASV = kqua.MASV
		   inner join hphan on kqua.MAHP = hphan.MAHP
		   inner join mhoc on hphan.MAMH = mhoc.MAMH
where kqua.MASV like '%8%'

--Cau 4
select TEN, hphan.MAMH
from svien inner join kqua on svien.MASV = kqua.MASV
		   inner join hphan on kqua.MAHP = hphan.MAHP
where DIEM>7

--Cau 5
select svien.TEN
from svien inner join khoa on svien.MAKH = khoa.MAKHOA
		   inner join mhoc on khoa.MAKHOA = mhoc.MAKHOA
where mhoc.TENMH like '%Toán rời rạc%'

--Cau 6
select t.TENMH, mhoc.TENMH
from dkien inner join mhoc on dkien.MAMH = mhoc.MAMH
		   inner join mhoc t on dkien.MAMH_TRUOC = t.MAMH
where mhoc.TENMH like '%Cơ sở dữ liệu%'

--Cau 7
select mhoc.TENMH, s.TENMH
from dkien inner join mhoc s on dkien.MAMH = s.MAMH
		   inner join mhoc on dkien.MAMH_TRUOC = mhoc.MAMH
where mhoc.TENMH like '%Toán rời rạc%'

--Cau 8
select hphan.MAHP, mhoc.TENMH, count(MASV) as soluongsinhvien
from hphan inner join kqua on hphan.MAHP = kqua.MAHP
		   inner join mhoc on hphan.MAMH = mhoc.MAMH
group by hphan.MAHP, mhoc.TENMH

--Cau 9
select TEN, hphan.NAM, HOCKY, avg(DIEM) as diemtrungbinh
from svien inner join kqua on svien.MASV = kqua.MASV
		   inner join hphan on kqua.MAHP = hphan.MAHP
group by TEN, hphan.NAM, HOCKY

--Cau 10
select TEN, DIEM
from svien inner join kqua on svien.MASV = kqua.MASV
where DIEM >= all (select DIEM from kqua)

--Cau 11
select MASV, TEN
from svien
where MASV not in (select MASV
				   from mhoc, kqua, hphan
				   where mhoc.MAMH = hphan.MAMH 
						 and hphan.MAHP = kqua.MAHP
						 and TENMH like '%Toán rời rạc%')