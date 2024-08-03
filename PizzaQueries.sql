select * from pizza_sales

-- Total Revenue
select SUM(total_price) as Total_Revenue from pizza_sales

-- Average Order Value
select SUM(total_price) / COUNT(DISTINCT order_id) as Avg_Order_Value from pizza_sales

-- Total Pizzas Sold
select SUM(quantity) as Total_Pizzas_Sold from pizza_sales

-- Total Orders Placed
select COUNT(DISTINCT order_id) as Total_Orders from pizza_sales

-- Average Pizzas Per Order
select CAST(CAST(SUM(quantity) as DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) as DECIMAL(10,2)) as Avg_Pizas_Per_Order from pizza_sales

-- Daily Trend for Total Orders
select DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) as Total_Orders from pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Monthly Trend for Total Orders
select DATENAME(MONTH, order_date) as Month_Name, COUNT(DISTINCT order_id) as Total_Orders from pizza_sales
GROUP BY DATENAME(MONTH, order_date)
-- Descending Order
ORDER BY Total_Orders DESC

-- Percentage of Sales by Pizza Category
select pizza_category, SUM(total_price) as Total_Sales, SUM(total_price) * 100 / (select sum(total_price) from pizza_sales) as Percent_of_Sales from pizza_sales
GROUP BY pizza_category

-- Percentage of Sales by Pizza Category For A Specific Month
select pizza_category, SUM(total_price) as Total_Sales, SUM(total_price) * 100 / (select sum(total_price) from pizza_sales WHERE MONTH(order_date) = 1) as Percent_of_Sales from pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

-- Percentage of Sales by Pizza Size
select pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_Sales, CAST(SUM(total_price) * 100 / (select sum(total_price) from pizza_sales) AS DECIMAL(10,2)) as Percent_of_Sales from pizza_sales
GROUP BY pizza_size
ORDER BY Percent_of_Sales DESC

-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold from pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

-- Top 5 Pizzas by Revenue
select TOP 5 pizza_name, SUM(total_price) as Total_Revenue from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- Bottom 5 Pizzas by Revenue
select TOP 5 pizza_name, SUM(total_price) as Total_Revenue from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

-- Top 5 Pizzas by Quantity
select TOP 5 pizza_name, SUM(quantity) as Total_Quantity from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

-- Bottom 5 Pizzas by Quantity
select TOP 5 pizza_name, SUM(quantity) as Total_Quantity from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

-- Top 5 Pizzas by Total Orders
select TOP 5 pizza_name, COUNT(DISTINCT order_id) as Total_Orders from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

-- Bottom 5 Pizzas by Total Orders
select TOP 5 pizza_name, COUNT(DISTINCT order_id) as Total_Orders from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC