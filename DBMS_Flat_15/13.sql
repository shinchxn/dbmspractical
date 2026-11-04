
-- Create employee table
CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Create audit table
CREATE TABLE SALARY_AUDIT (
    EmpID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2)
);

-- Insert employee records
INSERT INTO EMPLOYEE VALUES
(1, 'Alice', 30000),
(2, 'Bob', 40000);

-- Create update trigger
DELIMITER //

CREATE TRIGGER Salary_Update
AFTER UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF OLD.Salary <> NEW.Salary THEN
        INSERT INTO SALARY_AUDIT
        VALUES (OLD.EmpID, OLD.Salary, NEW.Salary);
    END IF;
END //

DELIMITER ;

-- Update employee salary
UPDATE EMPLOYEE
SET Salary = 35000
WHERE EmpID = 1;

-- Display employee table
SELECT * FROM EMPLOYEE;

-- Display audit table
SELECT * FROM SALARY_AUDIT;
