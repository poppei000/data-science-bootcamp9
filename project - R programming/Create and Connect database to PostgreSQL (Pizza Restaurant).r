## 1. load library
library(RPostgreSQL)
library(tidyverse)

## 2. create connection
con <- dbConnect(
  PostgreSQL(),
  host = "floppy.db.elephantsql.com",
  dbname = "gaqlvihu",
  user = "gaqlvihu",
  password = "kFLkHT8e_JdWVuFE-8m6jY6e_M_NjBay",
  port = 5432
)

## 3. create Table (customers, orders, menus. )
customers <- tribble(
  ~id, ~cus_name, ~cus_phone,
  1, 'David', 0614823615,
  2, 'Jane', 0891462315,
  3, 'Pete', 0823184167,
  4, 'Por', 0823871651,
  5, 'Cony', 0623481598,
)

view(customers)

orders <- tribble(
  ~id, ~food_name, ~count_orders,
  1,'BBQ Chicken',2,
  2,'Hawaiian',1,
  3,'Pepperoni',3,
  4,'Cheese Lover',4,
  5,'Chicken Supreme',2,
)

view(orders)

menus <- tribble(
  ~food_name, ~price,
  'BBQ Chicken',99,
  'Hawaiian',99,
  'Pepperoni',99,
  'Cheese Lover',129,
  'Chicken Supreme',129,
)

view(menus)

## 4. write table to database
dbWriteTable(con, "customers", customers, row.names = FALSE)
dbWriteTable(con, "orders", orders, row.names = FALSE)
dbWriteTable(con, "menus", menus, row.names = FALSE)

## 5. check tables
dbListTables(con)

# 5.1 check customers_table
dbGetQuery(con, "select * from customers")

# 5.2 check orders_table
dbGetQuery(con, "select * from orders")

# 5.3 check menus_table
dbGetQuery(con, "select * from menus")

## 6. Query database to answer need business
# Q1. Top spender today.
dbGetQuery(con,
            "select 
                customers.cus_name,
                sum(menus.price*orders.count_orders) AS top_spender
             from customers, menus, orders
             where customers.id = orders.id
             and orders.food_name = menus.food_name
             group by customers.cus_name
             order by top_spender desc
             limit 1;")

# Q2. the most order menu today.
dbGetQuery(con,
           "select 
               orders.food_name,
               sum(menus.price*orders.count_orders) AS total_revenue
            from customers, menus, orders
            where customers.id = orders.id
            and orders.food_name = menus.food_name
            group by orders.food_name
            order by total_revenue desc
            limit 1;")

# Q3. the top spender of each menus.
dbGetQuery(con,
           "select 
                customers.cus_name,
                orders.food_name,
                sum(menus.price*orders.count_orders) AS total_revenue
            from customers, menus, orders
            where customers.id = orders.id
            and orders.food_name = menus.food_name
            group by orders.food_name, customers.cus_name
            order by total_revenue;")

## 7. close connection
dbDisconnect(con)
