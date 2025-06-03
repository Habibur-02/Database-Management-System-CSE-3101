SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary,
    MAX(e.salary) AS max_salary
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    e.hire_date > DATE_SUB(CURRENT_DATE(), INTERVAL 5 YEAR)
GROUP BY 
    d.department_name
HAVING 
    COUNT(e.employee_id) > 5
ORDER BY 
    avg_salary DESC;
