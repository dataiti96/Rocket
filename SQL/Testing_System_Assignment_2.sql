-- Q1
SELECT * FROM department;

-- Q2
SELECT DepartmentID FROM department WHERE DepartmentName = 'Sale';

-- Q3
SELECT * FROM `account`
WHERE length(FullName) = (SELECT max(length(FullName)) FROM `account`);

-- Q4
SELECT GroupName FROM `group` WHERE CreateDate < 2019-12-20;

-- Q5
SELECT QuestionID FROM answer
GROUP BY QuestionID HAVING count(QuestionID) >=4;

-- Q6
SELECT * FROM `group` ORDER BY CreateDate DESC LIMIT 5;

-- Q7 null
-- Q8
DELETE FROM exam WHERE CreateDate < 2019-12-20;

-- Q9
UPDATE `account`
SET FullName = 'Nguyễn Bá Lộc', Email = 'loc.nguyenba@vti.com.vn'
WHERE AccountID = 5;

-- Q10
SELECT * FROM `account`, department
WHERE `account`.DepartmentID = department.DepartmentID;

-- Q11
SELECT * FROM `account` WHERE PositionID =
(SELECT PositionID FROM `position` WHERE PositionName = 'Dev');

-- Q12
SELECT DepartmentName FROM department, `account`
WHERE `account`.DepartmentID = department.DepartmentID
GROUP BY `account`.DepartmentID HAVING count(`account`.DepartmentID) > 3;

-- Q13
