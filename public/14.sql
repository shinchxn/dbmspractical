-- Create table
CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert records
INSERT INTO EMPLOYEE VALUES
(1, 'Alice', 30000),
(2, 'Bob', 40000),
(3, 'Charlie', 50000);

-- Create procedure
DELIMITER //

CREATE PROCEDURE GetSalary(IN id INT)
BEGIN
    SELECT Salary
    FROM EMPLOYEE
    WHERE EmpID = id;
END //

DELIMITER ;

-- Execute procedure
CALL GetSalary(1);