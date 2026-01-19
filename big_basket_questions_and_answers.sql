-- Who are the top 10 customers by total revenue, and how many orders did each place?

SELECT  o.customer_id, SUM(oi.quantity * oi.unit_price) AS total_revenue,
		COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_revenue DESC
LIMIT 10;


-- What is the average order value (AOV) by customer segment?

WITH customer_avg_value AS (
						SELECT  c.customer_id, c.customer_segment,
								SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id) AS avg_order_value
						FROM customers c
                        JOIN orders o
                        ON c.customer_id = o.customer_id
                        JOIN order_items oi
                        ON o.order_id = oi.order_id
                        GROUP BY c.customer_id, c.customer_segment)
SELECT customer_segment, AVG(avg_order_value) AS avg_order_value
FROM customer_avg_value
GROUP BY customer_segment
ORDER BY avg_order_value DESC;

-- Identify customers who placed only one order (one-time customers).

SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name 
HAVING COUNT(o.order_id) = 1;

-- What percentage of customers gave negative feedback (rating ≤ 2)?

SELECT  100.0 * SUM(CASE WHEN sentiment = 'Negative' THEN 1 ELSE 0 END) / 
		COUNT(*) AS negative_feedback_precentage
FROM customer_feedback;

-- Which areas have the highest customer complaints?

SELECT  c.area,
		SUM(CASE WHEN sentiment = 'Negative' THEN 1 ELSE 0 END) AS complaints_count
FROM customers c
JOIN customer_feedback cf
ON c.customer_id = cf.customer_id
GROUP BY c.area
ORDER BY complaints_count DESC;

-- What is the daily and monthly order trend?

SELECT  DATE_FORMAT(order_date, '%Y-%m') AS date_month, 
        COUNT(*) as order_count
FROM orders															-- MONTHLY ORDER COUNTS
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY date_month;

SELECT  DATE(order_date) AS date_day,
        COUNT(*) as order_count
FROM orders													-- DAILY ORDER COUNTS
GROUP BY DATE(order_date)
ORDER BY date_day;

-- Which products generate the highest revenue but low quantity sold?

WITH total AS (
				SELECT  p.product_id, p.product_name,
						SUM(oi.quantity) AS total_quantity_sold, SUM(oi.unit_price) AS total_revenue_pre_product
				FROM products p
				JOIN order_items oi
				ON p.product_id = oi.product_id
				GROUP BY p.product_id, p.product_name)
SELECT  product_id, product_name, 
		total_quantity_sold, total_revenue_pre_product
FROM total
WHERE total_revenue_pre_product > ( SELECT AVG(total_revenue_pre_product) FROM total)
AND total_quantity_sold <= (SELECT AVG(total_quantity_sold) FROM total)
ORDER BY total_revenue_pre_product DESC;

-- Find the top 5 products per category by revenue.

SELECT category, total_revenue
FROM (
		SELECT  p.category, 
				SUM(oi.quantity * oi.unit_price) AS total_revenue,
				DENSE_RANK() OVER(ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS rnk
		FROM products p
		JOIN order_items oi
		ON p.product_id = oi.product_id
		GROUP BY p.category) AS t
WHERE rnk <=5;

-- Which payment method contributes the most revenue?

SELECT  o.payment_method,
		COUNT(DISTINCT o.order_id) AS total_orders,
		ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue,
		ROUND(
        100.0 * SUM(oi.quantity * oi.unit_price)
        / SUM(SUM(oi.quantity * oi.unit_price)) OVER (),
        2
    ) AS revenue_percentage
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.payment_method
ORDER BY total_revenue DESC;

-- What percentage of orders are delivered late?

SELECT  ROUND(
				100.0 * (SUM(CASE WHEN delivery_status = 'Slightly Delayed' THEN 1 ELSE 0 END) +
						SUM(CASE WHEN delivery_status = 'Significantly Delayed' THEN 1 ELSE 0 END)) / 
				COUNT(DISTINCT order_id),2) AS late_delivery_percantage
FROM orders;

-- Which delivery partners have the highest average delivery time?

SELECT delivery_partner_id, avg_time
FROM  (
		SELECT  delivery_partner_id, AVG(delivery_time_minutes) AS avg_time,
				DENSE_RANK() OVER(ORDER BY AVG(delivery_time_minutes) DESC) AS rnk
		FROM delivery_performance
		GROUP BY delivery_partner_id
		) AS t
WHERE rnk = 1;

-- Compare promised vs actual delivery time and calculate average delay.

SELECT ROUND(AVG(delivery_time_minutes),2) AS avg_delay
FROM delivery_performance
WHERE TIME(promised_time) < TIME(actual_time);

-- Does distance affect delivery delay?

SELECT  CASE 
			WHEN distance_km < 3 THEN '0-3 KM'
			WHEN distance_km < 6 THEN '3-6 KM'
			WHEN distance_km < 10 THEN '6-10 KM'
			ELSE '10+ KM'
	    END AS distance_info,
		ROUND(100.0 * COUNT( CASE 
								WHEN delivery_status IN('Slightly Delayed', 'Significantly Delayed') THEN 1
							 END) / COUNT(*),2) AS delay_percantage
FROM delivery_performance
WHERE distance_km IS NOT NULL
GROUP BY distance_info
ORDER BY delay_percantage;

-- Identify products where damaged stock > 10% of received stock.

SELECT  p.product_id, p.product_name,
		SUM(i.stock_received) AS total_stock_received,
        SUM(i.damaged_stock) AS total_damaged_stocks,
        ROUND( 100.0 * SUM(i.damaged_stock) / SUM(i.stock_received),2) AS damage_percantage
FROM products p
JOIN inventory i
ON p.product_id = i.product_id
WHERE i.stock_received > 0
GROUP BY p.product_id, p.product_name
ORDER BY damage_percantage DESC;

-- Which products are at risk of stock-out (below minimum stock level)?

SELECT  p.product_id, p.product_name,
		p.min_stock_level,
        SUM(i.stock_received) - SUM(i.damaged_stock) AS total_stocks_avlaiable
FROM products p
JOIN inventory i
ON p.product_id = i.product_id
GROUP BY p.product_id, p.product_name
HAVING total_stocks_avlaiable < p.min_stock_level
ORDER BY total_stocks_avlaiable DESC;