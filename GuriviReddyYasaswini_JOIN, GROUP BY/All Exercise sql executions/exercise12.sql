

-- ### Exercise 12: Date-Based Grouping
-- Show monthly order statistics for 2024. Display month (YYYY-MM format), order count, monthly revenue, and average order value. Order by month.
-- **Hint:** Use date functions to extract year-month. Functions vary by database:
-- - SQLite: `strftime('%Y-%m', order_date)`
-- - MySQL: `DATE_FORMAT(order_date, '%Y-%m')`
-- - PostgreSQL: `TO_CHAR(order_date, 'YYYY-MM')`
-- **Expected columns:** month, order_count, monthly_revenue, avg_order_value
select 'exercise 12' as '';
select date_format(order_date,'%Y-%m') as month,
count(order_id) as order_count,
sum(total_amount) as monthly_revenue,
avg(total_amount) as avg_order_value
from orders
where year(order_date)=2024
group by date_format(order_date,'%Y-%m')
order by month;

