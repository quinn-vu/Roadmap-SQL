-- Trigger: Automatically executes when a specific database action happens (INSERT, UPDATE, DELETE).

 SELECT *
 FROM employee_demographics;
 
 
 SELECT *
 FROM employee_salary;
 
DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN 
	INSERT INTO employee_demographics ( employee_id, first_name, last_name)
    VALUE ( NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUE(13, 'Quinn', 'Vu', 'DA 720 CEO', 100000, NULL);
