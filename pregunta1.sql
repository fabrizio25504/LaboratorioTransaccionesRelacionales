DECLARE
    v_count_90 NUMBER;
    v_count_60 NUMBER;
BEGIN
    UPDATE hr.employees 
    SET salary = salary * 1.1
    WHERE department_id = 90;
    
    SAVEPOINT point1;
    
    UPDATE hr.employees 
    SET salary = salary * 1.05
    WHERE department_id = 60;
    
    ROLLBACK TO point1;
    
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocurrió un error, revirtiendo todo.');
        ROLLBACK;    
END;
