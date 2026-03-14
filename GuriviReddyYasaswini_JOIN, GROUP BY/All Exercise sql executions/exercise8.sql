-- ### Exercise 8: JOINs with WHERE and HAVING
-- Find customers who have placed more than 1 completed order and their total spending. Display customer ID, customer name, count of completed orders,
--  and total spent. Order by total spent in descending order.

-- **Hint:** Filter for completed orders using WHERE, then use HAVING to filter groups with more than 1 order.
-- **Expected columns:** customer_id, customer_name, completed_orders, total_spent
select 'exercise 8' as '';
select c.customer_id as customer_id,
c.customer_name as customer_name,
count(o.order_id) as completed_orders,
sum(o.total_amount) as total_spent
from customers c
join orders o on c.customer_id=o.customer_id
where o.status='Completed'
group by c.customer_id,c.customer_name
having count(o.order_id)>1
order by total_spent desc;
