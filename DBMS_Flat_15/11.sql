-- 11. Stored procedure UPDATE_SALARY
CREATE OR REPLACE PROCEDURE UPDATE_SALARY(p_id INT, p_pct NUMBER) IS
BEGIN
    UPDATE EMPLOYEE 
    SET Salary = Salary + (Salary * p_pct / 100) 
    WHERE E_ID = p_id;
    
    COMMIT;
END;
/

-- To test/execute the procedure (e.g., increase Emp 1's salary by 10%):
EXEC UPDATE_SALARY(1, 10);