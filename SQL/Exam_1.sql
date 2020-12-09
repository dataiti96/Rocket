DROP DATABASE IF EXISTS EXAM_1;
CREATE DATABASE EXAM_1;
USE EXAM_1;

create table CUSTOMER (
	CustomerID INT PRIMARY KEY,
	`Name` VARCHAR(50),
	Phone VARCHAR(50),
	Email VARCHAR(50),
	Address VARCHAR(50),
	Note VARCHAR(50)
);
insert into CUSTOMER (CustomerID, Name, Phone, Email, Address, Note) values (1, 'Gaylord Kleinmintz', '155-817-8313', 'gkleinmintz0@mit.edu', '73997 Talmadge Pass', 'repurpose collaborative synergies');
insert into CUSTOMER (CustomerID, Name, Phone, Email, Address, Note) values (2, 'Rodrique Chaplain', '345-712-2287', 'rchaplain1@usa.gov', '811 Knutson Circle', 'drive synergistic infomediaries');
insert into CUSTOMER (CustomerID, Name, Phone, Email, Address, Note) values (3, 'Davidson Magrannell', '244-953-3926', 'dmagrannell2@hao123.com', '6 Pennsylvania Court', 'iterate magnetic web-readiness');
insert into CUSTOMER (CustomerID, Name, Phone, Email, Address, Note) values (4, 'Em Mattes', '221-543-9999', 'emattes3@cisco.com', '92082 Oriole Crossing', 'benchmark strategic infomediaries');
insert into CUSTOMER (CustomerID, Name, Phone, Email, Address, Note) values (5, 'Orel Caplis', '807-876-0334', 'ocaplis4@vk.com', '38 Thackeray Avenue', 'innovate best-of-breed convergence');

create table CAR (
	CarID INT PRIMARY KEY,
	Maker VARCHAR(50),
	Model VARCHAR(50),
	`Year` VARCHAR(50),
	Color VARCHAR(50),
	Note VARCHAR(50)
);
insert into CAR (CarID, Maker, Model, Year, Color, Note) values (1, 'Ford', 'Mustang', 1979, 'Table Cloth 62x120 Colour', 'repurpose synergistic action-items');
insert into CAR (CarID, Maker, Model, Year, Color, Note) values (2, 'Dodge', 'Durango', 1998, 'Blouse / Shirt / Sweater', 'recontextualize robust technologies');
insert into CAR (CarID, Maker, Model, Year, Color, Note) values (3, 'Mercedes-Benz', 'SL-Class', 1999, 'Sprouts - Bean', 'benchmark scalable content');
insert into CAR (CarID, Maker, Model, Year, Color, Note) values (4, 'Chevrolet', 'Corvette', 1997, 'Plate - Foam, Bread And Butter', 'seize global ROI');
insert into CAR (CarID, Maker, Model, Year, Color, Note) values (5, 'Ferrari', '599 GTB Fiorano', 2010, 'Kolrabi', 'unleash intuitive convergence');

create table CAR_ORDER (
	OrderID INT PRIMARY KEY,
	CustomerID INT,
	CarID INT,
	Amount INT,
	SalePrice VARCHAR(50),
	OrderDate DATE,
	DeliveryDate DATE,
	DeliveryAddress VARCHAR(50),
	`Status` INT,
	Note VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CarID) REFERENCES Car(CarID)
);
insert into CAR_ORDER (OrderID, CustomerID, CarID, Amount, SalePrice, OrderDate, DeliveryDate, DeliveryAddress, Status, Note) values (1, 2, 5, 2, '¥82588.64', '2020-06-08', '2020-09-21', '5 Pine View Parkway', 2, 'embrace granular vortals');
insert into CAR_ORDER (OrderID, CustomerID, CarID, Amount, SalePrice, OrderDate, DeliveryDate, DeliveryAddress, Status, Note) values (2, 4, 4, 3, '¥74148.30', '2020-03-11', '2020-01-26', '1 Lien Road', 0, 'implement integrated applications');
insert into CAR_ORDER (OrderID, CustomerID, CarID, Amount, SalePrice, OrderDate, DeliveryDate, DeliveryAddress, Status, Note) values (3, 2, 2, 5, '£27558.08', '2020-02-04', '2020-08-17', '0 Hazelcrest Road', 1, 'harness next-generation e-tailers');
insert into CAR_ORDER (OrderID, CustomerID, CarID, Amount, SalePrice, OrderDate, DeliveryDate, DeliveryAddress, Status, Note) values (4, 5, 2, 1, '¥37301.76', '2020-10-12', '2020-09-23', '93 Sugar Point', 0, 'mesh ubiquitous ROI');
insert into CAR_ORDER (OrderID, CustomerID, CarID, Amount, SalePrice, OrderDate, DeliveryDate, DeliveryAddress, Status, Note) values (5, 1, 1, 2, '$55424.76', '2020-05-10', '2020-07-30', '99 Maywood Way', 1, 'envisioneer e-business architectures');

-- 2. Viết lệnh lấy ra thông tin của khách hàng: tên, số lượng oto khách hàng đã mua và sắp sếp tăng dần theo số lượng oto đã mua.
SELECT `Name`, SUM(AMOUNT) FROM customer C
LEFT JOIN car_order O ON C.CustomerID = O.CustomerID
GROUP BY O.CustomerID ORDER BY SUM(AMOUNT);
 
-- 3. Viết hàm (không có parameter) trả về tên hãng sản xuất đã bán được nhiều oto nhất trong năm nay.
DROP FUNCTION IF EXISTS Maker;
DELIMITER $$
CREATE FUNCTION Maker() RETURNS VARCHAR(50)
BEGIN
	DECLARE _Maker VARCHAR(50);
    WITH A AS (
		SELECT Maker, sum(Amount) AS S FROM car_order O
		JOIN car C ON O.CarID = C.CarID
		WHERE year(OrderDate) = year(now())
		GROUP BY Maker
    )
    SELECT Maker INTO _Maker FROM A
    WHERE S = (SELECT max(S) FROM A);
    RETURN _Maker;
END$$
DELIMITER ;

-- 4. Viết 1 thủ tục (không có parameter) để xóa các đơn hàng đã bị hủy của những năm trước. In ra số lượng bản ghi đã bị xóa.
DROP PROCEDURE IF EXISTS car_order;
DELIMITER $$
CREATE PROCEDURE car_order()
BEGIN
    SELECT count(1) FROM car_order WHERE `Status` = 2 AND year(OrderDate) < year(now());
    DELETE FROM car_order WHERE OrderID IN (
    SELECT OrderID FROM car_order WHERE `Status` = 2 AND year(OrderDate) < year(now()));
END$$
DELIMITER ;

-- 5. Viết 1 thủ tục (có CustomerID parameter) để in ra thông tin của các đơn hàng đã đặt hàng bao gồm: tên của khách hàng, mã đơn hàng, số lượng oto và tên hãng sản xuất.
DROP PROCEDURE IF EXISTS customer;
DELIMITER $$
CREATE PROCEDURE customer(IN I_CustomerID INT)
BEGIN
    SELECT `Name`, OrderID, Amount, Maker
    FROM customer C
    JOIN car_order O ON C.CustomerID = O.CustomerID
    LEFT JOIN car ON O.CarID = car.CarID
    WHERE `Status` = 0 AND C.CustomerID = I_CustomerID;
END$$
DELIMITER ;

-- 6. Viết trigger để tránh trường hợp người dùng nhập thông tin không hợp lệ vào database (DeliveryDate < OrderDate + 15).
DROP TRIGGER IF EXISTS DeliveryDate;
DELIMITER $$
CREATE TRIGGER DeliveryDate
BEFORE INSERT ON car_order FOR EACH ROW
BEGIN
    IF NEW.DeliveryDate >= date_add(NEW.OrderDate, INTERVAL 15 DAY)
    THEN
		SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'DeliveryDate < OrderDate + 15';
    END IF;
END$$
DELIMITER ;