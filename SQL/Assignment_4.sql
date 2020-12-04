DROP DATABASE IF EXISTS Assignment_4;
CREATE DATABASE Assignment_4;
USE Assignment_4;

CREATE TABLE Employee (
	EmployeeID INT(11) PRIMARY KEY,
    EmployeeLastName VARCHAR(50),
	EmployeeFirstName VARCHAR(50),
	EmployeeHireDate DATETIME,
    EmployeeStatus TINYINT(1),
    SupervisorID INT(11),
    SocialSecurityNumber INT(11)
);

INSERT INTO Employee
VALUES	(1, 'Thành', 'Nguyễn Huy', '2019-01-03', 1, null, 214294),
(2, 'Đông', 'Công Phương', '2019-01-03', 1, 1, 215462),
(3, 'Trang', 'Đặng Nguyễn Phương', '2019-01-03', 1, 1, null),
(4, 'Thủy', 'Thạch Thanh', '2019-01-05', 1, null, 236454),
(5, 'Hiệp', 'Hoàng Mạnh', '2019-01-06', 1, 1, null),
(6, 'Hằng', 'Hồ Thị', '2019-02-01', 1, 4, 365446),
(7, 'Anh', 'Nguyễn Tú', '2019-03-05', 1, 4, null),
(8, 'Giang', 'Trần Thị Thu', '2019-03-06', 1, 4, 332546),
(9, 'Dũng', 'Bùi Ngọc', '2019-04-03', 1, 10, 123654),
(10, 'Đạt', 'Giang Tiến', '2019-03-08', 1, null, null),
(11, 'Kiên', 'Lại Trung', '2019-04-09', 1, null, 512983),
(12, 'Anh', 'Vũ Tuấn', '2019-05-01', 1, null, null),
(13, 'Thảo', 'Ngọc Nguyễn', '2019-05-01', 1, 12, 412123),
(14, 'An', 'Lê Ngọc', '2019-06-09', 1, 12, 135123),
(15, 'Việt', 'Nguyễn Việt', '2019-04-09', 1, 2, 123141),
(16, 'Hiếu', 'Đỗ Duy', '2019-04-08', 1, 2, 1231445);

CREATE TABLE Projects (
	ProjectID INT(11) PRIMARY KEY,
	ManagerID INT(11),
    ProjectName VARCHAR(100),
	ProjectStartDate DATETIME,
    ProjectDescription VARCHAR(255),
    ProjectDetailt VARCHAR(255),
	ProjectCompletedOn DATETIME
);

INSERT INTO Projects
VALUES	(1, 1, 'Web_MyGo', '2020-03-01', 'Web for customer', 'Just a web', '2020-07-15'),
(2, 1, 'Android_MyGo', '2020-03-05', 'Android App for customer', 'Just a app', '2020-08-29'),
(3, 1, 'iOS_MyGo', '2020-03-05', 'iOS App for customer', 'Just a app', null),
(4, 1, 'BackEnd_MyGo', '2020-03-01', 'BE for MyGo application', 'Big BE', null),
(5, 4, 'Test_MyGO', '2020-04-01', 'Test', 'Automation', '2020-11-01');

CREATE TABLE Project_Modules (
	ModuleID INT(11) PRIMARY KEY,
	ProjectID INT(11),
	ProjectModulesDate DATETIME,
    ProjectModulesCompletedOn DATETIME,
    ProjectModulesDescription VARCHAR(255),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON DELETE CASCADE
);

INSERT INTO Project_Modules
VALUES	(1, 1, '2020-03-01', '2020-05-01', 'web customer'),
(2, 1, '2020-03-01', '2020-05-29', 'web profile'),
(3, 1, '2020-03-01', '2020-08-29', 'web_report'),
(4, 2, '2020-03-05', '2020-09-15', 'app driver'),
(5, 2, '2020-03-05', '2020-10-14', 'app customer'),
(6, 3, '2020-03-05', null, 'app driver'),
(7, 3, '2020-03-10', null, 'app customer'),
(8, 4, '2020-03-01', null, 'Backend web'),
(9, 4, '2020-03-01', '2020-09-09', 'Backend database'),
(10, 5, '2020-04-01', '2020-09-01', 'manual'),
(11, 5, '2020-04-01', '2020-11-14', 'automation');

CREATE TABLE Work_Done (
	WorkDoneID INT(11) PRIMARY KEY,
	EmployeeID INT(11),
    ModuleID INT(11),
	WorkDoneDate DATETIME,
    WorkDoneDescription VARCHAR(255),
    WorkDoneStatus TINYINT(1),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ModuleID) REFERENCES Project_Modules(ModuleID) ON DELETE CASCADE
);

INSERT INTO Work_Done
VALUES	(1, 5, 1, '2020-05-01', 'design', 1),
(2, 5, 1, '2020-05-01', 'core js', 1),
(3, 5, 2, '2020-05-29', 'html, css', 1),
(4, 11, 2, '2020-05-29', 'javascrip and vue', 1),
(5, 14, 3, '2020-08-29', 'make data', 1),
(6, 13, 3, '2020-08-29', 'vue design', 1),
(7, 2, 4, '2020-09-15', 'app driver - design', 1),
(8, 15, 4, '2020-09-15', 'app driver - api done', 1),
(9, 16, 5, '2020-10-14', 'app customer - design', 1),
(10, 2, 5, '2020-10-14', 'app customer - api done', 1),
(11, 9, 6, null, 'ios design', 1),
(12, 10, 7, null, 'ios design - api work', 1),
(13, 11, 8, null, 'backend core', 1),
(14, 12, 8, null, 'backend system', 1),
(15, 4, 8, null, 'backend api', 1),
(16, 1, 9, '2020-09-09', 'backend data config', 1),
(17, 3, 9, '2020-09-09', 'backend data create', 1),
(18, 6, 10, '2020-09-01', 'write test case', 1),
(19, 8, 10, '2020-09-01', 'sumary test case', 1),
(20, 7, 11, '2020-11-14', 'write code done', 1);
        
-- Remove toàn bộ thông tin Project đã hoàn thành lâu hơn 3 tháng tính từ thời điểm hiện tại
DROP PROCEDURE IF EXISTS DEL_P_ON_3M;

DELIMITER $$
CREATE PROCEDURE DEL_P_ON_3M ()
	BEGIN
		WITH M_ID_DEL AS
        (WITH P_ID_DEL AS
		(SELECT ProjectID AS P_ID
        FROM Projects
        WHERE ProjectCompletedOn < (SELECT date_sub(now(), interval 3 month)))
        SELECT ModuleID, ProjectID
        FROM project_modules
        WHERE ProjectID IN (SELECT P_ID FROM P_ID_DEL))
        SELECT count(1) AS REMOVED_FROM_WORKS, count(DISTINCT M.ModuleID) AS REMOVED_FROM_MODULES, count(DISTINCT M.ProjectID) AS REMOVED_FROM_PROJECTS
        FROM work_done W
        JOIN M_ID_DEL M
        ON W.ModuleID = M.ModuleID
        ;
        
		DELETE FROM Projects
        WHERE ProjectCompletedOn < (SELECT date_sub(now(), interval 3 month));
    END$$
DELIMITER ;

-- Module đang được thực hiện
DROP PROCEDURE IF EXISTS M_DOING;

DELIMITER $$
CREATE PROCEDURE M_DOING (IN I_PROJECT INT(11))
	BEGIN
		CREATE VIEW P_M_DOING AS (
		SELECT *
        FROM Project_Modules
        WHERE ProjectModulesCompletedOn IS NULL);
        IF I_PROJECT NOT IN (SELECT ProjectID FROM projects)
        THEN SELECT 'ProjectID NOT EXISTS' AS NOTE;
        ELSE
			IF I_PROJECT NOT IN (SELECT ProjectID FROM P_M_DOING)
			THEN SELECT 'NO Project_Modules DOING' AS NOTE;
			ELSE SELECT * FROM P_M_DOING WHERE ProjectID = I_PROJECT;
			END IF;
        END IF;
        
        DROP VIEW P_M_DOING;
        
    END$$
DELIMITER ;

SET @I_PROJECT = 6;
CALL M_DOING(@I_PROJECT);

-- Đệ Quy
-- SELECT e.EmployeeLastName, (SELECT EmployeeLastName FROM employee WHERE EmployeeID = e.SupervisorID) as supervisor
-- FROM employee e;

-- 
DROP PROCEDURE IF EXISTS E_AUTO_DO;
DELIMITER $$
CREATE PROCEDURE E_AUTO_DO (IN P_ID INT(11))
BEGIN

SELECT W.EmployeeID
FROM `work_done` W
JOIN `employee` E
ON W.EmployeeID = E.EmployeeID
WHERE E.SupervisorID IS NULL
AND W.ModuleID IN (SELECT ModuleID FROM `project_modules` WHERE ProjectID = P_ID);

END$$
DELIMITER ;