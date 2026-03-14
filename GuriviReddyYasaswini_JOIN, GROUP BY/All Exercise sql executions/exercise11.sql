


-- ### Exercise 11: Subquery with GROUP BY
-- Find departments where the average salary is above the company average. Display department name, department average salary
-- , and company average salary. Order by department average salary in descending order.
-- **Hint:** Use a subquery in the HAVING clause to compare against the overall average.
-- **Expected columns:** dept_name, dept_avg_salary, company_avg_salary
select 'exercise 11' as '';
select d.dept_name as dept_name,
avg(e.salary) as dept_avg_salary,
(select avg(salary) from employees) as company_avg_salary
from departments d
join employees e on d.dept_id=e.dept_id
group by d.dept_name
having avg(e.salary)>(select avg(salary) from employees)
order by dept_avg_salary desc;