SELECT * 
FROM pizza_sales

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales

-- Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value 
FROM pizza_sales

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold 
FROM pizza_sales

-- Total Orders Placed
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales

-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) as DECIMAL(10,2)) AS Avg_Pizas_Per_Order 
FROM pizza_sales

-- Daily Trend for Total Orders
SELECT DATENAME(DW, order_date) AS order_day,
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Monthly Trend for Total Orders
SELECT DATENAME(MONTH, order_date) AS Month_Name,
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC

-- Percentage of Sales by Pizza Category
SELECT pizza_category, SUM(total_price) AS Total_Sales, 
	SUM(total_price) * 100 / (select sum(total_price) FROM pizza_sales) AS Percent_of_Sales 
FROM pizza_sales
GROUP BY pizza_category

-- Percentage of Sales by Pizza Category For A Specific Month
SELECT pizza_category, 
	SUM(total_price) AS Total_Sales, 
	SUM(total_price) * 100 / (select sum(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS Percent_of_Sales 
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

-- Percentage of Sales by Pizza Size
SELECT pizza_size, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 / (select sum(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percent_of_Sales 
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percent_of_Sales DESC

-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, 
	SUM(quantity) AS Total_Quantity_Sold 
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

-- Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, 
	SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- Bottom 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, 
	SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

-- Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, 
	SUM(quantity) AS Total_Quantity 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

-- Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, 
	SUM(quantity) AS Total_Quantity 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

-- Top 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

-- Bottom 5 Pizzas by Total Orders
select TOP 5 pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC