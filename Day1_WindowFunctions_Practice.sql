
-- WINDOWN FUCTION

-- The Difference with ORDER BY
SELECT gender, AVG(salary)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id=sal.employee_id
GROUP BY gender
;


SELECT dem.first_name, dem.last_name, gender , AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id=sal.employee_id
;

-- OVER
-- Cal each employee's salary relative to company average
 
SELECT dem.first_name, dem.last_name, gender, pd.department_name, salary,
AVG(salary) OVER() As company_avg_salary,
salary - AVG(salary) OVER() AS salary_difference
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
 ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
 ON sal.dept_id = pd.department_id
;    


-- PARTITION
-- Compare invidual salaries to department average
SELECT dem.first_name, dem.last_name, gender, pd.department_name, salary,
AVG(salary) OVER(partition by department_name) As dp_avg_salary,
salary - AVG(salary) OVER(partition by department_name) AS salary_dp_difference
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
 ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
 ON sal.dept_id = pd.department_id
;    


-- ORDER BY( Cumulative/sequence)
SELECT dem.first_name, dem.last_name, gender, pd.department_name, salary,
SUM(salary) OVER( PARTITION BY pd.department_id
  ORDER BY salary DESC, dem.employee_id) AS ROLLING_TOTAL_IN_DEPT
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
 ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
 ON sal.dept_id = pd.department_id
;    


SELECT dem.employee_id, dem.first_name, dem.last_name, gender , salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK () OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id=sal.employee_id
;


-- ANALYTIC FUNCTIONS- These functions allow you to access data from other rows in relation to the current row.

-- LEAD(): accesses data from subsequent rows (looking forward)
-- LAG(): accesses data from subsequent rows (looking backward)

-- Case 1: Compare with the pre-employee in the same Department
SELECT dem.first_name, dem.last_name, department_name, salary,
LAG(salary, 1,0) OVER(partition by pd.department_id ORDER BY salary DESC, dem.employee_id) AS prev_salary,
-- CASE 2: SALARY DIFFRENCE
salary - LAG(salary,1,0) OVER(partition by pd.department_id ORDER BY salary DESC, dem.employee_id) AS diff_from_prev,
-- Case 3: Compare with the next-employee in the same Department
LEAD(salary,1,0) OVER(partition by pd.department_id ORDER BY salary DESC, dem.employee_id) AS next_salary
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem. employee_id= sal.employee_id
JOIN parks_departments pd
	ON sal.dept_id = pd.department_id
; 


-- FIRST_VALUE() - LAST_VALUE()
-- Returns the first or last value in an ordered window 

SELECT dem.first_name, dem.last_name, department_name, salary,
-- Case 1: FISRT_VALUE
FIRST_VALUE(salary) OVER(PARTITION BY pd.department_id ORDER BY salary DESC) AS fisrt_value_in_dp,
-- CASE 2: LAST_VALUE** NOTE: in SQL, default: ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
LAST_VALUE(salary) OVER(PARTITION BY pd.department_id ORDER BY salary DESC 
	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Last_value_in_dp,

-- Application
-- Case 3: 
salary / FIRST_VALUE(salary) OVER(PARTITION BY pd.department_id ORDER BY salary DESC) AS ratio_to_top,
salary - LAST_VALUE(salary) OVER (
  PARTITION BY pd.department_id 
  ORDER BY salary DESC
  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS gap_from_lowest,

-- Range (max - min)
  FIRST_VALUE(salary) OVER(
    PARTITION BY pd.department_id 
    ORDER BY salary DESC, dem.employee_id
  )
  -
  LAST_VALUE(salary) OVER(
    PARTITION BY pd.department_id 
    ORDER BY salary DESC, dem.employee_id
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS range_in_dp

FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem. employee_id= sal.employee_id
JOIN parks_departments pd
	ON sal.dept_id = pd.department_id
;


-- ROW, RANGE, INTERVAL
SELECT first_name, salary,
SUM( salary) OVER (ORDER BY salary ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as ROLLING_3_ROWS_ROW,
-- BY ROW
SUM( salary) OVER (ORDER BY salary Range BETWEEN 2000 PRECEDING AND CURRENT ROW) as ROLLING_3_ROWS_RANGE
FROM employee_salary
;-- BY VALUE


-- RANGE INTERVAL
/* DAY 1: WINDOW FUNCTIONS PRACTICE
   Note: Using birth_date for a rolling 7-day sum is for syntax practice only.
   In a real project, this should be applied to 'Transaction_Date' or 'Order_Date'.
*/
SELECT 
    dem.first_name,
    dem.birth_date, 
    sal.salary, 
    SUM(sal.salary) OVER( 
        ORDER BY dem.birth_date  
        RANGE BETWEEN INTERVAL 7 DAY PRECEDING AND CURRENT ROW
    ) AS rolling_7_day_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal 
    ON dem.employee_id = sal.employee_id
ORDER BY dem.birth_date;



