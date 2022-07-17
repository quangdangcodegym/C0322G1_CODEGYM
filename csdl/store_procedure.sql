#-----------------------------------Create funtion
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
CREATE FUNCTION Sum_Ab(a Integer, b Integer) RETURNS Integer
Begin
   return a + b;
End; //
#------------------------------------Create with declare and set variable
DELIMITER $$
Create Function My_Sum(P_a Float, p_B Float) returns Float
Begin  
 -- Khai báo một biến Float
  Declare v_C Float;
  -- Sét giá trị cho biến v_C
  Set V_C = p_A + p_B;
  -- Giá trị trả về của hàm.
  return v_C;
End; $$

#------------------------------------Create 
DELIMITER //
CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers;
END //

DELIMITER ;
call findAllCustomers();
DELIMITER //
DROP PROCEDURE IF EXISTS `findAllCustomers`//
CREATE PROCEDURE findAllCustomers()
BEGIN
SELECT * FROM customers where customerNumber = 175;
END //
DELIMITER ;

call findAllCustomers();
#-----------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE getCusById (IN cusNum INT(11))
BEGIN
  SELECT * FROM customers WHERE customerNumber = cusNum;
END //
DELIMITER ;
call getCusById(175);
#-------------------GetCustomersCountByCity type1-----------------------------------------------------
DELIMITER //
CREATE PROCEDURE GetCustomersCountByCity(
    IN  in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END//
DELIMITER ;
CALL GetCustomersCountByCity('Lyon',@total);
SELECT @total;
#-------------------GetCustomersCountByCity type2-----------------------------------------------------
DELIMITER //
CREATE PROCEDURE GetCustomersCountByCityType2(
    IN  in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    set total = (SELECT COUNT(customerNumber)
    FROM customers
    WHERE city = in_city);
END//
DELIMITER ;
CALL GetCustomersCountByCity('Lyon',@total);
SELECT @total;
#-------------------Drop store procedured type2-----------------------------------------------------

drop procedure if exists GetCustomersCountByCityType2;
DELIMITER //
CREATE PROCEDURE GetCustomersCountByCityType2(
    IN  in_city VARCHAR(50),
    OUT total INT
)
BEGIN
	if(in_city = 'Nantes')
		then
        set total = -1;
    else
		set total = (SELECT COUNT(customerNumber)
		FROM customers
		WHERE city = in_city);
    end if;
END//
DELIMITER ;
CALL GetCustomersCountByCity('Lyon',@total);
SELECT @total;
#------------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END//

DELIMITER ;

SET @counter = 1;
CALL SetCounter(@counter,1); 
CALL SetCounter(@counter,1); 
CALL SetCounter(@counter,5); 
SELECT @counter; 


#----------------------------------------------------------------------
#create store 
DELIMITER $$
CREATE PROCEDURE sp_insert_product(
	IN title_in NVARCHAR(255),
    IN price_in DECIMAL(12,0),
    IN url_image_in NVARCHAR(255),
    IN quantity_in INT,
    IN id_category_in INT,
	OUT success TINYINT(1),
    OUT message NVARCHAR(255)
)
BEGIN
	SET success = FALSE;
    IF(price_in < 0 OR price_in > 999999999999)
		THEN
			SET message = "Giá Tiền Nhập Vào Không Hợp Lệ";
	ELSE
		IF(quantity_in < 0)
			THEN
				SET message = "Số Lượng Nhập Vào Không Hợp Lệ";
	ELSE
		IF(NOT EXISTS (SELECT * FROM category WHERE id = id_category_in))
			THEN
				SET message = "Danh Mục Không Tồn Tại";
	ELSE
		INSERT INTO `db_case_md3`.`product` (`title`, `url_image`, `price`, `quantity`, `created_at`, `stop_selling`, `id_category`) 
        VALUES (title_in, url_image_in, price_in, quantity_in, NOW(), '0', id_category_in);
        SET message = "Thêm Sản Phẩm Thành Công";
        SET success = TRUE;
					END IF;
			END IF;
	END IF;
END
$$

#----------------------------------------------------------------------
#update store
DELIMITER $$
CREATE PROCEDURE sp_update_product(
	IN id_in INT,
	IN title_in NVARCHAR(255),
    IN price_in DECIMAL(12,0),
    IN url_image_in NVARCHAR(255),
    IN quantity_in INT,
    IN id_category_in INT,
	OUT success TINYINT(1),
    OUT message NVARCHAR(255)
)
BEGIN
	SET success = FALSE;
    IF(price_in < 0)
		THEN
			SET message = "Giá Tiền Nhập Vào Không Hợp Lệ";
	ELSE
		IF(price_in > 999999999999)
			THEN
				SET  message = "Giá Tiền Nhập Vào Không Hợp Lệ";
	ELSE
		IF(quantity_in < 0)
			THEN
				SET message = "Số Lượng Nhập Vào Không Hợp Lệ";
	ELSE
		IF(NOT EXISTS (SELECT * FROM product WHERE id = id_in))
			THEN
				SET message = "Sản Phẩm Không Tồn Tại";
	ELSE
		IF(NOT EXISTS (SELECT * FROM category WHERE id = id_category_in))
			THEN
				SET message = "Danh Mục Không Tồn Tại";
	ELSE
		UPDATE `db_case_md3`.`product` 
        SET `title` = title_in, 
			`url_image` = url_image_in, 
			`price` = price_in, 
			`quantity` = quantity_in,
			`updated_at` = NOW(), 
			`id_category` = id_category_in
        WHERE (`id` = id_in);
        SET message = "Sửa Thông Tin Sản Phẩm Thành Công";
        SET success = TRUE;
									END IF;
							END IF;
					END IF;
			END IF;
	END IF;
END
$$






