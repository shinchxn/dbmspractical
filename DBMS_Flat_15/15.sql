-- 15. Create Audit Table
CREATE TABLE EMPLOYEE_AUDIT (
    E_ID INT,
    Old_Sal NUMBER,
    New_Sal NUMBER,
    Op_Date DATE,
    Op_Type VARCHAR(10)
);

-- Update trigger to record salary changes
CREATE OR REPLACE TRIGGER trg_audit_sal
AFTER UPDATE OF Salary ON EMPLOYEE
FOR EACH ROW
BEGIN
    INSERT INTO EMPLOYEE_AUDIT 
    VALUES (:OLD.E_ID, :OLD.Salary, :NEW.Salary, SYSDATE, 'UPDATE');
END;
/