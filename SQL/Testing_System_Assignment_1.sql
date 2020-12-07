DROP DATABASE IF EXISTS Testing_System;
CREATE DATABASE Testing_System;
USE Testing_System;

CREATE TABLE Department (
	DepartmentID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName	VARCHAR(20) NOT NULL UNIQUE KEY
);

INSERT INTO Department (DepartmentName)
VALUES ('Phong Chu Tich'), ('Phong Giam Doc'), ('Phong Quan Ly'), ('Phong Nhan Vien'), ('Phong Bao Ve'), ('PHONG CHO');

CREATE TABLE `Position` (
	PositionID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName	ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);

INSERT INTO `Position` (PositionName)
VALUES ('PM'), ('Scrum Master'), ('Dev'), ('Test');

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
	AccountID		MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email			VARCHAR(50) UNIQUE KEY,
    Username		CHAR(20) NOT NULL UNIQUE KEY,
    FullName		VARCHAR(30) NOT NULL,
    DepartmentID	TINYINT UNSIGNED,
    PositionID		TINYINT UNSIGNED NOT NULL,
    CreateDate		DATE DEFAULT(NOW()),
    GENDER			CHAR(5),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE SET NULL,
    FOREIGN KEY (PositionID)   REFERENCES `Position`(PositionID)
);

INSERT INTO `Account` 	(Email, 				Username, 	FullName, 		DepartmentID, 	PositionID)
VALUES 					('chutich@gmail.com', 	'chutich', 	'Chu Tich', 	1, 				1),
						('giamdoc@gmail.com', 	'giamdoc', 	'Giam Doc', 	2, 				1),
						('quanly@gmail.com', 	'quanly', 	'Quan Ly', 		3, 				3),
						('nhanvien@gmail.com', 	'nhanvien', 'Nhan Vien', 	4, 				4),
						('baove@gmail.com', 	'baove', 	'Bao Ve', 		5, 				2);
INSERT INTO `Account` 	(Email, 				Username, 	FullName, 		DepartmentID, 	PositionID)
VALUES 					('chutic@gmail.com', 	'chutic', 	'Chu Tic', 		1, 				2),
						('giamdo@gmail.com', 	'giamdo', 	'Giam Do', 		1, 				2),
						('quanl@gmail.com', 	'quanl', 	'Quan L', 		2, 				1),
						('nhanvie@gmail.com', 	'nhanvie',	'Nhan Vie', 	2, 				2),
						('baov@gmail.com', 		'baov', 	'Bao V', 		2, 				2),
                        ('chuti@gmail.com', 	'chuti', 	'Chu Ti', 		3, 				4),
						('giamd@gmail.com', 	'giamd', 	'Giam D', 		4, 				4),
						('quan@gmail.com', 		'quan', 	'Quan ',		4, 				3),
						('nhanvi@gmail.com', 	'nhanvi', 	'Nhan Vi', 		4, 				3),
						('bao@gmail.com', 		'bao', 		'Bao ', 		5, 				2);

CREATE TABLE `Group` (
	GroupID			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName		VARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID		MEDIUMINT UNSIGNED NOT NULL,
    CreateDate		DATE DEFAULT(NOW()),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE
);

INSERT INTO `Group` (GroupName, 		CreatorID)
VALUES 				('Nhom Cap Cao', 	2),
					('Nhom Quan Ly', 	3),
					('Nhom Noi Bo', 	3),
					('Nhom Cong Ty', 	3),
					('Nhom Gia Dinh', 	4);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
	GroupID			SMALLINT UNSIGNED NOT NULL,
    AccountID		MEDIUMINT UNSIGNED NOT NULL,
    JoinDate		DATETIME DEFAULT(NOW()),
    FOREIGN KEY (GroupID)	REFERENCES `Group`(GroupID) ON DELETE CASCADE,
    FOREIGN KEY (AccountID)	REFERENCES `Account`(AccountID) ON DELETE CASCADE
);

INSERT INTO GroupAccount (GroupID, AccountID)
VALUES 	(1, 2), (1, 1),
		(2, 3), (2, 1), (2, 2),
		(3, 3), (3, 1), (3, 2), (3, 4),
        (4, 3), (4, 1), (4, 2), (4, 4),
        (5, 4);

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
    FOREIGN KEY (CreatorID)	 REFERENCES `Account`(AccountID) ON DELETE CASCADE
);

INSERT INTO Question 	(Content, 						CategoryID, TypeID, CreatorID)
VALUES 					('Chu Tich ten day du la gi?', 	1, 			1, 		4),
						('Giam Doc la nam hay nu?', 	2, 			1, 		5),
						('Quan Ly sinh nam bao nhieu?', 3, 			2, 		2),
						('Nhan Vien que o dau?', 		4, 			2, 		1),
						('Bao Ve co gia dinh chua?', 	5, 			2, 		3);
INSERT INTO Question 	(Content, 						CategoryID, TypeID, CreatorID)
VALUES 					('Chu Tich ten day du la gi?????????', 	1, 			1, 		4);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
	AnswerID		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content			VARCHAR(100) NOT NULL UNIQUE KEY,
    QuestionID		SMALLINT UNSIGNED NOT NULL,
    isCorrect		BOOLEAN,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE
);

INSERT INTO Answer 	(Content, 						QuestionID, isCorrect)
VALUES 				('Khong ai biet !!!', 			1, 			FALSE),
					('Doan xem =)))', 				2, 			TRUE),
					('Chac la 9x', 					3, 			TRUE),
					('Thanh Hoa', 					4, 			TRUE),
					('Nhin cung khong con tre.', 	5, 			FALSE);

CREATE TABLE Exam (
	ExamID			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`			CHAR(10) NOT NULL UNIQUE KEY,
    Title			VARCHAR(20) NOT NULL UNIQUE KEY,
    CategoryID		TINYINT UNSIGNED NOT NULL,
    Duration		TINYINT UNSIGNED NOT NULL,
    CreatorID		MEDIUMINT UNSIGNED NOT NULL,
    CreateDate		DATE DEFAULT(NOW()),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (CreatorID)	 REFERENCES `Account`(AccountID) ON DELETE CASCADE
);

INSERT INTO Exam 	(`Code`, 	Title, 				CategoryID, Duration, 	CreatorID)
VALUES 				('A1', 		'Thi dau vao', 		1, 			50, 		4),
					('B2', 		'Thi dau ra', 		2, 			100, 		5),
					('C3', 		'Kiem tra dinh ky', 3, 			150, 		2),
					('D4', 		'Thi ky nang', 		4, 			200, 		1),
					('E5', 		'Test IQ', 			5, 			250, 		3);
INSERT INTO Exam 	(`Code`, 	Title, 				CategoryID, Duration, 	CreatorID)
VALUES 				('A', 		'Thi dau va', 		1, 			50, 		4);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
	ExamID			SMALLINT UNSIGNED NOT NULL,
    QuestionID		SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (ExamID)	 REFERENCES Exam(ExamID) ON DELETE CASCADE,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE
);

INSERT INTO ExamQuestion (ExamID, QuestionID)
VALUES 	(1, 2), (1, 1),
		(2, 3), (2, 1), (2, 2),
		(3, 3), (3, 1), (3, 2), (3, 4),
        (4, 3), (4, 1), (4, 2), (4, 4), (4, 5),
        (5, 4), (5, 5);