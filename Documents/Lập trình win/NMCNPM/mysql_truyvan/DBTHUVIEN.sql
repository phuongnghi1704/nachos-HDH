create database THUVIEN;

create table NHANVIEN
(
	MANV char(5) NOT NULL,
	HOTEN nvarchar(40) NULL,
	USERNAME varchar(40) NULL unique,
	PASS varchar(40) NULL,
	DIACHI nvarchar(50) NULL,
	NGAYSINH date NULL,
	BANGCAP nvarchar(20) NULL,
	CHUCVU nvarchar(20) NULL,
	BOPHAN nvarchar(20) NULL,
	DIENTHOAI char(15)  NULL,
	primary key (MANV)

); 

create table NV_DIENTHOAI
(
	MANV char(5) NOT NULL,
	DIENTHOAI char(15) NOT NULL,
	primary key(MANV, DIENTHOAI)
);

create table DOCGIA
(
	MADG char(5) NOT NULL,
	HOTEN nvarchar(40) NULL,
	USERNAME varchar(40) NULL unique,
	PASS varchar(40) NULL,
	NGAYSINH date NULL,
	DIACHI nvarchar(40) NULL,
	EMAIL nvarchar(50) NULL,
	LOAI char(5) NULL,
    TIENNO int NULL,
	NGUOILAP char(5) NULL,
	NGAYLAP date NULL,
	primary key (MADG)
);


create table SACH
(
	 MASACH char(5) NOT NULL,
	 TENSACH nvarchar(50) NULL,
	 THELOAI nvarchar(30) NULL,
	 TACGIA nvarchar(40) NULL,
	 NAMXB int NULL,
	 NHAXB nvarchar(40) NULL,
	 TRIGIA float NULL,
	 NGAYNHAP date NULL,
	 NGUOINHAP char(5) NULL,
     TRANGTHAI int NULL,
     
	 primary key (MASACH)
);

create table SACHDANGMUON
(
	MAPHIEU CHAR(5) NOT NULL,
    MASACH CHAR(5) NOT NULL,
    PRIMARY KEY(MAPHIEU,MASACH)
);


create table THONGTINPHIEUMUON
(
	MAPHIEU CHAR(5) NOT NULL,
	MADG char(5) NULL,
	NGAYMUON date NULL,
	NGAYTRA date NULL,
	PHAT float NULL,
	THU float NULL,
	primary key(MAPHIEU)
);





create table MATSACH
(
	MASACH char(5) NOT NULL,
	NGUOIGHINHAN char(5) NULL,
	NGAY date NULL,
	primary key(MASACH)
);


create table THANHLY
(
	MASACH char(5) NOT NULL,
	NGUOITHANHLY char(5) NULL,
    NGAYTHANHLY date NULL,
	LYDO nvarchar(100) NULL,
	primary key(MASACH)
);


alter table NV_DIENTHOAI
add constraint PF_NV_DT
foreign key (MANV)
references NHANVIEN(MANV);

alter table DOCGIA
add constraint PF_DOCGIA_NHANVIEN
foreign key (NGUOILAP)
references NHANVIEN(MANV);

alter table SACH
add constraint PF_SACH_NHANVIEN
foreign key (NGUOINHAP)
references NHANVIEN(MANV);

alter table THONGTINMUON_TRA
add constraint PF_MUONTRA_SACH
foreign key (MASACH)
references SACH(MASACH);

alter table THONGTINMUON_TRA
add constraint PF_MUONTRA_DOCGIA
foreign key (MADG)
references DOCGIA(MADG);

alter table TIENNO
add constraint PF_TIENNO_DOCGIA
foreign key (DOCGIA)
references DOCGIA(MADG);

alter table MATSACH
add constraint PF_MATSACH_SACH
foreign key (MASACH)
references SACH(MASACH);

alter table MATSACH
add constraint PF_MATSACH_NHANVIEN
foreign key (NGUOIGHINHAN)
references NHANVIEN(MANV);

alter table THANHLY
add constraint PF_THANHLY_SACH
foreign key (MASACH)
references SACH(MASACH);

alter table THANHLY
add constraint PF_THANHLY_NHANVIEN
foreign key (NGUOITHANHLY)
references NHANVIEN(MANV);


alter table NHANVIEN
add constraint C_BANGCAP
check(BANGCAP in(N'Tú Tài', N'Trung Cấp', N'Cao Đẳng', N'Đại Học', N'Thạc Sĩ', N'Tiến Sĩ'));

alter table NHANVIEN
add constraint C_BOPHAN
check(BOPHAN in(N'Thủ Thư', N'Thủ Kho', N'Thủ Quỹ', N'Ban Giám Đốc'));

alter table NHANVIEN
add constraint C_CHUCVU
check(CHUCVU in(N'Giám Đốc',N'Phó Giám Đốc', N'Trưởng Phòng', N'Phó Phòng', N'Nhân Viên'));


alter table THANHLY
add constraint C_LYDO
check(LYDO in(N'Mất', N'Hư Hỏng', N'Người Dùng Làm Mất'));



insert into NHANVIEN values ('0001',N'Nguyễn Hoài An','An Nguyen','An1234',N'25/3 Lạc Long Quân, Q.10, TP HCM','1973-02-15',N'Tú Tài',N'Nhân Viên',N'Thủ Thư');
insert into NHANVIEN values ('0002',N'Trần Trà Hương','Huong','123Huong4',N'125 Trần Hưng Đạo, Q.1, TP HCM','1960-06-20',N'Thạc Sĩ',N'Trưởng Phòng',N'Thủ Quỹ');
insert into NHANVIEN values ('0003',N'Nguyễn Ngọc Ánh','Ngoc Anh','Anh125',N'12/21 Võ Văn Ngân Thủ Đức, TP HCM','1975-05-11',N'Tiến Sĩ',N'Giám Đốc',N'Ban Giám Đốc');
insert into NHANVIEN values ('0004',N'Trương Nam Sơn','Son Truong','sontruong1',N'215 Lý Thường Kiệt, TP Biên Hòa','1959-06-20',N'Đại Học',N'Phó Phòng',N'Thủ Quỹ');
insert into NHANVIEN values ('0005',N'Lý Hoàng Hà','Hoang Ha','ha1010',N'22/5 Nguyễn Văn Xí, Q.Bình Thạnh, TP HCM','1954-10-23',N'Cao Đẳng',N'Nhân viên',N'Thủ Kho');
insert into NHANVIEN values ('0006',N'Trần Bạch Tuyết','Tran Tuyet','tuyet121',N'127 Hùng Vương,TP Mỹ Tho','1980-05-20',N'Thạc Sĩ',N'Phó Giám Đốc',N'Ban Giám Đốc');
insert into NHANVIEN values ('0007',N'Nguyễn An Trung','Trung An','an345',N'234 3/2, TP Biên Hòa','1976-06-05',N'Trung Cấp',N'Nhân Viên',N'Thủ Thư');
insert into NHANVIEN values ('0008',N'Trần Trung Hiếu','Hieu Tran','HieuTran',N'22/11 Lý Thường Kiệt, Tp Mỹ Tho','1977-08-06',N'Tú Tài',N'Phó Phòng',N'Thủ Kho');
insert into NHANVIEN values ('0009',N'Trần Hoàng Nam','HNam','HoangNam',N'234 Trần Não, An Phú, TP HCM','1975-11-22',N'Đại Học',N'Trưởng Phòng',N'Thủ Thư');
insert into NHANVIEN values ('0010',N'Phạm Nam Thanh','Nam Thanh','ThanhThanh',N'221 Hùng Vương, Q.5, TP HCM','1980-12-12',N'Cao Đẳng',N'Phó Phòng',N'Thủ Thư');


insert into NV_DIENTHOAI values ('0001','01789032061');
insert into NV_DIENTHOAI values ('0001','0723482919');
insert into NV_DIENTHOAI values ('0002','0723843927');
insert into NV_DIENTHOAI values ('0003','0394830283');
insert into NV_DIENTHOAI values ('0003','0356283824');
insert into NV_DIENTHOAI values ('0004','0832340247');
insert into NV_DIENTHOAI values ('0005','0782983012');
insert into NV_DIENTHOAI values ('0006','0892017392');
insert into NV_DIENTHOAI values ('0006','0950385784');
insert into NV_DIENTHOAI values ('0007','0902827923');
insert into NV_DIENTHOAI values ('0008','0892028492');
insert into NV_DIENTHOAI values ('0008','0718290283');
insert into NV_DIENTHOAI values ('0009','0923764922');
insert into NV_DIENTHOAI values ('0009','0787281022');
insert into NV_DIENTHOAI values ('0010','0232834492');
insert into NV_DIENTHOAI values ('0010','0821011102');
insert into NV_DIENTHOAI values ('0010','01232893400');


insert into DOCGIA values ('0001',N'Nguyễn Văn Hùng','Hung Hung','Hung123','1995-01-20',N'123,Trần Hưng Đạo,Q.1,TP HCM',N'Hung@gmail.com','Y','0001','2016-11-10');
insert into DOCGIA values ('0002',N'Nguyễn Thu Hương','Thu Huong','HuongH23','1981-02-03',N'20/2 Nguyễn Trãi,Q.5,TP HCM',N'ThuHuong@gmail.com','X','0001','2011-01-26');
insert into DOCGIA values ('0003',N'Nguyễn Thi Hạnh','THanh','Hanh3002','1990-01-28',N'30/4 Thị Nghè, Q.1,TP HCM',N'Hanh123@gmail.com','Y','0007','2015-01-10');
insert into DOCGIA values ('0004',N'Trần Minh Thông','Thông Minh','Thong909','1998-03-20',N'155 Lê Văn Việt,Q.9,TP HCM',N'MinhThong@gmail.com','X','0009','2017-12-23');
insert into DOCGIA values ('0005',N'Lê Thiện Thuật','Thien Thuat','ThuatTh','1999-09-24',N'45/7 Hồ Hảo Hớn, Bình Dương',N'Thuat424g@gmail.com','Y','0010','2018-10-09');
insert into DOCGIA values ('0006',N'Mai Lan Vy','Vy Vy','VyMAI','2001-05-06',N'111/5Hùng Vương, Biên Hòa',N'lanVy1@gmail.com','Y','0007','2016-11-05');
insert into DOCGIA values ('0007',N'Chế Thị Lan','Hoa Lan','LinhLan','1975-10-02',N'2/5 Phú Nhuận,TP HCM',N'lan342@gmail.com','X','0001','2018-03-01');
insert into DOCGIA values ('0008',N'Nguyễn An','An Nguyen','An456','1988-08-21',N'607/8 Trần Phú, Q.Tân Phú, TP HCM',N'AnBinh@gmail.com','X','0007','2017-05-15');
insert into DOCGIA values ('0009',N'Thanh Thế Anh','The Anh','Anh001','1992-04-03',N'255 Nguyễn Thị Nghĩa, Q.1,TP HCM',N'Anh909@gmail.com','X','0007','2018-06-19');
insert into DOCGIA values ('0010',N'Đỗ Kim Oanh','Oanh Do','DoDo1','1993-03-13',N'23/1 Lê Lai, Mỹ Tho',N'Kim054@gmail.com','Y','0009','2010-08-27');


insert into SACH values ('0001',N'Đất Rừng Phương Nam',N'Truyện Dài','Đoàn Giỏi','2012',N'Nhà xuất bản Văn học Quốc gia',120000.0,'2015-02-02','0005');
insert into SACH values ('0002',N'Món ăn Việt Nam',N'Ký sự','Nguyễn Văn Nam','2017',N'Nhà xuất bản Giáo Dục',90000.0,'2018-12-03','0008');
insert into SACH values ('0003',N'Đất và Người',N'Truyện Ngắn','Lê Trọng Cầu','2014',N'Nhà xuất bản Kim Đồng',45000.0,'2016-03-20','0005');
insert into SACH values ('0004',N'Hạt giống tâm hồn',N'Tâm lý','Minh Tuân','2015',N'Nhà xuất bản Văn học Quốc gia',20000.0,'2017-09-10','0008');
insert into SACH values ('0005',N'Hệ điều hành',N'Khoa học','Lê Ngọc Sơn','2015',N'Nhà xuất bản Giáo dục',65000.0,'2016-03-02','0008');
insert into SACH values ('0006',N'Cây chuối non đi giày xanh',N'Truyện Dài','Nguyễn Ngọc Ánh','2017',N'Nhà xuất bản Kim Đồng',125000.0,'2018-04-27','0005');
insert into SACH values ('0007',N'Lịch sử văn học',N'Giáo dục','Nguyễn Công Văn','2015',N'Nhà xuất bản Văn học Quốc gia',220000.0,'2016-05-04','0008');
insert into SACH values ('0008',N'Niềm Đam Mê',N'Kĩ Năng','Minh Huê','2017',N'Nhà xuất bản Văn Hóa',210000,'2017-03-10','0003');
insert into SACH values ('0009',N'Khát vọng',N'Tâm Lý','Đỗ Minh Lâm','2016',N'Nhà xuất bản Văn học Quốc gia',920000.0,'2018-03-04','0008');



insert into THONGTINMUON_TRA values (1,'0001','0004','2018-09-09','2018-09-25',0,0);
insert into THONGTINMUON_TRA values (2,'0003','0002','2018-02-12','2018-03-09',14000,14000);
insert into THONGTINMUON_TRA values (3,'0002','0004','2018-09-09','2018-09-25',0,0);
insert into THONGTINMUON_TRA values (4,'0006','0001','2018-07-08','2018-09-25',45000,20000);
insert into THONGTINMUON_TRA values (5,'0002','0002','2017-02-03','2017-03-02',32000,0);
insert into THONGTINMUON_TRA values (6,'0009','0007','2018-05-09','2018-06-12',23000,23000);
insert into THONGTINMUON_TRA values (7,'0005','0009','2017-04-02','2017-04-25',0,0);
insert into THONGTINMUON_TRA values (8,'0006','0009','2018-04-02','2018-04-26',1000,1000);
insert into THONGTINMUON_TRA values (9,'0010','0008','2018-01-10','2018-02-01',3000,3000);
insert into THONGTINMUON_TRA values (10,'0008','0003','2018-02-06','2018-03-25',31000,12000);
insert into THONGTINMUON_TRA values (11,'0002','0001','2017-08-12','2017-09-25',19000,19000);


insert into TIENNO values ('0001',1,23000.0);
insert into TIENNO values ('0001',2,30000.0);
insert into TIENNO values ('0003',1,50000.0);
insert into TIENNO values ('0002',1,2000.0);
insert into TIENNO values ('0002',2,30000.0);
insert into TIENNO values ('0003',2,50000.0);
insert into TIENNO values ('0002',3,45000.0);
insert into TIENNO values ('0004',1,43000.0);
insert into TIENNO values ('0005',1,90000.0);
insert into TIENNO values ('0005',2,28000.0);
insert into TIENNO values ('0006',1,49000.0);
insert into TIENNO values ('0007',1,34000.0);
insert into TIENNO values ('0007',2,50000.0);
insert into TIENNO values ('0009',1,100000.0);
insert into TIENNO values ('0010',1,10000.0);


insert into MATSACH values ('0001','0007','2018-10-03');
insert into MATSACH values ('0003','0009','2017-01-26');
insert into MATSACH values ('0005','0007','2018-02-19');
insert into MATSACH values ('0002','0001','2018-09-13');
insert into MATSACH values ('0009','0010','2017-08-30');
insert into MATSACH values ('0004','0001','2018-02-01');
insert into MATSACH values ('0008','0007','2017-08-15');


insert into THANHLY values ('0001','0005',N'Mất');
insert into THANHLY values ('0004','0008',N'Mất');
insert into THANHLY values ('0003','0008',N'Người Dùng Làm Mất');
insert into THANHLY values ('0002','0005',N'Hư Hỏng');
insert into THANHLY values ('0009','0008',N'Hư Hỏng');
insert into THANHLY values ('0005','0005',N'Mất');
insert into THANHLY values ('0007','0005',N'Người Dùng Làm Mất');
insert into THANHLY values ('0008','0008',N'Hư Hỏng')