--Cau 1
create database QLNV

use QLNV

go

create table bophan
(
	mabp int identity(1,1),
	tenbp varchar(50),
	constraint pk_bophan primary key (mabp),
)
go

create table donvi
(
	madv char(5),
	tendv varchar(50) unique,
	ngaytl date,
	mabp int null,
	constraint pk_donvi primary key (madv),
	constraint fk_donvi foreign key (mabp) references bophan(mabp),
)
go

create table nhanvien
(
	manv char(5),
	honv varchar(50),
	tennv varchar(50),
	ngsinh date,
	phai bit default 0,
	dchi varchar(100),
	dvi char(5),
	constraint pk_nhanvien primary key (manv),
	constraint fk_nhanvien foreign key (dvi) references donvi(madv),
)
go

--Cau 2
--Cau a
insert into bophan values
('may bom'),
('may giat')

--Cau b
insert into donvi values
('00001', 'sony', '1996-09-11', 2),
('00002', 'toshiba', '2004-02-05', null)

--Cau c
insert into nhanvien values
('A0001', 'Nguyen', 'A', '2009-10-29', 1, '351A, Lac Long Quan, phuong 5, quan 11', '00001'),
('A0002', 'Van', 'Toan', '2013-01-15', 0, '280 An Duong Vuong, phuong 4, quan 5', '00001'),
('A0003', 'Khang', 'Tuan', '1999-03-07', 0, '333 Le Van Sy, phuong 2, quan 3', '00002'),
('A0004', 'Ngoc', 'Hue', '2014-01-06', 0, '638 Nguyen Van Cu, phuong 4, quan 5', '00002')

--Cau 3
--Cau a
select manv, honv, tennv, ngsinh
from nhanvien

--Cau b
select manv, tennv, phai, tendv, ngaytl
from donvi, nhanvien

--Cau c
select donvi.*
from donvi, bophan
where tenbp = 'Kiem toan' and year(ngaytl) > 2023

--select
select count(*)
from nhanvien
where phai = 1