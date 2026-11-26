-- CTes

WITH CTE_Example AS
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
GROUP BY gender
)
SELECT AVG( avg_sal) # AVG OF F & M 
FROM CTE_Example # if after here u call  SELECT AVG( avg_sal) FROM CTE_Example -> not work cuz u not create the real cte table in data
;

# ANOTHER WAY to get same result like- put the select at first- shorter but the 1st is better, clearer
SELECT AVG( avg_sal)
FROM(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
GROUP BY gender
) AS example_CTE_subquery
;

# SET THE COLUMNS NAME AT FIRST( 2 WAYS: SET AT CTE declaration OR  in SELECT alias)
WITH CTE_Example (Gender, AVG_sal, MAX_sal, MIN_sal, COUNT_sal) AS
(
SELECT gender, AVG(salary), MAX(salary), MIN(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example
;




# CREATE MUL CTE TABLE
WITH CTE_Example AS
(
SELECT employee_id,gender,birth_date 
FROM employee_demographics dem
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(
SELECT employee_id,salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id
;



