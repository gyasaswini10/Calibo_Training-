use employees;

/* 1.Highest salaried employee of Finance */
select "exercise 1 " as " ";
with cte1 as(
select e.emp_no
from employees e
join salaries s on e.emp_no=s.emp_no
join dept_emp de on e.emp_no=de.emp_no
join departments d on de.dept_no=d.dept_no
where s.to_date='9999-01-01'
and de.to_date='9999-01-01'
and d.dept_name='Finance'
order by s.salary desc
limit 1
)
select emp_no as emp_number from cte1;

/* 2.Current manager of Production */
select "exercise 2 " as " ";
with cte2 as(
select dm.emp_no
from dept_manager dm
join departments d on dm.dept_no=d.dept_no
where d.dept_name='Production'
and dm.to_date='9999-01-01'
)
select emp_no as emp_number from cte2;

/* 3.How many managers worked in Human Resources */
select "exercise 3 " as " ";
with cte3 as(
select distinct dm.emp_no
from dept_manager dm
join departments d on dm.dept_no=d.dept_no
where d.dept_name='Human Resources'
)
select count(emp_no) as manager_count from cte3;

/* 4.Salary of current manager of Production */
select "exercise 4 " as " ";
with cte4 as(
select s.salary
from dept_manager dm
join salaries s on dm.emp_no=s.emp_no
join departments d on dm.dept_no=d.dept_no
where dm.to_date='9999-01-01'
and s.to_date='9999-01-01'
and d.dept_name='Production'
)
select salary as manager_salary from cte4;

/* 5.Name starts with a ends with s and 5 letters with salary */
select "exercise 5 " as "";
with cte5 as(
select s.salary
from employees e
join salaries s on e.emp_no=s.emp_no
where s.to_date='9999-01-01'
and e.first_name like 'a___s'
)
select salary from cte5;

/* 6.Hire date and from date difference */
select "exercise 6 " as "";
with cte6 as(
select datediff(de.from_date,e.hire_date) diff
from employees e
join dept_emp de on e.emp_no=de.emp_no
where e.hire_date<>de.from_date
)
select diff as date_difference from cte6;

/* 7.Highest salaried manager */
select "exercise 7 " as "";
with cte7 as(
select dm.emp_no
from dept_manager dm
join salaries s on dm.emp_no=s.emp_no
where dm.to_date='9999-01-01'
and s.to_date='9999-01-01'
order by s.salary desc
limit 1
)
select emp_no as emp_number from cte7;

/* 8.Manager earning less than highest employee of department */
select "exercise 8 " as "";
with mgr as(
select dm.emp_no,dm.dept_no,s.salary
from dept_manager dm
join salaries s on dm.emp_no=s.emp_no
where dm.to_date='9999-01-01'
and s.to_date='9999-01-01'
),
emp as(
select de.dept_no,max(s.salary) max_salary
from dept_emp de
join salaries s on de.emp_no=s.emp_no
where de.to_date='9999-01-01'
and s.to_date='9999-01-01'
group by de.dept_no
)
select mgr.emp_no as emp_number
from mgr
join emp on mgr.dept_no=emp.dept_no
where mgr.salary<emp.max_salary;

/* 9.Manager with highest salary among all departments */
select "exercise 9 " as "";
with cte9 as(
select dm.emp_no
from dept_manager dm
join salaries s on dm.emp_no=s.emp_no
where dm.to_date='9999-01-01'
and s.to_date='9999-01-01'
order by s.salary desc
limit 1
)
select emp_no as emp_number from cte9;

/* 10.Employees not assigned to any department currently */
select exercise10 as "";
with cte10 as(
select emp_no
from dept_emp
where to_date='9999-01-01'
)
select e.emp_no as emp_number
from employees e
left join cte10 c on e.emp_no=c.emp_no
where c.emp_no is null;
