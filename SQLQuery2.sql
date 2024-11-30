create database QLDeAn

use QLDeAn

create table phongban
(
	maphg varchar(4),
	tenphg varchar(100) not null unique,
	trphg varchar(8),
	ngnc date,
	constraint pk_phongban primary key (maphg)
)
go

alter table nhanvien
add constraint fk_manhanvien_nql foreign key (ma_nql)
references nhanvien(manv)
go

create table nhanvien
(
	manv varchar(8),
	honv varchar(50),
	tenlot varchar(50),
	tennv varchar(50),
	ngsinh date,
	phai varchar(5) check (phai in ('Nam','Nu')),
	dchi varchar(100),
	ma_nql varchar(8),
	phong varchar(4),
	mluong int,
	constraint pk_nhanvien primary key (manv),
	constraint fk_phongban foreign key (phong) references phongban(maphg)
)
go

alter table phongban
add constraint fk_trphong_nhanvien foreign key (trphg)
references nhanvien(manv)
go

create table dean
(
	mada varchar(6),
	tenda varchar(50),
	ddiem_da varchar(100),
	phong varchar(4),
	ngbd_dk date,
	ngkt_dk date,
	constraint pk_dean primary key (mada),
	constraint fk_dean foreign key (phong) references phongban(maphg)
)
go

create table phancong
(
	manv varchar(8),
	mada varchar(6),
	thoidian int,
	constraint pk_phancong primary key (manv,mada),
	constraint fk_phancong_nhanvien foreign key (manv) references nhanvien(manv),
	constraint fk_phancong_dean foreign key (mada) references dean(mada)
)
go

create table diadiem_phg
(
	maphg varchar(4),
	diadiem varchar(30),
	constraint pk_diadiem_phg primary key (maphg, diadiem),
	constraint fk_diadiem_phg foreign key (maphg) references phongban(maphg)
)
go

create table thannhan
(
	manv varchar(8),
	matn varchar(6),
	tentn varchar(50),
	phai varchar(5) check (phai in ('Nam','Nu')),
	ngsinh date,
	quanhe varchar(30),
	constraint pk_thannhan primary key (manv, matn),
	constraint fk_thannhan foreign key (manv) references nhanvien(manv)
)
go

ALTER TABLE nhanvien NOCHECK CONSTRAINT ALL;
ALTER TABLE phongban NOCHECK CONSTRAINT ALL;

insert into phongban values
('QL', 'Quan Ly', '001', '2000-05-22'),
('DH', 'Dieu Hanh', '003', '2002-10-10'),
('NC', 'Nghien Cuu', '002', '2002-03-15')
go
select * from phongban

INSERT INTO nhanvien VALUES
('001', 'Vuong', 'Ngoc', 'Quyen', '1975-10-22', 'Nu', '450 Trung Vuong, Ha Noi', null , 'QL', 3000000),
('002', 'Nguyen', 'Thanh', 'Tung', '1955-01-09', 'Nam', '731 Tran Hung Dao, Q1, Tp HCM', '001', 'NC', 2500000),
('003', 'Le', 'Thi', 'Nhan', '1960-12-18', 'Nu', '291 Ho Van Hue, QPN, Tp HCM', '001', 'DH', 2500000),
('004', 'Dinh', 'Ba', 'Tien', '1968-01-09', 'Nam', '638 Nguyen Van Cu, Q5, Tp HCM', '002', 'NC', 2200000),
('005', 'Bui', 'Thuy', 'Vu', '1972-07-19', 'Nam', '332 Nguyen Thai Hoc, Q1, Tp HCM', '003', 'DH', 2200000),
('006', 'Nguyen', 'Manh', 'Hung', '1973-09-15', 'Nam', '978 Ba Ria, Vung Tau', '002', 'NC', 2000000),
('007', 'Tran', 'Thanh', 'Tam', '1975-07-31', 'Nu', '543 Mai Thi Luu, Q1, Tp HCM', '002', 'NC', 2200000),
('008', 'Tran', 'Hong', 'Van', '1976-07-04', 'Nu', '980 Le Hong Phong, Q10, Tp HCM', '004', 'NC', 1800000)
go
select * from nhanvien

ALTER TABLE nhanvien CHECK CONSTRAINT ALL;
ALTER TABLE phongban CHECK CONSTRAINT ALL;

insert into diadiem_phg values
('NC', 'HANOI'),
('NC', 'TPHCM'),
('QL', 'TPHCM'),
('DH', 'HANOI'),
('DH', 'TPHCM'),
('DH', 'NHATRANG')
go
select * from diadiem_phg


insert into dean values
('TH001', 'Tin hoc hoa 1', 'HANOI', 'NC', '2003-02-01','2004-02-01'),
('TH002', 'Tin hoc hoa 2', 'HANOI', 'NC', '2003-06-04','2004-02-01'),
('DT001', 'Dao tao 1', 'NHATRANG', 'DH', '2002-02-01','2006-02-01'),
('DT002', 'Dao tao 2', 'HANOI', 'DH', '2002-02-01','2006-02-01')
go
select * from dean

ALTER TABLE nhanvien CHECK CONSTRAINT ALL;
ALTER TABLE phancong CHECK CONSTRAINT ALL;

insert into phancong values
('001', 'TH001', 30.0),
('001', 'TH002', 12.5),
('002', 'TH001', 10.0),
('002', 'TH002', 10.0),
('002', 'DT001', 10.0),
('002', 'DT002', 10.0),
('003', 'TH001', 37.5),
('004', 'DT001', 22.5),
('004', 'DT002', 10.0),
('006', 'DT001', 30.5),
('007', 'TH001', 20.0),
('007', 'TH002', 10.0),
('008', 'TH001', 10.0),
('008', 'DT002', 12.5);
go
select * from phancong

DELETE FROM phancong;

insert into thannhan values
('003', '1', 'Tran Minh Tien', 'Nam', '1990-12-11', 'Con'),
('003', '2', 'Tran Ngoc Linh', 'Nu', '1993-03-10', 'Con'),
('003', '3', 'Tran Minh Long', 'Nam', '1957-10-10', 'Vo Chong'),
('001', '1', 'Le Nhat Minh', 'Nam', '1955-04-27', 'Vo Chong'),
('002', '1', 'Le Hoai Thuong', 'Nu', '1960-12-05', 'Vo Chong'),
('004', '1', 'Le Phi Phung', 'Nu', '1972-12-23', 'Vo Chong'),
('005', '1', 'Tran Thu Hong', 'Nu', '1978-04-11', 'Vo Chong'),
('005', '2', 'Nguyen Manh Tam', 'Nam', '2003-01-13', 'Con')
go
select * from thannhan

--Cac cau truy van co ban
--Cau 1
select manv, honv, tenlot, tennv
from nhanvien
where phong = 'NC'

--Cau 2
select manv, honv, tenlot, tennv, phai
from nhanvien
where mluong > 30000;

--Cau 3
select manv, honv, tenlot, tennv, tenphg
from nhanvien, phongban
where phong = maphg and mluong between 2000000 and 3000000

--Cau 4
select honv + ' ' + tenlot + ' ' + tennv as tennhanvien, dchi
from nhanvien
where dchi like '%Tp HCM%'

--Cau 5
select ngsinh, dchi
from nhanvien
where honv = 'Dinh' and tenlot = 'Ba' and tennv = 'Tien'

--Cau 6
select nhanvien.manv, thannhan.tentn, thannhan.ngsinh
from nhanvien, thannhan
where nhanvien.manv = thannhan.manv and datediff(year, thannhan.ngsinh, '2024/11/22')<18 and thannhan.manv like '%001%'

--Cau 7
select manv, phai, ngsinh
from nhanvien
where phai = 'Nu' and datediff(year, ngsinh, '2024/11/22')>30

--Phep ket
--Cau 8
select tenphg, diadiem
from phongban inner join diadiem_phg on phongban.maphg = diadiem_phg.maphg

--Cau 9
select nhanvien.honv+' '+nhanvien.tenlot+' '+nhanvien.tennv as tennguoiquanly, maphg
from nhanvien inner join phongban
on nhanvien.manv = phongban.trphg
and nhanvien.phong = phongban.maphg

--Cau 10
select tenda, mada, ddiem_da, phong, tenphg, maphg, trphg, ngnc
from dean inner join phongban on phong = maphg

--Cau 11
select honv, tenlot, tennv, dchi
from nhanvien inner join phongban on phong = maphg
where tenphg = 'Nghien Cuu'

--Cau 12
select nhanvien.honv, nhanvien.tenlot, nhanvien.tennv, thannhan.tentn
from nhanvien inner join thannhan on nhanvien.manv = thannhan.manv
where nhanvien.phai = 'Nu'

--Cau 13
select nhanvien.manv, nhanvien.tennv
from nhanvien inner join phongban on phong = maphg
			  inner join dean on maphg = dean.phong
			  inner join phancong on dean.mada = phancong.mada
			  and nhanvien.manv = phancong.manv
where phongban.tenphg like '%Nghien Cuu%'
	  and tenda like '%Tin hoc hoa%'
	  and thoidian >=10

--Cau 14
select mada, dean.phong, honv, tenlot, tennv, dchi, ngsinh
from dean inner join phongban on dean.phong = phongban.maphg
		  inner join nhanvien on phongban.maphg = nhanvien.phong
		  and phongban.trphg = nhanvien.manv
where dean.ddiem_da like '%HANOI%'

--Cau 15
select nv.honv+' '+nv.tenlot+' '+nv.tennv as hotennhanvien, ql.honv+' '+ql.tenlot+' '+ql.tennv as hotenquanly
from nhanvien nv inner join nhanvien ql on nv.ma_nql = ql.manv

--Cau 16
select nv.honv+' '+nv.tenlot+' '+nv.tennv as hotennhanvien, pb.maphg, ql.honv+' '+ql.tenlot+' '+ql.tennv as hotennguoiquanly
from nhanvien nv inner join phongban pb on nv.phong = pb.maphg
				 inner join nhanvien ql on pb.trphg = ql.manv

--Cau 17
select honv, tenlot, tennv, tenda
from nhanvien inner join phancong on nhanvien.manv = phancong.manv
			  inner join dean on phancong.mada = dean.mada

--Tim nhan vien khong co than nhan
select *
from nhanvien
where manv not in (select manv from thannhan)

--Gom nhom
--Cau 18
select tenda, sum(thoidian) as tongsogiolamviecmottuan
from dean inner join phancong on dean.mada = phancong.mada
group by tenda

--Cau 19
select honv, tenlot, tennv, count(matn) as soluongthannhan
from nhanvien, thannhan
where nhanvien.manv = thannhan.manv
group by honv, tenlot, tennv

--Cau 20
select tenphg, avg(mluong) as luongtrungbinh
from phongban, nhanvien
where phongban.maphg = nhanvien.phong
group by tenphg

--Cau 21
select phai, avg(mluong) as luongtrungbinh
from nhanvien
where phai = 'Nu'
group by phai

--Cau 22
select tenphg, count(manv) as soluongnhanvien
from phongban, nhanvien
where phongban.maphg = nhanvien.phong
group by tenphg
having avg(mluong)>30000

--Cau truy van long
--Cau 23
select distinct mada
from dean
where mada in (select mada
			   from nhanvien, phancong
			   where nhanvien.manv = phancong.manv and honv = 'Dinh')
   or mada in (select mada
			   from nhanvien, phongban
			   where nhanvien.manv = phongban.trphg and honv = 'Dinh')

--Cau 24
select honv, tenlot, tennv
from nhanvien
where manv in (select manv
			   from thannhan
			   group by manv
			   having count(manv)>2)


--Cau 25
select honv, tenlot, tennv
from nhanvien
where manv not in (select manv from thannhan)

--Cau 26
select honv, tenlot, tennv
from nhanvien
where manv in (select trphg
			   from phongban)
  and manv in (select manv
			   from thannhan)

--Cau 27
select honv
from nhanvien
where manv in (select trphg from phongban)
  and manv not in (select manv from thannhan
			   where quanhe like '%Vo Chong%')

--Cau 28
select honv, tenlot, tennv, mluong
from nhanvien
where mluong > (select avg(mluong)
			   from nhanvien, phongban
			   where nhanvien.phong = phongban.maphg
			   and maphg = 'NC')

--Cau 29
select tenphg, honv+' '+tenlot+' '+tennv as hotentruongphong
from nhanvien inner join phongban on nhanvien.manv = phongban.trphg
where maphg = (select top 1 phong
			   from nhanvien
			   group by phong
			   order by count(*) desc)

--Cau 30
select distinct nhanvien.manv, honv, tenlot, tennv, dchi
from nhanvien inner join phancong on nhanvien.manv = phancong.manv
			  inner join dean on phancong.mada = dean.mada
where ddiem_da = 'HANOI'
and nhanvien.phong in (select phongban.maphg
				 from phongban inner join diadiem_phg on phongban.maphg = diadiem_phg.maphg
				 where diadiem <> 'HANOI')

--Cau 31
select distinct nhanvien.manv, honv, tenlot, tennv, dchi
from nhanvien inner join phancong on nhanvien.manv = phancong.manv
			  inner join dean on phancong.mada = dean.mada
where nhanvien.phong in (select phongban.maphg
				 from phongban inner join diadiem_phg on phongban.maphg = diadiem_phg.maphg
				 where diadiem <> ddiem_da)

--Voi moi nhan vien cho biet ma so, ho ten, so luong de an va tong thoi gian ma ho tham gia
select nhanvien.manv, honv, tenlot, tennv, count(mada) as soluongdean, sum(thoidian) as tongthoigian
from nhanvien inner join phancong on nhanvien.manv = phancong.manv
group by nhanvien.manv, honv, tenlot, tennv

--Cho biet nhung nhan vien tham gia tu 2 de an tro len
select nhanvien.manv, honv, tenlot, tennv, count(mada) as soluongdean
from nhanvien, phancong
where nhanvien.manv = phancong.manv
group by nhanvien.manv, honv, tenlot, tennv
having count(*) >= 2

--Cau 32
select honv, tenlot, tennv
from nhanvien, phancong
where nhanvien.manv = phancong.manv
group by honv, tenlot, tennv
having count(mada) = (select count(mada) from dean)

select honv, tenlot, tennv
from nhanvien
where not exists (select mada
				  from dean
				  except
				  select mada
				  from phancong
				  where phancong.manv = nhanvien.manv)

select *
from nhanvien inner join phongban on nhanvien.phong = phongban.maphg
			  inner join dean on phongban.maphg = dean.phong
			  inner join phancong on nhanvien.manv = phancong.manv and dean.mada = phancong.mada

--Cau 33
select honv, tenlot, tennv
from nhanvien
where not exists (select mada
				  from dean, phongban
				  where dean.phong = phongban.maphg and tenphg like '%Nghien Cuu%'
				  except
				  select pc.mada
				  from phancong pc inner join dean d on pc.mada = d.mada inner join phongban p on d.phong = p.maphg
				  where pc.manv = nhanvien.manv and tenphg like '%Nghien Cuu%')

--Cau 34
select honv, tenlot, tennv
from nhanvien
where not exists(select mada
				 from dean, phongban
				 where dean.phong = phongban.maphg and maphg = nhanvien.phong
				 except
				 select mada
				 from phancong
				 where phancong.manv = nhanvien.manv)