use olist;
show tables;

#Total Product Revenue
select 
	round(sum(price)) as total_product_revenue
from order_item;

#Total Order Value
select
	round(sum(price + freight_value)) as total_order_value
from order_item;

#Revenue by Product Category
select 
	p.product_category_name,
    round(sum(oi.price), 2) as revenue
from order_item oi
join product_data p
	on oi.product_id = p.product_id
group by p.product_category_name
order by revenue desc;

#Revenue by Month
select 
	date_format(o.order_purchase_timestamp, '%Y-%m') as month,
	round(sum(oi.price),2) as revenue
from order_item oi
join orders_data o
	on oi.order_id = o.order_id
group by date_format(o.order_purchase_timestamp, '%Y-%m')
order by month desc;

#Revenue by Year
select 
	date_format(o.order_purchase_timestamp,'%Y-%m') as year,
    round(sum(oi.price),2) as revenue
from order_item oi
join orders_data o
	on oi.order_id = o.order_id
group by date_format(o.order_purchase_timestamp,'%Y-%m')
order by year;

#Orders and Revenue by Year
select 
	YEAR(o.order_purchase_timestamp) as year,
    count(distinct o.order_id) as total_orders,
    round(sum(oi.price)) as revenue
from orders_data o 
join order_item oi
	on o.order_id = oi.order_id
group by YEAR(o.order_purchase_timestamp) 
order by year;

#Average Order Value
select
	round(
		sum(oi.price)/count(distinct oi.order_id),
        2
		) as avg_order_value
	from order_item oi;
    
    #Top 10 Products by Revenue
  SELECT
    oi.product_id,
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS revenue
FROM order_item oi
JOIN product_data p
    ON oi.product_id = p.product_id
GROUP BY
    oi.product_id,
    p.product_category_name
ORDER BY revenue DESC
LIMIT 10;

#Top 10 Sellers by Revenue
select 
	oi.seller_id,
    s.seller_city,
    s.seller_state,
    round(sum(oi.price)) as revenue
from order_item oi
join seller_data s 
	on oi.seller_id = s.seller_id
group by 
	oi.seller_id,
    s.seller_city,
    s.seller_state
order by revenue desc
limit 10;

#Revenue by Customer State
select 
	c.customer_state,
    round(sum(oi.price)) as revenue
from order_item oi
join orders_data o
	on oi.order_id = o.order_id
join customer c
	on o.customer_id = c.customer_id
group by c.customer_state
order by revenue desc;

#Revenue by Payment Type
select 
	op.payment_type,
	round(sum(price),2) as revenue
from order_item oi
join order_payment op
	on oi.order_id = op.order_id
group by op.payment_type
order by revenue desc;

#Revenue Contribution by Category
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS revenue,
    ROUND(
        SUM(oi.price) * 100 /
        (SELECT SUM(price) FROM order_item),
        2
    ) AS revenue_percentage
FROM order_item oi
JOIN product_data p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC;

#Monthly Revenue + Order Count
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders_data o
JOIN order_item oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY month;