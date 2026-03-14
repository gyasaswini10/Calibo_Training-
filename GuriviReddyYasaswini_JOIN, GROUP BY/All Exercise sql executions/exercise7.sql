

-- ### Exercise 7: Complex Aggregation
-- Find the total revenue by product category. Display category, count of distinct orders, 
-- total units sold, and total revenue. Order by total revenue in descending order.
-- **Hint:** Join products and order_details, calculate revenue as quantity × unit_price.
-- **Expected columns:** category, order_count, total_units_sold, total_revenue
select 'exercise 7' as '';

select p.category as category,
count(distinct od.order_id) as order_count,
sum(od.quantity) as total_units_sold,
sum(od.quantity*od.unit_price) as total_revenue
from products p
join order_details od on p.product_id=od.product_id
group by p.category
order by total_revenue desc;

