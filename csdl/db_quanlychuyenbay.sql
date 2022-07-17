#create database QL_ChuyenBay;
CREATE DATABASE IF NOT EXISTS QL_ChuyenBay;
use QL_ChuyenBay;

-- Tạo bảng KHACHHANG
create table KHACHHANG
(
 MAKH nvarchar(15),
 TEN nvarchar(15),
 DCHI nvarchar(50),
 DTHOAI nvarchar(12),
 primary key (MAKH)
);

-- Tạo bảng NHANVIEN
create table NHANVIEN
(
 MANV nvarchar(15),
 TEN nvarchar(15),
 DCHI nvarchar(50),
 DTHOAI nvarchar(12),
 LUONG float,
 LOAINV bit,
 primary key (MANV)
);

-- Tạo bảng LOAIMB
create table LOAIMB
(
 MALOAI nvarchar(15),
 HANGSX nvarchar(15),
 primary key (MALOAI)
);
-- Tạo bảng MAYBAY
create table MAYBAY
( 
 SOHIEU int,
 MALOAI nvarchar(15),
 primary key (SOHIEU, MALOAI)
);

-- Tạo bảng chuyến bay
create table CHUYENBAY
(
 MACB nvarchar(4),
 SBDI nvarchar(3),
 SBDEN nvarchar(3),
 GIODI time,

 GIODEN time,
 primary key (MACB)
);

-- Tạo bảng LICHBAY
create table LICHBAY
(
 NGAYDI datetime,
 MACB nvarchar(4),
 SOHIEU int,
 MALOAI nvarchar(15),
 primary key (NGAYDI, MACB)
);

-- Tạo bảng DATCHO
create table DATCHO
(
 MAKH nvarchar(15),
 NGAYDI datetime,
 MACB nvarchar(4),
 primary key(MAKH, NGAYDI, MACB)
);

-- Tạo bảng KHANANG
create table KHANANG
(
 MANV nvarchar(15),
 MALOAI nvarchar(15),
 primary key (MANV, MALOAI)
);


-- Tạo bảng PHANCONG
create table PHANCONG
(
 MANV nvarchar(15),
 NGAYDI datetime,
 MACB nvarchar(4),
 primary key (MANV, NGAYDI, MACB)
);


-- Tạo khóa ngoại cho bảng MAYBAY tham chiếu khóa chính của các table khác
 -- tham chiếu đến table LOAIMB
 alter table MAYBAY
 add constraint THUOC
 foreign key(MALOAI)
 references LOAIMB(MALOAI) ;

-- Tạo khóa ngoại cho bảng LICHBAY tham chiếu đến khóa chính của các table khác
 -- Tham chiếu MACB của table CHUYENBAY
 alter table LICHBAY
 add constraint BAY
 foreign key (MACB)
 references CHUYENBAY(MACB);
 -- Tham chiếu SOHIEU, MALOAI của table MAYBAY
 alter table LICHBAY
 add constraint DINHDANH
 foreign key(SOHIEU, MALOAI)
 references MAYBAY(SOHIEU, MALOAI);

-- Tạo khóa ngoại cho table DATCHO tham chiếu đến khóa chính của các table khác
 -- Tham chiếu MAKH của table KHACHHANG
 alter table DATCHO
 add constraint DOITUONG
 foreign key (MAKH)
 references KHACHHANG(MAKH);

 -- Tham chiếu NGAYDI VÀ MACB của table LICHBAY
 alter table DATCHO
 add constraint PHUONGTIEN1
 foreign key (NGAYDI, MACB)
 references LICHBAY(NGAYDI, MACB);

-- Tạo khóa ngoại cho tablr KHANANG
 -- Tham chiếu MANV của table NHANVIEN
 alter table KHANANG
 add constraint PHUCVU
 foreign key (MANV)
 references NHANVIEN(MANV);
 -- Tham chiếu MALOAI của table LOAIMB
 alter table KHANANG
 add constraint T
 foreign key (MALOAI)
 references LOAIMB(MALOAI);
-- Tạo khóa ngoại cho table PHANCONG
 -- Tham chiếu MANV đến table NHANVIEN
 alter table PHANCONG
 add constraint NV
 foreign key (MANV)
 references NHANVIEN(MANV);
 --  Tham chiếu NGAYDI và MACB đến table LICHBAY
 alter table PHANCONG
 add constraint NV2
 foreign key( NGAYDI, MACB)
 references LICHBAY(NGAYDI, MACB);

 
 -- Nhập dữ liệu cho tablE KHACHHANG
 insert into KHACHHANG values ('0009',  'Nga', '223 Nguyen Trai', '8932220');
 insert into KHACHHANG values ('0101',  'Anh', '567 Tran Phu', '8826729');
 insert into KHACHHANG values ('0045',  'Thu', '285 Le Loi', '8932203');
 insert into KHACHHANG values ('0012',  'Ha', '435 Quang Trung', '8933232');
 insert into KHACHHANG values ('0238',  'Hung', '456 Pasteur', '9812101');
 insert into KHACHHANG values ('0397',  'Thanh', '234 Le Van Sy', '8952943');
 insert into KHACHHANG values ('0582',  'Mai', '789 Nguyen Du', null);
 insert into KHACHHANG values ('0934',  'Minh', '678 Le Lai', null);
 insert into KHACHHANG values ('0091',  'Hai', '345 Hung Vuong', '8893223');
 insert into KHACHHANG values ('0314',  'Phuong', '385 Vo Van Tuan', '8232320');
 insert into KHACHHANG values ('0613',  'Vu', '348 CMT8', '8343232');
 insert into KHACHHANG values ('0586',  'Son', '123 Bach Dang', '8556223');
 insert into KHACHHANG values ('0422',  'Tien', '75 Nguyen Thong', '8332222');


 ##Nhập dữ liệu cho table CHUYENBAY
 insert into CHUYENBAY values ('100', 'SLC', 'BOS', '08:00','17:59' );
 insert into CHUYENBAY values ('112', 'DCA', 'DEN', '14:00','18:07' );
 insert into CHUYENBAY values ('121', 'STL', 'SLC', '07:00','9:13' );
 insert into CHUYENBAY values ('122', 'STL', 'YYV', '08:30','10:19' );
 insert into CHUYENBAY values ('206', 'DFW', 'STL', '09:00','11:40' );
 insert into CHUYENBAY values ('330', 'JFK', 'YYV', '16:00','18:53' );
 insert into CHUYENBAY values ('334', 'ORD', 'MIA', '12:00','14:14' );
 insert into CHUYENBAY values ('335', 'MIA', 'ORD', '15:00','17:14' );
 insert into CHUYENBAY values ('336', 'ORD', 'MIA', '18:00','20:14' );
 insert into CHUYENBAY values ('337', 'MIA', 'ORD', '20:30','23:53' );
 insert into CHUYENBAY values ('394', 'DFW', 'MIA', '19:00','21:30' );
 insert into CHUYENBAY values ('395', 'MIA', 'DFW', '21:00','23:43' );
 insert into CHUYENBAY values ('449', 'CDG', 'DEN', '10:00','19:29' );
 insert into CHUYENBAY values ('930', 'YYV', 'DCA', '13:00','16:10' );
 insert into CHUYENBAY values ('931', 'DCA', 'YYV', '17:00','18:10' );
 insert into CHUYENBAY values ('932', 'DCA', 'YYV', '18:00','19:10' );
 insert into CHUYENBAY values ('991', 'BOS', 'ORD', '17:00','18:22' );


 -- Nhập dữ liệu cho table LOAIMB
 insert into LOAIMB values  ('A310','Airbus');
 insert into LOAIMB values ('A320', 'Airbus');
 insert into LOAIMB values ('A330', 'Airbus');
 insert into LOAIMB values ('A340', 'Airbus');
 insert into LOAIMB values ('B727', 'Boeing');
 insert into LOAIMB values ('B747', 'Boeing');
 insert into LOAIMB values ('B757', 'Boeing');
 insert into LOAIMB values ('DC10', 'MD');
 insert into LOAIMB values ('DC9', 'MD');
 -- Nhập dữ liệu cho table NHANVIEN

 insert into NHANVIEN values ('1006', 'Chi', '12/6  Nguyen Kiem', '8120022', 150000, 0);
 insert into NHANVIEN values ('1005', 'Giao', '65 Nguyen Thai Son', '8324467', 500000, 0);
 insert into NHANVIEN values ('1001', 'Huong', '8 Dien Bien Phu', '8330733', 500000, 1);
 insert into NHANVIEN values ('1002', 'Phong', '1 Ly Thuong Kiet', '8308117', 150000, 1);
 insert into NHANVIEN values ('1004', 'Phuong', '351 Lac Long Quan', '8308155', 250000, 0);
 insert into NHANVIEN values ('1003', 'Quang', '78 Truong Dinh', '8324461', 350000, 1);
 insert into NHANVIEN values ('1007', 'Tam', '36 Nguyen Van Cu', '8458188', 500000, 0);

 

 -- Nhập dữ liệu cho table KHANANG
 insert into KHANANG values ('1001', 'B727');
 insert into KHANANG values ('1001', 'B747');
 insert into KHANANG values ('1001', 'DC10');
 insert into KHANANG values ('1001', 'DC9');
 insert into KHANANG values ('1002', 'A320');
 insert into KHANANG values ('1002', 'A340');
 insert into KHANANG values ('1002', 'B757');
 insert into KHANANG values ('1002', 'DC9');
 insert into KHANANG values ('1003', 'A310');
 insert into KHANANG values ('1003', 'DC9');


 -- Nhập dữ liệu cho table MAYBAY
 insert into MAYBAY VALUES (10, 'B747');
 insert into MAYBAY VALUES (11, 'B727');
 insert into MAYBAY VALUES (13, 'B727');
 insert into MAYBAY VALUES (13, 'B747');
 insert into MAYBAY VALUES (21, 'DC10');
 insert into MAYBAY VALUES (21, 'DC9');
 insert into MAYBAY VALUES (22, 'B757');
 insert into MAYBAY VALUES (22, 'DC9');
 insert into MAYBAY VALUES (23, 'DC9');
 insert into MAYBAY VALUES (24, 'DC9');
 insert into MAYBAY VALUES (70, 'A310');
 insert into MAYBAY VALUES (80, 'A310');
 insert into MAYBAY VALUES (93, 'B757');
 

 -- Nhập dữ liệu cho table LICHBAY 

 insert into LICHBAY values ('2000-11-01', '100', 80, 'A310');
 insert into LICHBAY values ('2000-11-01', '112', 21, 'DC10');
 insert into LICHBAY values ('2000-11-01', '206', 22, 'DC9');
 insert into LICHBAY values ('2000-11-01', '334', 10, 'B747');
 insert into LICHBAY values ('2000-11-01', '395', 23, 'DC9');
 insert into LICHBAY values ('2000-11-01', '991', 22, 'B757');
 insert into LICHBAY values ('2000-11-01', '337', 10, 'B747');
 insert into LICHBAY values ('2000-10-31', '100', 11, 'B727');
 insert into LICHBAY values ('2000-10-31', '112', 11, 'B727');
 insert into LICHBAY values ('2000-10-31', '206', 13, 'B727');
 insert into LICHBAY values ('2000-10-31', '334', 10, 'B747');
 insert into LICHBAY values ('2000-10-31', '335', 10, 'B747');
 insert into LICHBAY values ('2000-10-31', '337', 24, 'DC9');
 insert into LICHBAY values ('2000-10-31', '449', 70, 'A310');


 -- Nhập dữ liệu cho table DATCHO
 insert  into DATCHO values ('0009', '2000-11-01', 100);
 insert  into DATCHO values ('0009', '2000-10-31', 449);
 insert  into DATCHO values ('0045', '2000-11-01', 991);
 insert  into DATCHO values ('0012', '2000-10-31', 206);
 insert  into DATCHO values ('0238', '2000-10-31', 334);
 insert  into DATCHO values ('0582', '2000-11-01', 991);
 insert  into DATCHO values ('0091', '2000-11-01', 100);
 insert  into DATCHO values ('0314', '2000-10-31', 449);
 insert  into DATCHO values ('0613', '2000-11-01', 100);
 insert  into DATCHO values ('0586', '2000-11-01', 991);
 insert  into DATCHO values ('0586', '2000-10-31', 100);
 insert  into DATCHO values ('0422', '2000-10-31', 449);
 
 
 -- Nhập dữ liệu cho table PHANCONG
 insert into PHANCONG  values ('1001', '2000-11-01', '100');
 insert into PHANCONG  values ('1001', '2000-10-31', '100');
 insert into PHANCONG  values ('1002', '2000-11-01', '100');
 insert into PHANCONG  values ('1002', '2000-10-31', '100');
 insert into PHANCONG  values ('1003', '2000-10-31', '100');
 insert into PHANCONG  values ('1003', '2000-10-31', '337');
 insert into PHANCONG  values ('1004', '2000-10-31', '100');
 insert into PHANCONG  values ('1004', '2000-10-31', '337');
 insert into PHANCONG  values ('1005', '2000-10-31', '337');
 insert into PHANCONG  values ('1006', '2000-11-01', '991');
 insert into PHANCONG  values ('1006', '2000-10-31', '337');
 insert into PHANCONG  values ('1007', '2000-11-01', '112');
 insert into PHANCONG  values ('1007', '2000-11-01', '991');
 insert into PHANCONG  values ('1007', '2000-10-31', '206');
 
 
 