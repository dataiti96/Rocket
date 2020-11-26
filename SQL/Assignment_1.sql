DROP DATABASE IF EXISTS  Fresher_Training;
CREATE DATABASE Fresher_Training;
USE Fresher_Training;

CREATE TABLE Trainee (
	TraineeID			MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Full_Name			VARCHAR(50) NOT NULL,
    Birth_Date			DATE NOT NULL,
    Gender				ENUM('male', 'female', 'unknown'),
    ET_IQ				TINYINT UNSIGNED,
    ET_Gmath			TINYINT UNSIGNED,
    ET_English			TINYINT UNSIGNED,
    Training_Class		CHAR(10) NOT NULL,
    Evaluation_Notes	TEXT
);

ALTER TABLE trainee
ADD COLUMN VTI_Account VARCHAR(50) NOT NULL UNIQUE KEY;

CREATE TABLE Exercise_2 (
	ID				MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Name`			VARCHAR(50),
    `Code`			CHAR(5),
    ModifiedDate	DATETIME
);

CREATE TABLE Exercise_3 (
	ID				MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Name`			VARCHAR(50),
    BirthDate		DATE,
    Gender			ENUM('Male', 'Female') DEFAULT('Unknown'),
    IsDeletedFlag	ENUM('0', '1')
);