-- ### Exercise 5: HAVING Clause
-- Find departments with an average salary greater than 65000 and more than 2 employees. Display 
-- department name, employee count, and average salary. Order by average salary in descending order.
-- **Hint:** Use HAVING clause to filter groups after aggregation.
-- **Expected columns:** dept_name, employee_count, avg_salary
select 'exercise 5' as '';
select d.dept_name as dept_name,
count(e.employee_id) as employee_count,
avg(e.salary) as avg_salary
from departments d,employees e
where d.dept_id=e.dept_id
group by d.dept_name
having avg(e.salary)>65000
and count(e.employee_id)>2
order by avg_salary desc;