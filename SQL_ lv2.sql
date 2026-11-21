-- JOIN
-- inner join
SELECT*
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
 ON dem.employee_id = sal.employee_id
 ;
-- outer join
SELECT*
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
 ON dem.employee_id = sal.employee_id
;

SELECT*
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
 ON dem.employee_id = sal.employee_id
;

SELECT  emp1.first_name AS EMPLOYEE, emp2.last_name AS MANAGER
FROM employee_salary emp1
JOIN employee_salary emp2
ON emp1.employee_id +1  = emp2.employee_id;
;

-- JOIN MUL TABLES
SELECT*
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
 ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
 ON sal.dept_id = pd.department_id
;

-- UNION--

SELECT last_name, first_name, "OLD MAN" as label
FROM employee_demographics
WHERE age>40 AND GENDER="male"
UNION
SELECT last_name, first_name, 'OLD LADY' AS LABEL
FROM employee_demographics
WHERE age>40 AND GENDER="female"
UNION 
SELECT last_name, first_name, 'High Pay' AS LABEL
FROM employee_salary
WHERE salary >70000
;


-- STRING FUNCTION
SELECT UPPER('quynh');  
SELECT LOWER('QUYNH');   
SELECT TRIM( ' hello ' );-- delete blank
SELECT CONCAT('Vu', ' ', 'Quynh');  
SELECT SUBSTRING('Hello World',1,6);

SELECT birth_date, SUBSTRING(birth_date,6,2) AS birth_month
FROM employee_demographics;

SELECT LENGTH('hello');  
SELECT LOCATE('o', 'Hello'); 
SELECT REPLACE( 'Tôi yêu SQL' , 'SQL','Python');

SELECT first_name, REPLACE(first_name, 'A', 'a')
FROM employee_demographics;

SELECT LEFT('Hello', 2);   

SELECT first_name, LEFT( first_name, 4)
FROM employee_demographics;

SELECT RIGHT('Hello', 2); 


SELECT first_name, last_name,
CONCAT(first_name,' ', last_name) AS ful_name
FROM employee_demographics   
;

-- CASE STATEMENT--

SELECT first_name, last_name,age,
CASE
	WHEN age<=30 THEN 'young'
    WHEN age BETWEEN 31 AND 51 THEN 'old'
    WHEN age>= 50 THEN "on death's door"
END AS Age_bracket
FROM employee_demographics ;


-- PAY increase and bonus
-- < 50000 =5%
-- > 50000= 7%
-- Finance = 10% Bonus


SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary *0.05)
    WHEN salary >= 50000 THEN salary + (salary *0.07)
END AS new_salary,
CASE
	when dept_id=6 Then salary*.10
END AS bonus
FROM employee_salary;


-- SUBQUERIES

SELECT *
FROM employee_demographics
WHERE employee_id IN
					(SELECT employee_id
							FROM employee_salary
                            WHERE dept_id= 1)
;						

SELECT first_name, salary,
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary
;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;


SELECT gender, AVG(`MAX(age)`) -- ** not ' '
FROM
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
GROUP BY gender
;


SELECT AVG(max_age)
FROM
(SELECT gender, AVG(age) AS avg_age, 
				MAX(age) AS max_age, 
                MIN(age) AS min_age, 
                COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
;




