DROP DATABASE IF EXISTS Assignment_4;
CREATE DATABASE Assignment_4;
USE Assignment_4;

CREATE TABLE Employee (
	EmployeeID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    EmployeeLastName VARCHAR(100),
	EmployeeFirstName VARCHAR(100),
	EmployeeHireDate DATE NOT NULL,
    EmployeeStatus VARCHAR(50),
    SupervisorID INT UNSIGNED,
    SocialSecurityNumber VARCHAR(50) UNIQUE KEY,
    FOREIGN KEY (SupervisorID) REFERENCES Employee(EmployeeID)
);

INSERT INTO Employee (EmployeeLastName, EmployeeFirstName, EmployeeHireDate, EmployeeStatus, SupervisorID, SocialSecurityNumber)
VALUES	('Tuấn','Đình','1999-07-23','Hoàn hảo', null, 2307),
('Tú','Đình','2002-01-22','Đẹp Troai', 1, 2201),
('My','Trà','1999-03-05','Hơi Lùn', null, 0503),
('Anh','Quỳnh','1999-12-10','Xinh Gái', null, 1012),
('Ngọc','Phan','1977-06-01','Ghê Gớm', null, 0106),
('Dũng','Đình','1976-07-19','Hoàn hảo', null, 1907),
('Anh','Bảo','1999-10-05','Đẹp Troai', null, 0510),
('Dương','Thùy','1999-12-03','Xinh Gái', null, 0312),
('Công','Đắc','1999-01-01','Cao', 5, 0101),
('Tráng','Văn','1999-09-09','Ngố Tàu', 5, 0909);

CREATE TABLE Projects (
	ProjectID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	ManagerID INT UNSIGNED NOT NULL,
    ProjectName VARCHAR(100) NOT NULL,
	ProjectStartDate DATE,
    ProjectDescription VARCHAR(200),
    ProjectDetail VARCHAR(100),
	ProjectCompletedOn DATE,
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID)
);

INSERT INTO Projects (ManagerID, ProjectName, ProjectStartDate, ProjectDescription, ProjectDetail, ProjectCompletedOn)
VALUES	(2, 'Rocket', '2020-11-25', 'VTI Academy', 'Fullstack', '2021-4-2'),
		(2, 'Baemin', '2020-11-09', 'Korea', '', NULL),
        (3, 'Love', '2020-2-14', '', '', '2022-2-14');

CREATE TABLE Project_Modules (
	ModuleID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	ProjectID INT UNSIGNED NOT NULL,
	EmployeeID INT UNSIGNED NOT NULL,
	ProjectModulesDate DATE NOT NULL,
    ProjectModulesCompletedOn DATE,
    ProjectModulesDescription VARCHAR(200),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON DELETE CASCADE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

INSERT INTO Project_Modules (ProjectID, EmployeeID, ProjectModulesDate, ProjectModulesCompletedOn, ProjectModulesDescription)
VALUES	(1, 2, '2020-11-25', NULL, 'Database'),
		(1, 2, '2020-12-25', NULL, 'Backend'),
		(1, 2, '2021-1-25', NULL, 'Frontend'),
		(2, 2, '2020-11-09', NULL, ''),
        (3, 3, '2020-2-14', '2022-2-14', 'Happy-Ending');

CREATE TABLE Work_Done (
	WorkDoneID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	EmployeeID INT UNSIGNED NOT NULL,
    ModuleID INT UNSIGNED NOT NULL,
	WorkDoneDate DATE,
    WorkDoneDescription VARCHAR(200),
    WorkDoneStatus ENUM('0%', '25%', '50%', '75%','100%'),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ModuleID) REFERENCES Project_Modules(ModuleID) ON DELETE CASCADE
);

INSERT INTO Work_Done (EmployeeID, ModuleID, WorkDoneDate, WorkDoneDescription, WorkDoneStatus)
VALUES	(1, 1, '2020-11-25', NULL, '75%'),
		(1, 2, '2020-12-25', NULL, '0%'),
		(1, 4, '2021-1-25', NULL, '0%'),
		(2, 5, '2020-11-09', NULL, NULL),
        (3, 3, '2020-2-14', '2022-2-14', '100%');
        
-- Remove tất cả thông tin project đã hoàn thành sau 3 tháng kể từ ngày hiện
DROP PROCEDURE IF EXISTS DEL_P_ON_3M;

DELIMITER $$
CREATE PROCEDURE DEL_P_ON_3M (OUT O_NUM_DEL INT)
	BEGIN
		SELECT count(1) INTO O_NUM_DEL
        FROM Projects
        WHERE ProjectCompletedOn <= (SELECT date_sub(now(), interval 3 month));
        
		DELETE FROM Projects
        WHERE ProjectCompletedOn <= (SELECT date_sub(now(), interval 3 month));
    END$$
DELIMITER ;

CALL DEL_P_ON_3M();

-- Module đang được thực hiện
DROP PROCEDURE IF EXISTS M_DOING;

DELIMITER $$
CREATE PROCEDURE M_DOING (IN I_PROJECT INT UNSIGNED, IN I_EMPLOYEE INT UNSIGNED)
	BEGIN
		SELECT *
        FROM Project_Modules
        WHERE ProjectModulesCompletedOn IS NULL
        AND (ProjectID = I_PROJECT OR EmployeeID = I_EMPLOYEE);
    END$$
DELIMITER ;

SET @I_PROJECT = 0, @I_EMPLOYEE = 0;
CALL M_DOING(@I_PROJECT, @I_EMPLOYEE);

-- Đệ Quy
-- SELECT e.EmployeeLastName, (SELECT EmployeeLastName FROM employee WHERE EmployeeID = e.SupervisorID) as supervisor
-- FROM employee e;

-- 