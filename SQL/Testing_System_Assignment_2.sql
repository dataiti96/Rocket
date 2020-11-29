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
SELECT *, count(E.ExamID) AS USED
FROM question Q, examquestion E
WHERE Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
ORDER BY count(E.ExamID) DESC
LIMIT 1;

-- Q14
SELECT C.CategoryID, C.CategoryName, count(Q.QuestionID) AS TotalQuiz
FROM categoryquestion C, question Q
WHERE C.CategoryID = Q.CategoryID
GROUP BY Q.CategoryID;

-- Q15
SELECT *
FROM question, answer
WHERE question.QuestionID = answer.QuestionID
GROUP BY answer.QuestionID
ORDER BY count(answer.AnswerID) DESC
LIMIT 1;

-- Q16
SELECT *
FROM position P, `account` A
WHERE P.PositionID = A.PositionID
GROUP BY A.PositionID
ORDER BY count(A.AccountID)
LIMIT 1;

-- Q17
SELECT D.DepartmentName, P.PositionName, count(A.AccountID) AS TOTAL
FROM department D, `account` A, `position` P
WHERE D.DepartmentID = A.DepartmentID
AND A.PositionID = P.PositionID
AND A.PositionID IN
(SELECT PositionID FROM `position` WHERE PositionName IN ('PM','DEV', 'TEST', 'SCRUM MASTER'))
GROUP BY A.DepartmentID, A.PositionID
ORDER BY A.DepartmentID;

-- Q18
SELECT Q.QuestionID, Q.Content,
C.CategoryName,
T.TypeName,
A.FullName AS CREATOR,
Q.CreateDate,
S.Content AS ANSWER
FROM question Q, answer S, categoryquestion C, typequestion T, `account` A
WHERE Q.QuestionID = S.QuestionID AND
Q.CategoryID = C.CategoryID AND
Q.CreatorID = A.AccountID AND
Q.TypeID = T.TypeID;

-- Q19
SELECT typequestion.TypeID, typequestion.TypeName, count(question.QuestionID) AS TOTAL
FROM typequestion, question
WHERE typequestion.TypeID = question.TypeID
GROUP BY question.TypeID;