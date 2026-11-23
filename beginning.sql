SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT first_name,
last_name,
age
FROM parks_and_recreation.employee_demographics;


SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;
SELECT *
FROM employee_salary
WHERE first_name= 'Leslie'
;

SELECT *
FROM employee_salary
WHERE salary = 50000
;


SELECT *
FROM employee_demographics
WHERE gender !='Female';

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';

-- AND OR NOT--LOGICAL OPERATORS
SELECT *
FROM employee_demographics
WHERE (first_name ='Leslie' AND age= 44) OR age >60
;


-- LIKE STATEMENT--
 -- % and _
SELECT *
FROM employee_demographics
WHERE first_name= 'Jerry'
;


SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%'
;

 SELECT *
FROM employee_demographics
WHERE first_name LIKE 'er%'
;
 
SELECT *
FROM employee_demographics
WHERE first_name LIKE '%er%'
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___'
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a____'
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%'
;



-- GROUP By
SELECT gender, AVG(age), MAX(age), MIN(age)
FROM employee_demographics
GROUP BY gender
;



-- ORDER BY
SELECT*
FROM employee_demographics
ORDER BY first_name ASC;

SELECT*
FROM employee_demographics
ORDER BY first_name DESC;

SELECT*
FROM employee_demographics
ORDER BY gender, age
;

-- HAVING VS WHERE
SELECT gender, avg(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;


SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary)> 60000
;

-- LIMIT AND ALIASING

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3
;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2,1
;


SELECT gender, avg(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age>40;

