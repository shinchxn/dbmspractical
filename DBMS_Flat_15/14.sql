-- 14. PL/SQL block to accept an employee ID and retrieve salary
SET SERVEROUTPUT ON;
DECLARE
    v_sal NUMBER;
BEGIN
    -- The '&' prompts the user to enter an ID when executed
    SELECT Salary INTO v_sal FROM EMPLOYEE WHERE E_ID = &Enter_Emp_ID;
    
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || v_sal);
END;
/