-- Create table
CREATE TABLE Marks (
    Regno INT PRIMARY KEY,
    Name VARCHAR(50),
    Dept VARCHAR(50),
    Subj1 INT,
    Subj2 INT,
    Subj3 INT
);

-- Insert records
INSERT INTO Marks VALUES
(101, 'Alice', 'Computer Science', 85, 90, 88),
(102, 'Bob', 'Information Tech', 70, 75, 80),
(103, 'Charlie', 'Computer Science', 95, 98, 92),
(104, 'David', 'Electronics', 60, 65, 70);

-- a) Add Total column
ALTER TABLE Marks ADD Total INT;

-- b) Calculate total
UPDATE Marks
SET Total = Subj1 + Subj2 + Subj3;

-- Display all records
SELECT * FROM Marks;

-- c) Second highest total
SELECT DISTINCT Total
FROM Marks
ORDER BY Total DESC
LIMIT 1 OFFSET 1;

-- d) Student with maximum total
SELECT Name
FROM Marks
ORDER BY Total DESC
LIMIT 1;

-- e) Create cursor procedure
DELIMITER //

CREATE PROCEDURE GenerateReportSheet()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE r INT;
    DECLARE n VARCHAR(50);
    DECLARE t INT;

    DECLARE c CURSOR FOR
        SELECT Regno, Name, Total FROM Marks;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN c;

    read_loop: LOOP
        FETCH c INTO r, n, t;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT r AS Regno, n AS Name, t AS Total;
    END LOOP;

    CLOSE c;
END //

DELIMITER ;

-- Execute procedure
CALL GenerateReportSheet();