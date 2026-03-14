-- ### Exercise 2: LEFT JOIN to Find Missing Data
-- Find all customers and their order count, including customers who haven't placed any orders. 
-- Display customer ID, customer name, and the count of orders. Order by order count in descending order.
-- **Hint:** Use LEFT JOIN to include customers with no orders, and COUNT with GROUP BY.
-- **Expected columns:** customer_id, customer_name, order_count
select c.customer_id,c.customer_name,
count(o.order_id) as order_count
from customers c
left join orders o on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name
order by order_count desc; 
