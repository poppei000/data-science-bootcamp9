-- Table (1)
CREATE TABLE customers (
  id INT,
  name TEXT,
  phone INT
);

-- Table (2)
CREATE TABLE orders (
  id INT,
  food_name TEXT,
  count_order INT
);

-- Table (3)
CREATE TABLE menus (
  food_name TEXT,
  price REAL 
);

-- Insert Table (1)
INSERT INTO customers VALUES
  (1, 'David', 0614823615),
    (2, 'Jane', 0891462315),
    (3, 'Pete', 0823184167),
    (4, 'Por', 0823871651),
    (5, 'Cony', 0623481598);

-- Insert Table (2)
INSERT INTO orders VALUES
  (1, 'BBQ Chicken', 2),
    (2, 'Hawaiian', 1),
    (3, 'Pepperoni', 3),
    (4, 'Cheese Lover', 4),
    (5, 'Chicken Supreme', 2);

-- Insert Table (3)
INSERT INTO menus VALUES
  ('BBQ Chicken', 99),
    ('Hawaiian', 99),
    ('Pepperoni',99),
    ('Cheese Lover', 129),
    ('Chicken Supreme', 129);

.mode box

-- Select 3 Tables
SELECT * from customers;

SELECT * from orders;

SELECT * from menus;

-- Join Data with WHERE cause
SELECT
  customers.name 						AS cus_name,
    orders.food_name 					AS order_food,
    orders.count_order 					AS order_count,
    (menus.price*orders.count_order)	AS sales
From 	customers, menus, orders
WHERE 	customers.id = orders.id
  AND	orders.food_name = menus.food_name;

-- Subquqeries and Aggregate Function --
-- ลูกค้าที่ใช้จ่ายมากสุดในวันนี้ (หน่วยบาท)
SELECT
  cus_name,
    MAX(sales) AS top_spender
    from (SELECT
      customers.name 						AS cus_name,
        orders.food_name 					AS order_food,
            orders.count_order 					AS order_count,
        (menus.price*orders.count_order)	AS sales
      From 		customers, menus, orders
      WHERE 	customers.id = orders.id
        AND		orders.food_name = menus.food_name);

-- อาหารที่ขายได้ราคาน้อยสุดวันนี้ (หน่วยบาท)
SELECT
  order_food,
    Min(order_count) AS lowest_sell_food
    from (SELECT
      customers.name 						AS cus_name,
        orders.food_name 					AS order_food,
            orders.count_order 					AS order_count,
        (menus.price*orders.count_order)	AS sales
      From 		customers, menus, orders
      WHERE 	customers.id = orders.id
        AND		orders.food_name = menus.food_name);

-- ยอดขายทั้งหมดของวันนี้ (หน่วยบาท) : With Cause
with sub AS (
  SELECT
      customers.name 						AS cus_name,
        orders.food_name 					AS order_food,
            orders.count_order 					AS order_count,
        (menus.price*orders.count_order)	AS sales
      From 		customers, menus, orders
      WHERE 	customers.id = orders.id
        AND		orders.food_name = menus.food_name
)
SELECT sum(sales) AS total_sales
FROM sub;
