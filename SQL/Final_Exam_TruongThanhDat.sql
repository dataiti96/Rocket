DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

create table Country (
	country_id INT PRIMARY KEY,
	country_name VARCHAR(50) NOT NULL
);
insert into Country (country_id, country_name) values (1, 'Indonesia');
insert into Country (country_id, country_name) values (2, 'Venezuela');
insert into Country (country_id, country_name) values (3, 'Vietnam');

create table Location (
	location_id INT PRIMARY KEY,
	street_address VARCHAR(50) NOT NULL,
	postal_code VARCHAR(50),
	country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES Country(country_id)
);
insert into Location (location_id, street_address, postal_code, country_id) values (1, '0954 Calypso Park', null, 1);
insert into Location (location_id, street_address, postal_code, country_id) values (2, '78 Kedzie Road', null, 2);
insert into Location (location_id, street_address, postal_code, country_id) values (3, '025 Grasskamp Parkway', '79210-000', 1);
insert into Location (location_id, street_address, postal_code, country_id) values (4, '9055 Crownhardt Point', '4785-035', 2);
insert into Location (location_id, street_address, postal_code, country_id) values (5, '8386 Talisman Alley', '289-3182', 3);
insert into Location (location_id, street_address, postal_code, country_id) values (6, '3610 Fremont Crossing', null, 3);

create table Employee (
	employee_id INT PRIMARY KEY,
	full_name VARCHAR(50),
	email VARCHAR(50) UNIQUE KEY,
	location_id INT,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE SET NULL
);
insert into Employee (employee_id, full_name, email, location_id) values (1, 'Cassaundra Sore', 'csore0@paypal.com', 4);
insert into Employee (employee_id, full_name, email, location_id) values (2, 'Katey Fihelly', 'kfihelly1@thetimes.co.uk', 5);
insert into Employee (employee_id, full_name, email, location_id) values (3, 'Arlan Giacoppo', 'agiacoppo2@jigsy.com', 2);
insert into Employee (employee_id, full_name, email, location_id) values (4, 'Kalina Puttan', 'kputtan3@telegraph.co.uk', 1);
insert into Employee (employee_id, full_name, email, location_id) values (5, 'Tawsha Longhi', 'tlonghi4@constantcontact.com', 2);
insert into Employee (employee_id, full_name, email, location_id) values (6, 'Chrysler Pierpoint', 'cpierpoint5@umn.edu', 1);
insert into Employee (employee_id, full_name, email, location_id) values (7, 'Rosalind Kun', 'rkun6@uol.com.br', 5);
insert into Employee (employee_id, full_name, email, location_id) values (8, 'Evania Baynom', 'ebaynom7@nytimes.com', 5);
insert into Employee (employee_id, full_name, email, location_id) values (9, 'Mathew Tinkler', 'mtinkler8@netscape.com', 4);
insert into Employee (employee_id, full_name, email, location_id) values (10, 'Karla Sharer', 'ksharer9@miitbeian.gov.cn', 2);
insert into Employee (employee_id, full_name, email, location_id) values (11, 'Robbert Deverale', 'rdeveralea@diigo.com', 6);
insert into Employee (employee_id, full_name, email, location_id) values (12, 'Jennee Cooney', 'nn03@gmail.com', 6);

-- Lấy tất cả các nhân viên thuộc Việt Nam
SELECT *
FROM employee
WHERE location_id IN (
	SELECT location_id
    FROM location
    WHERE country_id IN (
		SELECT country_id
        FROM country
        WHERE country_name = 'Vietnam')
	);
        
-- Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"
SELECT country_name
FROM country
WHERE country_id = (
	SELECT country_id
    FROM location
    WHERE location_id = (
		SELECT location_id
        FROM employee
        WHERE email = 'nn03@gmail.com')
	);

-- Thống kê mỗi country, mỗi location có bao nhiêu employee đang làm việc.
SELECT country_name, street_address, count(employee_id) AS 'num_employees'
FROM country C
LEFT JOIN location L ON L.country_id = C.country_id
LEFT JOIN employee E ON E.location_id = L.location_id
GROUP BY country_name, street_address;

-- Tạo trigger cho table Employee chỉ cho phép insert mỗi quốc gia có tối đa 10 employees
DROP VIEW IF EXISTS ID_CORRECT;
CREATE VIEW ID_CORRECT AS (
	WITH A AS (
		SELECT C.country_id, count(employee_id) AS 'num_employees'
		FROM country C
		LEFT JOIN location L ON L.country_id = C.country_id
		LEFT JOIN employee E ON E.location_id = L.location_id
		GROUP BY C.country_id
	)
	SELECT location_id FROM location WHERE country_id IN (
		SELECT country_id FROM A WHERE num_employees < 10)
);
DROP TRIGGER IF EXISTS Insert_Employee;
DELIMITER $$
CREATE TRIGGER Insert_Employee
BEFORE INSERT ON Employee FOR EACH ROW
BEGIN	
    IF NEW.location_id NOT IN (SELECT location_id FROM ID_CORRECT)
    THEN SIGNAL SQLSTATE '12345' SET MESSAGE_TEXT = 'mỗi quốc gia có tối đa 10 employees';
    END IF;
END$$
DELIMITER ;

-- Hãy cấu hình table sao cho khi xóa 1 location nào đó thì tất cả employee ở location đó sẽ có location_id = null
/* create table Employee (
	employee_id INT PRIMARY KEY,
	full_name VARCHAR(50),
	email VARCHAR(50) UNIQUE KEY,
	location_id INT,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE SET NULL
); */
DROP TRIGGER IF EXISTS Null_Location;
DELIMITER $$
CREATE TRIGGER Null_Location
AFTER DELETE ON Location FOR EACH ROW
BEGIN	
    UPDATE Employee
    SET location_id = NULL
    WHERE location_id = OLD.location_id;
END$$
DELIMITER ;