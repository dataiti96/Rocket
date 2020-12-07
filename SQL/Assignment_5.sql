DROP TRIGGER IF EXISTS I;
DELIMITER $$
CREATE TRIGGER I
BEFORE INSERT ON project_modules FOR EACH ROW
BEGIN
	IF NEW.ProjectModulesDate < (SELECT ProjectStartDate FROM projects WHERE ProjectID = NEW.ProjectID)
    OR NEW.ProjectModulesCompletedOn > (SELECT ProjectCompletedOn FROM projects WHERE ProjectID = NEW.ProjectID)
    THEN SIGNAL SQLSTATE '12345' SET MESSAGE_TEXT = 'Ngay khong hop le !';
    END IF;
END$$
DELIMITER ;

DROP VIEW IF EXISTS V;
CREATE VIEW V AS (
	SELECT *
    FROM trainee
    WHERE ET_IQ + ET_Gmath>=20 AND ET_IQ>=8 AND ET_Gmath>=8 AND ET_English>=18 
);