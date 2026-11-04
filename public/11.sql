
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

-- Create stored procedure
DELIMITER //

CREATE PROCEDURE UPDATE_SALARY(
    IN id INT,
    IN percentage DECIMAL(5,2)
)
BEGIN
    UPDATE EMPLOYEE
    SET Salary = Salary + (Salary * percentage / 100)
    WHERE EmpID = id;
END //

DELIMITER ;

-- Execute procedure (increase by 10%)
CALL UPDATE_SALARY(1, 10);

-- Display updated records
SELECT * FROM EMPLOYEE;
