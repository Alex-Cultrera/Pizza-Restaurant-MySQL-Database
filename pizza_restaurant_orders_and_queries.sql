------------
-- enter menu item options into `items` table

insert into `items` (pizza_type)
VALUES ('Pepperoni & Cheese');

insert into `items` (pizza_type)
VALUES ('Meat Lovers');

insert into `items` (pizza_type)
VALUES ('Hawaiian');

insert into `items` (pizza_type)
VALUES ('Vegetarian');

------------
-- enter first time customer data into `customers` table

insert into `customers` (customer_name, phone_number)
values ('Trevor Page', '226-555-4982');

SET @customer_id = LAST_INSERT_ID();
 
-- create order #1
 
insert into `orders` (date_time)
values ('2023-09-10 09:47:00');

SET @order_number = LAST_INSERT_ID();

-- link customer to order

insert into `customer_orders` (customer_id, order_number)
values (@customer_id, @order_number);

-- enter order details

insert into `order_items` (order_number, pizza_type, quantity)
values (@order_number, 'Pepperoni & Cheese', 1);
  
insert into `order_items` (order_number, pizza_type, quantity)
values (@order_number, 'Meat Lovers', 1);
  
  
------------
-- enter first time customer data into `customers` table

insert into `customers` (customer_name, phone_number)
values ('John Doe', '555-555-9498');

SET @customer_id = LAST_INSERT_ID();

-- create order #2

insert into `orders` (date_time)
values ('2023-09-10 13:20:00');

SET @order_number = LAST_INSERT_ID();

-- link customer to order

insert into `customer_orders` (customer_id, order_number)
values (@customer_id, @order_number);

-- enter order details

insert into `order_items` (order_number, pizza_type, quantity)
values (@order_number, 'Vegetarian', 1);
  
insert into `order_items` (order_number, pizza_type, quantity)
values (@order_number, 'Meat Lovers', 2);
  

------------
 
 
-- create order #3
SET @customer_id = 1;
insert into `orders` (date_time)
values ('2023-09-10 09:47:00');

SET @order_number = LAST_INSERT_ID();

-- link customer to order

insert into `customer_orders` (customer_id, order_number)
values (@customer_id, @order_number);

-- enter order details

insert into `order_items` (order_number, pizza_type, quantity)
values (@order_number, 'Hawaiian', 1);
  
insert into `order_items` (order_number, pizza_type, quantity)
values (@order_number, 'Meat Lovers', 1);
  
------------

-- create order #4
SET @customer_id = 2;
insert into `orders` (date_time)
values ('2023-10-10 10:37:00');

SET @order_number = LAST_INSERT_ID();

-- link customer to order

insert into `customer_orders` (customer_id, order_number)
values (@customer_id, @order_number);

-- enter order details

insert into `order_items` (order_number, pizza_type, quantity)
values (@order_number, 'Vegetarian', 3);
  
insert into `order_items` (order_number, pizza_type, quantity)
values (@order_number, 'Hawaiian', 1);
    

------------

CALL UpdateUnitPrice();  
CALL UpdateDayOfWeek();
CALL UpdateOrderTotalPrice();

-- view table data

select * from `customers`;
select * from `orders`;
select * from `customer_orders`;
select * from `items`;
select * from `order_items`;

------------

-- Query: total spend per individual customer (in descending order of spend)

SELECT c.customer_name, sum(order_total_price) AS total_spend 
FROM `customers` c
JOIN `customer_orders` co ON co.customer_id = c.customer_id
JOIN `orders` o ON o.order_number = co.order_number
GROUP BY c.customer_name
ORDER BY total_spend DESC;

------------

-- Query: total spend per individual customer per date (in descending order of spend)
SELECT c.customer_name, o.date_time, sum(order_total_price) AS total_spend 
FROM `customers` c
JOIN `customer_orders` co ON co.customer_id = c.customer_id
JOIN `orders` o ON o.order_number = co.order_number
GROUP BY c.customer_name, o.date_time
ORDER BY total_spend DESC;

------------

-- Query: total spend per individual customer per day of week (in descending order of spend)

SELECT c.customer_name, o.day_of_week, sum(order_total_price) AS total_spend 
FROM `customers` c
JOIN `customer_orders` co ON co.customer_id = c.customer_id
JOIN `orders` o ON o.order_number = co.order_number
GROUP BY c.customer_name, o.day_of_week
ORDER BY total_spend DESC;

