-- Q1
DROP PROCEDURE IF EXISTS ACC_DEP;
DELIMITER $$
CREATE PROCEDURE ACC_DEP (IN DEP_NAME VARCHAR(20))
	BEGIN
        SELECT A.AccountID
        FROM `account` A
        JOIN department D
        ON A.DepartmentID = D.DepartmentID
        WHERE D.DepartmentName = DEP_NAME;
    END$$
DELIMITER ;

-- Q2
DROP PROCEDURE IF EXISTS NUM_ACC_GR;
DELIMITER $$
CREATE PROCEDURE NUM_ACC_GR ()
	BEGIN
        SELECT GroupID, count(AccountID)
        FROM groupaccount
        GROUP BY GroupID;
    END$$
DELIMITER ;

-- Q3
DROP PROCEDURE IF EXISTS NUM_Q_T_NOW;
DELIMITER $$
CREATE PROCEDURE NUM_Q_T_NOW ()
	BEGIN
        SELECT TypeID, count(QuestionID)
        FROM question
        WHERE month(CreateDate) = month(now())
        AND year(CreateDate) = year(now())
        GROUP BY TypeID;
    END$$
DELIMITER ;

-- Q4
DROP PROCEDURE IF EXISTS T_Q_MAX_A;
DELIMITER $$
CREATE PROCEDURE T_Q_MAX_A (OUT T_ID_MAX_A TINYINT UNSIGNED)
	BEGIN
		WITH T_ID_NUM_A AS (
        SELECT Q.TypeID, count(AnswerID) AS NUM_A
        FROM question Q
        JOIN answer A
        ON Q.QuestionID = A.QuestionID
        GROUP BY TypeID)
        SELECT TypeID INTO T_ID_MAX_A FROM T_ID_NUM_A WHERE NUM_A = (SELECT max(NUM_A) FROM T_ID_NUM_A);
    END$$
DELIMITER ;

-- Q5
SET @T_ID_MAX_A = 0;
CALL T_Q_MAX_A(@T_ID_MAX_A);
SELECT TypeName
FROM typequestion
WHERE TypeID = @T_ID_MAX_A;

-- Q6
DROP PROCEDURE IF EXISTS U_G_LIKE;
DELIMITER $$
CREATE PROCEDURE U_G_LIKE (IN CHUOI VARCHAR(10))
	BEGIN
		SELECT Username
        FROM `account`
        WHERE Username LIKE concat('%', CHUOI, '%');
        SELECT GroupName
        FROM `group`
        WHERE GroupName LIKE concat('%', CHUOI, '%');
	END$$
DELIMITER ;

-- Q7
DROP PROCEDURE IF EXISTS IN_NAME_MAIL;
DELIMITER $$
CREATE PROCEDURE IN_NAME_MAIL (IN I_FULLNAME VARCHAR(30), IN I_EMAIL VARCHAR(50))
	BEGIN
		INSERT INTO `account` (Email, Username, FullName, DepartmentID, PositionID)
        VALUE (I_EMAIL, (SELECT SUBSTRING_INDEX(I_EMAIL, '@', 1)), I_FULLNAME, 1, (
        SELECT PositionID FROM position WHERE PositionName = 'DEV'));
        SELECT *
        FROM `account`
        WHERE Email=I_EMAIL AND FullName=I_FULLNAME;
	END$$
DELIMITER ;

-- PRINT
-- SELECT  CONCAT('YOUR PARAMETER ', product_id, ' IS NOT EXISTS!!!') AS 'ERROR';

-- Q8 THỬ DÙNG IF
DROP PROCEDURE IF EXISTS IN_NAME_MAIL;
DELIMITER $$
CREATE PROCEDURE IN_NAME_MAIL (IN I_FULLNAME VARCHAR(30))
	BEGIN
		INSERT INTO `account` (Email, Username, FullName, DepartmentID, PositionID)
        VALUE (I_EMAIL, (SELECT SUBSTRING_INDEX(I_EMAIL, '@', 1)), I_FULLNAME, 1, (
        SELECT PositionID FROM position WHERE PositionName = 'DEV'));
        SELECT *
        FROM `account`
        WHERE Email=I_EMAIL AND FullName=I_FULLNAME;
	END$$
DELIMITER ;