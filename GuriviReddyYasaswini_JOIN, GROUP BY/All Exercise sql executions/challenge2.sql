-- ### Challenge 2: Product Affinity Analysis
-- Find products that are frequently bought together (appear in the same order at least twice). Display the two product names and how many times they were bought together.

-- **Hint:** Self-join order_details on order_id, ensure product_id1 < product_id2 to avoid duplicates.


-- **Expected columns:** product_1, product_2, times_bought_together

select 'challenge 2' as '';

select p1.product_name as product_1,
p2.product_name as product_2,
count(*) as times_bought_together
from order_details od1
join order_details od2
on od1.order_id=od2.order_id
and od1.product_id<od2.product_id
join products p1 on od1.product_id=p1.product_id
join products p2 on od2.product_id=p2.product_id
group by p1.product_name,p2.product_name
having count(*)>=2;


-- ## Tips for Success

-- 1. **Read the requirements carefully** - Make sure you understand what data is requested
-- 2. **Start with the FROM clause** - Identify which tables you need
-- 3. **Add JOINs one at a time** - Build your query incrementally
-- 4. **Test your query** - Run it to see if you get the expected columns
-- 5. **Check your results** - Do the numbers make sense?
-- 6. **Use table aliases** - Makes queries more readable (e.g., `FROM employees e`)
-- 7. **Format your SQL** - Use proper indentation and line breaks
-- 8. **Comment your code** - Add comments to explain complex logic

-- ## Common Mistakes to Avoid

-- - Forgetting to include columns in GROUP BY that appear in SELECT
-- - Using WHERE instead of HAVING for filtering aggregated results
-- - Incorrect JOIN conditions leading to Cartesian products
-- - Not using LEFT JOIN when you need to include unmatched records
-- - Forgetting to order results when specified

-- ## Submission Guidelines

-- 1. Save your queries in a file named `firstname_lastname_sql_lab.sql`
-- 2. Include comments with your name and the exercise number
-- 3. Format your SQL code properly with indentation
-- 4. Test all queries before submission
-- 5. Submit your file to your trainer
-- ## Evaluation Criteria
-- Your work will be evaluated on:
-- - **Correctness (60%)** - Does the query return the expected results?
-- - **Query Structure (20%)** - Proper use of JOINs, GROUP BY, and HAVING?
-- - **Efficiency (10%)** - Is the query reasonably optimized?
-- - **Code Quality (10%)** - Is the SQL clean, readable, and well-formatted?

-- Good luck with your exercises!