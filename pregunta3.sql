SET SERVEROUTPUT ON;

DECLARE
  -- Variables para guardar los datos *antiguos* del empleado
  v_old_job_id    employees.job_id%TYPE;
  v_old_hire_date employees.hire_date%TYPE;
  v_old_dept_id   employees.department_id%TYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- Iniciando transferencia de empleado 104 ---');
  
  -- 1. Obtenemos los datos ACTUALES (antiguos) del empleado 104
  SELECT job_id, hire_date, department_id
  INTO v_old_job_id, v_old_hire_date, v_old_dept_id
  FROM employees
  WHERE employee_id = 104
  FOR UPDATE; -- Bloquea la fila

  DBMS_OUTPUT.PUT_LINE('Datos antiguos capturados: ' || v_old_job_id || ', Dept: ' || v_old_dept_id || ', Fecha: ' || v_old_hire_date);

  -- 2. Insertamos el registro del trabajo que está terminando HOY
  INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
  VALUES (104, v_old_hire_date, SYSDATE, v_old_job_id, v_old_dept_id);
  
  DBMS_OUTPUT.PUT_LINE('Paso 1/2: INSERT en job_history completado. ' || SQL%ROWCOUNT || ' fila(s) insertadas.');

  -- 3. Actualizamos al empleado con su nuevo departamento
  UPDATE employees
  SET department_id = 110
  WHERE employee_id = 104;
  
  DBMS_OUTPUT.PUT_LINE('Paso 2/2: UPDATE en employees completado. ' || SQL%ROWCOUNT || ' fila(s) actualizadas.');

  -- 4. Si todo salió bien, confirmamos la transacción
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('--- ÉXITO: Transacción confirmada (COMMIT). ---');

EXCEPTION
  -- 5. Si algo falla (ej: depto 110 no existe), revertimos TODO
  WHEN OTHERS THEN
    ROLLBACK; -- Deshace tanto el INSERT como el UPDATE
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('¡ERROR! La transacción ha fallado.');
    DBMS_OUTPUT.PUT_LINE('Se ha ejecutado un ROLLBACK completo.');
    DBMS_OUTPUT.PUT_LINE('Mensaje de Oracle: ' || SQLERRM);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
END;
/
