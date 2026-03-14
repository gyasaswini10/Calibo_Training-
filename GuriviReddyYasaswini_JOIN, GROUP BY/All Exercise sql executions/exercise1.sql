-- ### Exercise 1: Basic INNER JOIN
-- List all employees with their department names. Display employee ID, 
-- first name, last name, and department name. Order the results by employee ID.

-- **Hint:** You need to join the employees and departments tables.
-- **Expected columns:** employee_id, first_name, last_name, dept_name

select e.employee_id,e.first_name,e.last_name,d.dept_name
from employees e
join departments d on e.dept_id=d.dept_id
order by e.employee_id;
