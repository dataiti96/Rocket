TRUNCATE TABLE trainee;

-- E1-Q1
INSERT INTO Trainee
VALUE
(1, 'Đình Tuấn', '1999-07-23', 'Male', 20, 20, 50, 'A007', 'Perfect'),
(2, 'Bảo Anh', '1999-10-05', 'Male', 10, 10, 25, 'A007', 'Mischief'),
(3, 'Thùy Dương', '1999-12-03', 'Female', 14, 16, 45, 'A002', 'Docile'),
(4, 'Quỳnh Anh', '1999-12-10', 'Female', 10, 20, 15, 'A001', 'Docile'),
(5, 'Đình Tú', '2002-01-22', 'Male', 9, 10, 36, 'A004', 'Mischief'),
(6, 'Đậu Hiền', '1999-06-14', 'Female', 3, 10, 50, 'A002', 'Docile'),
(7, 'Đắc Công', '1999-01-01', 'Male', 10, 10, 16, 'A006', 'Mischief'),
(8, 'Trà My', '1999-03-05', 'Female', 12, 14, 35, 'A001', 'Docile'),
(9, 'Phan Ngọc', '1977-06-01', 'Female', 20, 20, 40, 'A003', 'Perfect'),
(10, 'Nguyễn Ngân', '1999-07-23', 'Female', 15, 12, 25, 'A005', 'Docile'),
(11, 'Nguyễn Thảo', '1999-11-19', 'Female', 1, 2, 25, 'A003', 'Mischief'),
(12, 'Phương Hoa', '1999-04-16', 'Female', 5, 2, 29, 'A004', 'Docile'),
(13, 'Đức Vượng', '1999-07-19', 'Male', 15, 12, 45, 'A005', 'Docile');

-- E1-Q2
SELECT Full_Name, month(Birth_Date) as `Month`, ET_IQ
FROM trainee
WHERE ET_IQ > 10
ORDER BY `Month`;

-- E1-Q3
SELECT *
FROM trainee
WHERE char_length(Full_Name) = (SELECT max(char_length(Full_Name)) FROM trainee);

-- E1-Q4
SELECT *
FROM trainee
WHERE ET_IQ + ET_Gmath >=20 AND ET_IQ>=8 AND ET_Gmath>=8 AND ET_English>=18;

-- E1-Q5
DELETE FROM trainee WHERE TraineeID = 3;

-- E1-Q6
UPDATE trainee
SET Training_Class = 'A002'
WHERE TraineeID = 5;

-- E2-Q1
CREATE TABLE Department (
	Department_Number		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Department_Name			VARCHAR(100)
);

CREATE TABLE Employee (
	Employee_Number			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Employee_Name			VARCHAR(100),
    Department_Number		INT UNSIGNED REFERENCES Department(Department_Number)
);

CREATE TABLE Skill (
	Employee_Number			INT UNSIGNED REFERENCES Employee(Employee_Number),
    Skill_Code				VARCHAR(100),
    Date_Registered			DATE
);

-- E2-Q2
INSERT INTO Department
VALUE
(1, 'Samsung'),
(2, 'LG'),
(3, 'Sony'),
(4, 'Canon');

INSERT INTO Employee
VALUE
(1, 'Soobin Hoang Son', 2),
(2, 'Tran Thanh Mc', 3),
(3, 'Truong Giang Mc', 1),
(4, 'Quan AP', 4),
(5, 'My Tam', 1),
(6, 'Dam Vinh Hung', 3),
(7, 'Binz', 2),
(8, 'Suboi', 1),
(9, 'Big Daddy', 2),
(10, 'Erik', 3),
(11, 'Duc Phuc', 4),
(12, 'Hari Won', 2);

INSERT INTO Skill
VALUE
(1, 'java', '1999-07-23'),
(2, 'python', '1999-10-05'),
(3, 'html', '1999-12-03'),
(4, 'css', '1999-12-10'),
(5, 'java', '2002-01-22'),
(6, 'c#', '1999-06-14'),
(7, 'sql', '1999-01-01'),
(8, 'photoshop', '1999-03-05'),
(9, 'java', '1977-06-01'),
(10, 'java', '1999-07-23'),
(11, 'html', '1999-11-19'),
(12, 'c#', '1999-04-16');

-- E2-Q3
SELECT Employee_Name
FROM employee, skill
WHERE employee.Employee_Number = skill.Employee_Number
AND Skill_Code = 'JAVA';

-- E2-Q5
SELECT D.Department_Number, D.Department_Name, GROUP_CONCAT(E.Employee_Name) AS Employee_Name, count(E.Department_Number) AS TOTAL
FROM department D, employee E
WHERE D.Department_Number = E.Department_Number
GROUP BY E.Department_Number;

-- E2-Q4
-- HAVING TOTAL>3;

-- E2-Q6
SELECT *
FROM employee, skill
WHERE employee.Employee_Number = skill.Employee_Number
GROUP BY skill.Employee_Number
HAVING count(skill.Skill_Code)>1
;