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
        VALUE (I_EMAIL, (SELECT SUBSTRING_INDEX(I_EMAIL, '@', 1)), I_FULLNAME, (
        SELECT DepartmentID FROM department WHERE DepartmentName = 'PHONG CHO'), (
        SELECT PositionID FROM position WHERE PositionName = 'DEV'));
        SELECT *
        FROM `account`
        WHERE Email=I_EMAIL AND FullName=I_FULLNAME;
	END$$
DELIMITER ;

-- PRINT
-- SELECT  CONCAT('YOUR PARAMETER ', product_id, ' IS NOT EXISTS!!!') AS 'ERROR';

-- Q8
DROP PROCEDURE IF EXISTS T_Q_MAX_CONT;
DELIMITER $$
CREATE PROCEDURE T_Q_MAX_CONT (IN I_TYPE ENUM('Essay', 'Multiple-Choice'))
	BEGIN
		WITH Q_T AS (
        SELECT Q.QuestionID, Q.Content, T.TypeName
        FROM question Q
        JOIN typequestion T
        ON Q.TypeID = T.TypeID)
        SELECT *
        FROM Q_T
        WHERE  TypeName = I_TYPE
        AND CHAR_LENGTH(CONTENT) = (SELECT MAX(CHAR_LENGTH(CONTENT)) FROM Q_T WHERE TypeName = I_TYPE);
	END$$
DELIMITER ;

-- Q9
DROP PROCEDURE IF EXISTS DEL_EXAM;
DELIMITER $$
CREATE PROCEDURE DEL_EXAM (IN ID SMALLINT UNSIGNED)
	BEGIN
		SELECT count(1) AS 'REMOVED FROM EXAM_QUIZ'
        FROM examquestion
        WHERE  ExamID = ID;
		DELETE
        FROM exam
        WHERE  ExamID = ID;
	END$$
DELIMITER ;

-- Q10
SELECT ExamID
FROM exam
WHERE CreateDate <= date_sub(NOW(), INTERVAL 3 YEAR);

-- Q11
DROP PROCEDURE IF EXISTS DEL_DEP;
DELIMITER $$
CREATE PROCEDURE DEL_DEP (IN D_NAME VARCHAR(20))
	BEGIN
		DELETE
        FROM department
        WHERE  DepartmentName = D_NAME;
        UPDATE `account`
        SET DepartmentID = (SELECT DepartmentID FROM department WHERE DepartmentName = 'PHONG CHO')
        WHERE DepartmentID IS NULL;
	END$$
DELIMITER ;

-- Q12
DROP PROCEDURE IF EXISTS NUM_Q_MON;
DELIMITER $$
CREATE PROCEDURE NUM_Q_MON (IN I_YEAR INT)
	BEGIN
		IF I_YEAR > YEAR(NOW()) THEN SELECT CONCAT('CHUA DEN NAM ', I_YEAR) AS `ERROR`;
        ELSE
        SELECT month(CreateDate) AS THANG, count(1) AS QUIZ
        FROM question
        WHERE year(CreateDate) = I_YEAR
        GROUP BY month(CreateDate);
        END IF;
	END$$
DELIMITER ;

-- Q13
DROP PROCEDURE IF EXISTS NUM_Q_6M;
DELIMITER $$
CREATE PROCEDURE NUM_Q_6M ()
	BEGIN
		CREATE TEMPORARY TABLE `MONTH` (THANG INT);
		INSERT INTO `MONTH` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12);
        
        WITH `COUNT` AS (
        SELECT month(CreateDate) AS THANG, count(1) AS QUIZ
        FROM question
        WHERE CreateDate >= date_sub(now(), INTERVAL 6 MONTH)
        GROUP BY month(CreateDate))
        
        SELECT M.THANG, ifnull(C.QUIZ, 0) AS QUIZ
        FROM `MONTH` M
        LEFT JOIN `COUNT` C
        ON M.THANG = C.THANG
        WHERE M.THANG IN (month(now()),
        month(date_sub(now(), INTERVAL 1 MONTH)),
        month(date_sub(now(), INTERVAL 2 MONTH)),
        month(date_sub(now(), INTERVAL 3 MONTH)),
        month(date_sub(now(), INTERVAL 4 MONTH)),
        month(date_sub(now(), INTERVAL 5 MONTH))
        );
        
        DROP TEMPORARY TABLE `MONTH`;
	END$$
DELIMITER ;