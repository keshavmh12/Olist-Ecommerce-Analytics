
USE olist;
SHOW DATABASES;
CREATE TABLE customer(
	customer_id VARCHAR(1000),
	customer_unique_id VARCHAR(1000),
	customer_zip_code_prefix int,
	customer_city VARCHAR(1000),
	customer_state varchar(50)
);

CREATE TABLE geolocation(
	geolocation_zip_code_prefix decimal,
	geolocation_lat decimal,
	geolocation_lng decimal,
	geolocation_city VARCHAR(100),
	geolocation_state VARCHAR(100)
);

CREATE TABLE order_item(
	order_id VARCHAR(1000),
	order_item_id int,
	product_id	VARCHAR(1000),
    seller_id VARCHAR(1000),
	shipping_limit_date	DATETIME,
    price int ,
	freight_value int
);

CREATE TABLE order_payment(
	order_id VARCHAR(1000),
	payment_sequential decimal,
	payment_type VARCHAR(50),
	payment_installments decimal,
	payment_value decimal
);

CREATE TABLE order_review(
	review_id VARCHAR(1000),
	order_id VARCHAR(1000),
	review_score int,
	review_comment_title VARCHAR(1000),
	review_comment_message VARCHAR(10000),
	review_creation_date DATETIME,
	review_answer_timestamp DATETIME
);



CREATE TABLE orders_data(
	order_id VARCHAR(1000),
	customer_id VARCHAR(1000),
	order_status VARCHAR(1000),
	order_purchase_timestamp DATETIME,
	order_approved_at  DATETIME,
	order_delivered_carrier_date DATETIME,
	order_delivered_customer_date DATETIME,
	order_estimated_delivery_date DATETIME
);

CREATE TABLE product_data(
	product_id VARCHAR(1000),
	product_category_name VARCHAR(10000),
	product_name_lenght int,
	product_description_lenght int,
	product_photos_qty int,
	product_weight_g int,
	product_length_cm int,
	product_height_cm int,
	product_width_cm int
);

CREATE TABLE seller_data(
	seller_id VARCHAR(1000),
	seller_zip_code_prefix int,
	seller_city varchar(100),
	seller_state varchar(10)
);

CREATE TABLE category_name(
	product_category_name varchar(1000),
	product_category_name_english VARCHAR(1000)
);

SHOW tables;

describe customer;
select * from seller_data;
select * from product_data;
select * from orders_data;
select * from order_review;
select * from order_payment;
select  *  from order_item;
select * from geolocation;
select * from customer;


describe seller_data;
describe product_data;
describe orders_data;
describe order_review;
describe order_payment;
describe order_item;
describe geolocation;
describe customer;
describe category_name;

select count(*) from order_item;
select count(*) from customer;
select count(*) from orders_data;

select * from order_item limit 5;
select * from customer limit 5;
select * from orders_data limit 5;
select * from product_data limit 5;
select * from order_payment limit 5;


select sum(order_purchase_timestamp is null) as missing_purchase_date,
	   sum(order_delivered_customer_date is null) as missing_delivery_date,
       sum(order_estimated_delivery_date is null) as missing_estimated_date
from orders_data;

select order_status , count(*) as orders from orders_data 
where order_delivered_customer_date is null group by  order_status;

select order_id , count(*) as occurences from orders_data 
group by order_id having count(*)>1;

select 
count(*) as total_rows,
sum(order_id is null) as null_order_id,
sum(customer_id is null) as null_customer_id,
sum(order_status is null) as null_order_status
from orders_data;


SELECT
    SUM(order_purchase_timestamp IS NULL) AS null_purchase_date,
    SUM(order_approved_at IS NULL) AS null_approved_date,
    SUM(order_delivered_carrier_date IS NULL) AS null_carrier_date,
    SUM(order_delivered_customer_date IS NULL) AS null_delivery_date,
    SUM(order_estimated_delivery_date IS NULL) AS null_estimated_date
FROM orders_data;


select order_status, count(*) as total_orders
from orders_data
group by order_status
order by total_orders DESC;

select count(*) as unmatched_customer
from orders_data o
left join customer c
	on o.customer_id=c.customer_id
where c.customer_id is null;

select count(*) as unmatched_orders
from order_item oi
left join orders_data o
	on oi.order_id=o.order_id
where o.order_id is null;
	
select count(*) as unmatched_products
from order_item oi
left join product_data pd
	on oi.product_id = pd.product_id
where pd.product_id is null;


select 
	min(price) as min_price,
    max(price) as max_price,
    avg(price) as avg_price
from order_item;

SELECT
    MIN(freight_value) AS min_freight,
    MAX(freight_value) AS max_freight,
    AVG(freight_value) AS avg_freight
FROM order_item;

