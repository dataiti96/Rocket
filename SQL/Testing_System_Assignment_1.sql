DROP DATABASE IF EXISTS Testing_System;
CREATE DATABASE Testing_System;
USE Testing_System;

CREATE TABLE Department (
	DepartmentID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName	VARCHAR(20) NOT NULL UNIQUE KEY
);

CREATE TABLE Position (
	PositionID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName	ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);

CREATE TABLE `Account` (
	AccountID		MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email			VARCHAR(50) UNIQUE KEY,
    Username		CHAR(20) NOT NULL UNIQUE KEY,
    FullName		VARCHAR(30) NOT NULL,
    DepartmentID	TINYINT UNSIGNED NOT NULL,
    PositionID		TINYINT UNSIGNED NOT NULL,
    CreateDate		DATE NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID)   REFERENCES `Position`(PositionID)
);

CREATE TABLE `Group` (
	GroupID			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName		VARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID		MEDIUMINT UNSIGNED NOT NULL,
    CreateDate		DATE NOT NULL,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

CREATE TABLE GroupAccount (
	GroupID			SMALLINT UNSIGNED NOT NULL,
    AccountID		MEDIUMINT UNSIGNED NOT NULL,
    JoinDate		DATETIME NOT NULL,
    FOREIGN KEY (GroupID)	REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID)	REFERENCES `Account`(AccountID)
);

CREATE TABLE TypeQuestion (
	TypeID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName		ENUM('Essay', 'Multiple-Choice')
);

CREATE TABLE CategoryQuestion (
	CategoryID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName	ENUM('Java', '.NET', 'SQL', 'Postman', 'Ruby', 'Others')
);

CREATE TABLE Question (
	QuestionID		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content			VARCHAR(100) NOT NULL UNIQUE KEY,
    CategoryID		TINYINT UNSIGNED NOT NULL,
    TypeID			TINYINT UNSIGNED NOT NULL,
    CreatorID		MEDIUMINT UNSIGNED NOT NULL,
    CreateDate		DATETIME NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (TypeID)	 REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY (CreatorID)	 REFERENCES `Account`(AccountID)
);

CREATE TABLE Answer (
	AnswerID		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content			VARCHAR(100) NOT NULL UNIQUE KEY,
    QuestionID		SMALLINT UNSIGNED NOT NULL,
    isCorrect		ENUM('TRUE', 'FALSE'),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

CREATE TABLE Exam (
	ExamID			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`			CHAR(10) NOT NULL UNIQUE KEY,
    Title			VARCHAR(20) NOT NULL UNIQUE KEY,
    CategoryID		TINYINT UNSIGNED NOT NULL,
    Duration		TIME NOT NULL,
    CreatorID		MEDIUMINT UNSIGNED NOT NULL,
    CreateDate		DATE NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (CreatorID)	 REFERENCES `Account`(AccountID)
);

CREATE TABLE ExamQuestion (
	ExamID			SMALLINT UNSIGNED NOT NULL,
    QuestionID		SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (ExamID)	 REFERENCES Exam(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);