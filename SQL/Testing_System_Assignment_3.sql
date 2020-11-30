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


