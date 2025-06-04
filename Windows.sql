SELECT 
    employee_id,
    first_name,
    last_name,
    salary,
    department_id,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_salary_rank,
    salary - LAG(salary, 1) OVER (PARTITION BY department_id ORDER BY salary) AS salary_diff_from_prev,
    salary / AVG(salary) OVER (PARTITION BY department_id) * 100 AS salary_percent_of_dept_avg
FROM 
    employees
WHERE 
    department_id IS NOT NULL;
