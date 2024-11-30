/*----------------------------------------------------------
MASV: 49.01.104.162
HO TEN: Hua Thien Truong
MA ĐE: DE THU 4			-	NGAY THI: 27/11/2024
----------------------------------------------------------*/

create database NhaSach

use NhaSach
go

create table LOAISACH
(
	MALOAI int identity(1,1),
	TENLOAI varchar(50),
	constraint pk_loaisach primary key (MALOAI),
)
go

create table NHAXUATBAN
(	
	MANXB char(5),
	TENNXB varchar(50) unique,
	NGAYTL date,
	DAIDIEN varchar(50),
	constraint pk_nhaxuatban primary key (MANXB),
)
go

create table SACH
(
	MASACH char(5),
	TENSACH varchar(50),
	NGAYIN date,
	TAIBAN int default 0,
	MOTA varchar(100) null,
	LOAI int,
	NXB char(5),
	constraint pk_sach primary key (MASACH),
	constraint fk_sach_loai foreign key (LOAI) references LOAISACH(MALOAI),
	constraint fk_sach_nxb foreign key (NXB) references NHAXUATBAN(MANXB),
)
go

insert into LOAISACH values
('hinh su'),
('trinh tham')
go

insert into NHAXUATBAN values
('00001', 'kim dong', '2000-01-01', 'Nguyen Van A'),
('00002', 'nguyen kim', '2020-07-09', 'Nguyen Thi C')
go

insert into SACH values
('A0001', 'detective conan', '2004-12-22', 17, '', 1, '00001'),
('A0002', 'shin', '2017-08-09', 4, 'hay', 1, '00001'),
('A0003', 'doraemon', '2019-07-01', 9, 'tap truyen ngan', 2, '00002'),
('A0004', 'death note', '2003-08-14', 11, 'trinh tham', 2, '00002')
go

select MASACH, TENSACH, MOTA, year(NGAYIN) as [năm in]
from SACH
go

select MASACH, TENSACH, TAIBAN, TENNXB, NGAYTL
from NHAXUATBAN, SACH
where NHAXUATBAN.MANXB = SACH.NXB
go

select *
from LOAISACH, SACH
where LOAISACH.MALOAI = SACH.LOAI
	  and TENLOAI = 'Trinh thám'
	  and year(NGAYIN) > 2022

select LOAI, count(*) as [số lượng sách tái bản lần 1]
from SACH
where TAIBAN = 1
group by LOAI