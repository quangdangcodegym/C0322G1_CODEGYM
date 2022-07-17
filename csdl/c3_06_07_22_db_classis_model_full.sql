# Kieu du lieu boolean?
/**
	Khi định nghĩa cấu trúc bảng: gioitinh boolean
    Nhưng csdl lưu sẽ là TINYINT(1)
**/

SELECT * FROM classicmodels.customers;
SET GLOBAL log_bin_trust_function_creators = 1;
# VAN DE 1: ----------------------------------------------------------
# Cau lenh exits va not exists
# Test thử câu lệnh exist và not exists: select (not exists (SELECT * FROM customers WHERE phone like '40.32.2555'));

delimiter //
DROP FUNCTION IF EXISTS checkExistPhone;
delimiter //
create function checkExistPhone(phonenumber varchar(50))
RETURNS BOOLEAN
begin
	Declare result BOOLEAN;
    set result = false;
	if(NOT EXISTS (SELECT * FROM customers WHERE phone like phonenumber)) then
 		set result = false;
         else 
         set result = true;
     end if;
    return result;
end; //

# VAN DE 2: ----------------------------------------------------------
# Hien thi ra danh sach country: dung distinct
# SELECT DISTINCT city FROM classicmodels.customers;
# Test thử city = 'Nantes' có nằm trong danh sách country
# select ('Nantes' in (SELECT DISTINCT city FROM classicmodels.customers));
delimiter //
DROP FUNCTION IF EXISTS checkCityCorrect; //
delimiter //
create function checkCityCorrect(country varchar(50))
RETURNS BOOLEAN
begin
	Declare result BOOLEAN;
    set result = false;
	if(country in  (SELECT DISTINCT city FROM classicmodels.customers)) then
 		set result = true;
         else 
         set result = false;
     end if;
    return result;
end; //

#-------------------------
# Viet 1 store them 1 customers vao bang customer
#INSERT INTO `classicmodels`.`customers` 
(`customerNumber`, `customerName`, `contactLastName`, `contactFirstName`, 
`phone`, `addressLine1`, `city`, `country`, `creditLimit`) VALUES 
('497', 'Quang', 'Dang', 'Van', '04999999', 'Hue', 'Hue', 'Hue', '12.00');

delimiter //
create procedure insertCustomer(
    in cName varchar(50),
    in cLastName varchar(50),
    in cFirstName varchar(50),
    in cPhone varchar(50),
    in cAddressLine1 varchar(50),
    in cCity varchar(50),
    in cCountry varchar(50),
    in cCreditLimit decimal(10,2),
    out message varchar(50)
)
begin
	# phone: 40.32.2555 ton tai
    # country: HUE
	declare maxNumber integer;
    declare flag Boolean;

    set maxNumber = (SELECT max(customerNumber) FROM classicmodels.customers) + 1;
    if(exists (select phone from customers where phone = cPhone)) then
		set message = 'Da ton tai so dien thoai';
    end if;
    if(cCountry not in (SELECT distinct country FROM classicmodels.customers)) then
		set message = 'Chua ton tai country';
    end if;
    if(not exists (select phone from customers where phone = cPhone) and cCountry  in (SELECT distinct country FROM classicmodels.customers)) then
		INSERT INTO `classicmodels`.`customers` (`customerNumber`, `customerName`, `contactLastName`, `contactFirstName`, 
        `phone`, `addressLine1`, `city`, `country`, `creditLimit`) VALUES 
        (maxNumber, cName, cLastName, cFirstName, cPhone, cAddressLine1, cCity, cCountry, cCreditLimit);
    end if;
    
end
//
# Nhap vao 1 so dien thoai, kiem tra coi sdt co ton tai trong bang chua
# Thong bao ra message
delimiter //
create procedure checkPhoneExits(
	IN phoneNumber varchar(50),
    OUT message varchar(50)
)
begin
	-- if(exists (SELECT * FROM classicmodels.customers where phone = phoneNumber)) then
-- 		set message = 'Da ton tai';
-- 	else
-- 		set message = 'Khong ton tai';
--     end if;
	declare test Boolean;
    set test = (SELECT count(phone) FROM classicmodels.customers where phone = phoneNumber);
    if(test = true) then
		set message = 'Da ton tai';
        else
        set message = 'Khong ton tai';
    end if;
end; //

