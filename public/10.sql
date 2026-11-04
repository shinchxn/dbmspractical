
-- Create table
CREATE TABLE STUDENT (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    CGPA DECIMAL(3,2)
);

-- Insert records
INSERT INTO STUDENT VALUES
(1, 'Alice', 'CSE', 8.5),
(2, 'Bob', 'IT', 7.2),
(3, 'Charlie', 'CSE', 9.1),
(4, 'David', 'IT', 8.0),
(5, 'Eve', 'ECE', 8.5);

-- Parameterized cursor
DELIMITER //

CREATE PROCEDURE DisplayStudents(IN dept VARCHAR(50))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE sid INT;
    DECLARE sname VARCHAR(50);
    DECLARE cg DECIMAL(3,2);

    DECLARE cur CURSOR FOR
        SELECT StudentID, Name, CGPA
        FROM STUDENT
        WHERE Department = dept AND CGPA > 7.5;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO sid, sname, cg;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT sid AS StudentID,
               sname AS Name,
               cg AS CGPA;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

-- Execute procedure
CALL DisplayStudents('CSE');
