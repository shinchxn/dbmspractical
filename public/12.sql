
-- Create table
CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert valid records
INSERT INTO EMPLOYEE VALUES
(1, 'Alice', 20000),
(2, 'Bob', 25000);

-- Trigger before insert
DELIMITER //

CREATE TRIGGER Check_Salary_Insert
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF NEW.Salary < 15000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be at least 15000';
    END IF;
END //

-- Trigger before update
CREATE TRIGGER Check_Salary_Update
BEFORE UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF NEW.Salary < 15000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be at least 15000';
    END IF;
END //

DELIMITER ;

-- Test valid insert
INSERT INTO EMPLOYEE VALUES (3, 'Charlie', 18000);

-- Test valid update
UPDATE EMPLOYEE
SET Salary = 30000
WHERE EmpID = 1;

-- Display records
SELECT * FROM EMPLOYEE;
