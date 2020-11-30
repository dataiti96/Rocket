-- Q1
CREATE VIEW DSNVSALE AS (
	SELECT AccountID, Email, FullName, PositionID
    FROM `account`, department
    WHERE `account`.DepartmentID = department.DepartmentID
    AND DepartmentName = 'SALE'
);

-- Q2
CREATE VIEW USER_MAX_GR AS (
	SELECT GA.AccountID, FullName, group_concat(GroupName) AS GR_NAME, count(GA.GroupID) AS TOTAL
    FROM groupaccount GA, `account` A, `group` G
    WHERE GA.AccountID = A.AccountID
    AND GA.GroupID = G.GroupID
    GROUP BY GA.AccountID
    HAVING count(GA.GroupID) = (
		WITH USER_NUM_GR AS (
			SELECT count(GroupID) AS NUM_GR
			FROM groupaccount
			GROUP BY AccountID
		)
		SELECT max(NUM_GR) FROM USER_NUM_GR
    )
);

-- Q3
CREATE VIEW Q_CONTENT_DAI AS (
	SELECT QuestionID
	FROM question
	WHERE length(CONTENT) > 25
);

DELETE FROM question
WHERE QuestionID IN (
	SELECT QuestionID
    FROM Q_CONTENT_DAI
);

-- Q4
DROP VIEW IF EXISTS DEP_MAX_NV;
CREATE VIEW DEP_MAX_NV AS (
	SELECT department.DepartmentID, DepartmentName, count(AccountID) AS NUM_NV, group_concat(Username) AS `MEMBER`
	FROM department, `account`
	WHERE department.DepartmentID = `account`.DepartmentID
	GROUP BY DepartmentName
    HAVING count(AccountID) = (
		WITH NUM_NV AS (
			SELECT count(AccountID) AS NUM_NV
			FROM department, `account`
			WHERE department.DepartmentID = `account`.DepartmentID
			GROUP BY DepartmentName
		)
		SELECT max(NUM_NV) FROM NUM_NV
    )
);

-- Q5
CREATE VIEW QUIZ_CHU AS (
	SELECT *
	FROM question
	WHERE CreatorID IN (SELECT AccountID
						FROM `account`
						WHERE FullName LIKE 'CHU%')
);