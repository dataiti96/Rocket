DROP DATABASE IF EXISTS Testing_System;
CREATE DATABASE Testing_System;
USE Testing_System;

CREATE TABLE Department (
	DepartmentID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName	VARCHAR(20) NOT NULL UNIQUE KEY
);

INSERT INTO Department (DepartmentName)
VALUES ('Phong Chu Tich'), ('Phong Giam Doc'), ('Phong Quan Ly'), ('Phong Nhan Vien'), ('Phong Bao Ve');

CREATE TABLE `Position` (
	PositionID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName	ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);

INSERT INTO `Position` (PositionName)
VALUES ('PM'), ('Scrum Master'), ('Dev'), ('Test');

CREATE TABLE `Account` (
	AccountID		MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email			VARCHAR(50) UNIQUE KEY,
    Username		CHAR(20) NOT NULL UNIQUE KEY,
    FullName		VARCHAR(30) NOT NULL,
    DepartmentID	TINYINT UNSIGNED NOT NULL,
    PositionID		TINYINT UNSIGNED NOT NULL,
    CreateDate		DATE DEFAULT(NOW()),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID)   REFERENCES `Position`(PositionID)
);

INSERT INTO `Account` (Email, Username, FullName, DepartmentID, PositionID)
VALUES 	('chutich@gmail.com', 'chutich', 'Chu Tich', 1, 1),
		('giamdoc@gmail.com', 'giamdoc', 'Giam Doc', 2, 1),
		('quanly@gmail.com', 'quanly', 'Quan Ly', 3, 3),
        ('nhanvien@gmail.com', 'nhanvien', 'Nhan Vien', 4, 4),
        ('baove@gmail.com', 'baove', 'Bao Ve', 5, 2);

CREATE TABLE `Group` (
	GroupID			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName		VARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID		MEDIUMINT UNSIGNED NOT NULL,
    CreateDate		DATE DEFAULT(NOW()),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

INSERT INTO `Group` (GroupName, CreatorID)
VALUES 	('Nhom Cap Cao', 2),
		('Nhom Quan Ly', 3),
		('Nhom Noi Bo', 3),
        ('Nhom Cong Ty', 3),
        ('Nhom Gia Dinh', 4);

CREATE TABLE GroupAccount (
	GroupID			SMALLINT UNSIGNED NOT NULL,
    AccountID		MEDIUMINT UNSIGNED NOT NULL,
    JoinDate		DATETIME DEFAULT(NOW()),
    FOREIGN KEY (GroupID)	REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID)	REFERENCES `Account`(AccountID)
);

INSERT INTO GroupAccount (GroupID, AccountID)
VALUES 	(1, 2), (1, 1),
		(2, 3), (2, 1), (2, 2),
		(3, 3), (3, 1), (3, 2), (3, 4),
        (4, 3), (4, 1), (4, 2), (4, 4), (4, 5),
        (5, 4), (5, 5);

CREATE TABLE TypeQuestion (
	TypeID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName		ENUM('Essay', 'Multiple-Choice')
);

INSERT INTO TypeQuestion (TypeName)
VALUES ('Essay'), ('Multiple-Choice');

CREATE TABLE CategoryQuestion (
	CategoryID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName	ENUM('Java', '.NET', 'SQL', 'Postman', 'Ruby', 'Others')
);

INSERT INTO CategoryQuestion (CategoryName)
VALUES ('Java'), ('.NET'), ('SQL'), ('Postman'), ('Ruby'), ('Others');

CREATE TABLE Question (
	QuestionID		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content			VARCHAR(100) NOT NULL UNIQUE KEY,
    CategoryID		TINYINT UNSIGNED NOT NULL,
    TypeID			TINYINT UNSIGNED NOT NULL,
    CreatorID		MEDIUMINT UNSIGNED NOT NULL,
    CreateDate		DATETIME DEFAULT(NOW()),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (TypeID)	 REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY (CreatorID)	 REFERENCES `Account`(AccountID)
);

INSERT INTO Question (Content, CategoryID, TypeID, CreatorID)
VALUES 	('Chu Tich ten day du la gi?', 1, 1, 4),
		('Giam Doc la nam hay nu?', 2, 1, 5),
		('Quan Ly sinh nam bao nhieu?', 3, 2, 2),
        ('Nhan Vien que o dau?', 4, 2, 1),
        ('Bao Ve co gia dinh chua?', 5, 2, 3);

CREATE TABLE Answer (
	AnswerID		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content			VARCHAR(100) NOT NULL UNIQUE KEY,
    QuestionID		SMALLINT UNSIGNED NOT NULL,
    isCorrect		ENUM('TRUE', 'FALSE'),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO Answer (Content, QuestionID, isCorrect)
VALUES 	('Khong ai biet !!!', 1, 'FALSE'),
		('Doan xem =)))', 2, 'TRUE'),
		('Chac la 9x', 3, 'TRUE'),
        ('Thanh Hoa', 4, 'TRUE'),
        ('Nhin cung khong con tre.', 5, 'FALSE');

CREATE TABLE Exam (
	ExamID			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`			CHAR(10) NOT NULL UNIQUE KEY,
    Title			VARCHAR(20) NOT NULL UNIQUE KEY,
    CategoryID		TINYINT UNSIGNED NOT NULL,
    Duration		TIME NOT NULL,
    CreatorID		MEDIUMINT UNSIGNED NOT NULL,
    CreateDate		DATE DEFAULT(NOW()),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (CreatorID)	 REFERENCES `Account`(AccountID)
);

INSERT INTO Exam (`Code`, Title, CategoryID, Duration, CreatorID)
VALUES 	('A1', 'Thi dau vao', 1, 100, 4),
		('B2', 'Thi dau ra', 2, 200, 5),
		('C3', 'Kiem tra dinh ky', 3, 300, 2),
        ('D4', 'Thi ky nang', 4, 400, 1),
        ('E5', 'Test IQ', 5, 500, 3);

CREATE TABLE ExamQuestion (
	ExamID			SMALLINT UNSIGNED NOT NULL,
    QuestionID		SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (ExamID)	 REFERENCES Exam(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO ExamQuestion (ExamID, QuestionID)
VALUES 	(1, 2), (1, 1),
		(2, 3), (2, 1), (2, 2),
		(3, 3), (3, 1), (3, 2), (3, 4),
        (4, 3), (4, 1), (4, 2), (4, 4), (4, 5),
        (5, 4), (5, 5);