-- Create Audit Table
CREATE TABLE EMPLOYEE_AUDIT (
    EmpID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    OpDate DATE,
    OpType VARCHAR(20)
);

-- Create Update Trigger
DELIMITER //

CREATE TRIGGER salary_audit
AFTER UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    INSERT INTO EMPLOYEE_AUDIT
    VALUES (
        OLD.EmpID,
        OLD.Salary,
        NEW.Salary,
        CURDATE(),
        'UPDATE'
    );
END //

DELIMITER ;