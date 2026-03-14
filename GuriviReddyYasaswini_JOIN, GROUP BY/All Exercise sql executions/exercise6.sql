
-- ### Exercise 6: SELF JOIN
-- List all employees with their manager's name. Display employee ID, 
-- employee full name, employee salary, manager full name, and manager salary. Order by employee ID.
-- **Hint:** Join the employees table to itself. Use LEFT JOIN to include employees without managers.
-- **Expected columns:** employee_id, employee_name, employee_salary, manager_name, manager_salary
select 'exercise 6' as '';
select e.employee_id as employee_id,
concat(e.first_name,' ',e.last_name) as employee_name,
e.salary as employee_salary,
concat(m.first_name,' ',m.last_name) as manager_name,
m.salary as manager_salary
from employees e
left join employees m on e.manager_id=m.employee_id
order by e.employee_id;