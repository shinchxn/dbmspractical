-- 12. Trigger to prevent salary below ₹15,000
CREATE OR REPLACE TRIGGER trg_min_sal
BEFORE INSERT OR UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF :NEW.Salary < 15000 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be below 15,000');
    END IF;
END;
/