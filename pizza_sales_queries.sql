                         PIZZA SALES SQL QUERIES

A.	KPI’s
1.	Total Revenue:
SELECT SUM(total_price) AS Total_Revenue from pizza_sales
 

2.	Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) as Avg_Order_Val from pizza_sales
 

3.	Total Pizza Sold
  SELECT SUM(quantity) As Total_Pizza_Sold from pizza_sales
 

4.	Total_order
     SELECT COUNT(DISTINCT order_id) As Total_Orders from pizza_sales
 
5.	Average Pizza Per Order
SELECT CAST(CAST(SUM(quantity)AS DECIMAL (10,2))/ 
 CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))AS decimal(10,2))As Avg_pizza_per_order from pizza_sales
 

6.	Daily and Hourly Trend for Total Orders

--DAILY TREND
 SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) as total_orders
 from pizza_sales
 GROUP BY DATENAME(DW, order_date)

 --HOURLY TREND
 SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
 from pizza_sales
 GROUP BY DATEPART(HOUR, order_time)
 ORDER BY DATEPART(HOUR, order_time)

    

7.	Percentage of sales by pizza category
SELECT 
    pizza_category, 
    SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date)=1) AS PCT
FROM pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_category;
 

8.	Percentage of Pizza Sales by Pizza Size
SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales,
    CAST(SUM(total_price) * 100 / 
        (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 1) 
    AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC
 

9.	Total Pizza sold by pizza Catergory
SELECT 
   pizza_category, sum(quantity) as Total_pizza_sold
   from pizza_sales
   group by pizza_category
 

10.	Top 5 best Sellers by Total Pizza Sold
SELECT top 5
   pizza_name, sum(quantity) as Total_Pizza_Sold
   from pizza_sales
   group by pizza_name
   order by sum(quantity) desc
 

11.	Bottom 5 worst seller by total pizza sold
SELECT top 5
   pizza_name, sum(quantity) as Total_Pizza_Sold
   from pizza_sales
   group by pizza_name
   order by sum(quantity)
 
