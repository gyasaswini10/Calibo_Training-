-- ### Exercise 4: GROUP BY with Aggregates
-- Calculate the average salary by department. Display department name, count of employees, average salary, minimum salary, 
-- and maximum salary. Order by average salary in descending order.
-- **Hint:** Join departments and employees, then use GROUP BY with aggregate functions.
-- **Expected columns:** dept_name, employee_count, avg_salary, min_salary, max_salary
select 'exercise 4' as "";
SELECT d.dept_name,
COUNT(e.employee_id) AS employee_count,
AVG(e.salary) AS avg_salary,
MIN(e.salary) AS min_salary,
MAX(e.salary) AS max_salary
FROM departments d
JOIN employees e ON d.dept_id=e.dept_id
GROUP BY d.dept_name
ORDER BY avg_salary DESC;