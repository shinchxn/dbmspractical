-- 13. Create Audit Table
CREATE TABLE EMP_AUDIT (
    E_ID INT,
    Old_Sal NUMBER,
    New_Sal NUMBER,
    Change_Date DATE
);

-- Update trigger to record salary changes
CREATE OR REPLACE TRIGGER trg_audit_sal
AFTER UPDATE OF Salary ON EMPLOYEE
FOR EACH ROW
BEGIN
    INSERT INTO EMP_AUDIT 
    VALUES (:OLD.E_ID, :OLD.Salary, :NEW.Salary, SYSDATE);
END;
/