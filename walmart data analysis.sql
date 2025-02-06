create database walmart;
use walmart;

-- About
-- We are analysing Walmart's sales data to identify high-performing branches and products, 
-- analyze the sales patterns of various products, and understand customer behavior.
-- The primary objective is to enhance and optimize sales strategies.
-- The dataset utilized in this project is sourced from the Kaggle Walmart Sales Forecasting Competition.

-- Purposes of the Project
-- The main goal of this project is to gain understanding from Walmart's sales data, 
-- exploring the various factors that influence sales across different branches

CREATE TABLE Sales(
invoice_id VARCHAR(30) NOT NULL primary key,
branch VARCHAR(5) NOT NULL,
city VARCHAR(30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(10) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
quntity INT NOT NULL,
VAT FLOAT(6,4) NOT NULL,
total DECIMAL(12,4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment VARCHAR(20) NOT NULL,
cogs DECIMAL(10,2) NOT NULL,
gross_margin_pct DECIMAL(11,9),
gross_income DECIMAL(12,4),
rating DECIMAL(2,1)
);

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

select * from Sales;

-- 1. Time_of_day

SELECT time,
(CASE 
    WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
    WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
    ELSE "Evening"
END)AS time_of_day
FROM Sales;

ALTER TABLE Sales ADD COLUMN time_of_day VARCHAR(20);

select * from sales;

UPDATE Sales
SET time_of_day = (
     CASE
         WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
         WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
         ELSE "Evening"
	END
);         
    
-- Day Name

SELECT date,
DAYNAME(date) AS day_name
FROM Sales;

ALTER TABLE Sales ADD COLUMN day_name VARCHAR(10);

UPDATE Sales
SET day_name = DAYNAME(date);

select * FROM Sales;

-- month

SELECT date,
MONTHNAME(date) AS month_name
FROM Sales;

ALTER TABLE Sales ADD COLUMN month_name VARCHAR(10);

UPDATE Sales
SET month_name = MONTHNAME(date);

-- -------------- Exploratory Data Analysis (EDA)--------------------

-- Generic Questions

-- 1.How many distinct cities are present in the dataset?

SELECT DISTINCT city FROM Sales;

-- 2.In which city is each branch situated?
select * FROM Sales;
SELECT DISTINCT branch,city FROM Sales;

-- product analysis
-- 1.How many distinct product lines are there in the dataset?
SELECT  COUNT( DISTINCT product_line) FROM Sales;

-- 2.What is the most common payment method?

SELECT payment, COUNT(payment) AS common_payment_method 
FROM sales GROUP BY payment ORDER BY common_payment_method DESC LIMIT 1;

-- 3.What is the most selling product line?

SELECT product_line, COUNT(product_line) AS most_selling_product 
FROM sales GROUP BY product_line ORDER BY most_selling_product DESC LIMIT 1;

-- 4.What is the total revenue by month?


SELECT month_name, SUM(total) AS total_revenue
FROM SALES GROUP BY month_name ORDER BY total_revenue DESC;

-- 5.Which month recorded the highest Cost of Goods Sold (COGS)?
SELECT month_name, SUM(cogs) AS total_cogs
FROM sales GROUP BY month_name ORDER BY total_cogs DESC;

-- 6.Which product line generated the highest revenue?
SELECT product_line, SUM(total) AS total_revenue
FROM sales GROUP BY product_line ORDER BY total_revenue DESC LIMIT 1; 

-- 7.Which city has the highest revenue?
SELECT city, SUM(total) AS total_revenue
FROM sales GROUP BY city ORDER BY total_revenue DESC LIMIT 1;

-- 8.Which product line incurred the highest VAT?
SELECT product_line, SUM(vat) as VAT 
FROM sales GROUP BY product_line ORDER BY VAT DESC LIMIT 1;

-- 9 which product line has 9 plus rating
select Product_line, rating as nine_rating
from sales where rating > 9;

-- 10 in which quantity sports and travel product line sold
select sum(quntity) from sales where product_line = "Sports and Travel";

-- 11 which product sold out most
select product_line, sum(quntity) as max_qt_sold
from sales group by product_line order by max_qt_sold desc limit 1;

-- 12 which branch has highest revenue
select branch, sum(total) as highest_revenue_branch
from sales group by branch order by highest_revenue_branch desc limit 1;

-- 13 on which date highest value product line sold and by which branch
select branch, product_line, max(total) as highest_value_product
from sales group by branch,product_line order by highest_value_product desc limit 1;

-- sales Analysis
select* from sales;
 -- 1.Number of sales made in each time of the day per weekday
 select day_name ,time_of_day, count(invoice_id) as total_sales
 from sales group by day_name, time_of_day having day_name not in ("sunday","saturday");
 
 -- 2.Identify the customer type that generates the highest revenue.
 
 select customer_type, sum(total) as highest_revenue
 from sales group by customer_type order by highest_revenue desc limit 1;
 
 -- customer analysis
 -- 1.How many unique customer types does the data have?
 
 select count(distinct customer_type) as unique_customer from sales;
 
 -- 2.How many unique payment methods does the data have?
  select count(distinct payment) as unique_payment from sales;
  
  -- 3.Which is the most common customer type?
  select customer_type, count(customer_type) as common_customer
 from sales group by customer_type order by common_customer desc limit 1;
 
 -- 4.Which customer type buys the most?
  select customer_type, sum(total) as purchasing
 from sales group by customer_type order by purchasing desc limit 1;
 
 -- 5.What is the gender of most of the customers?
select gender, count(gender) as genders
from sales group by gender order by genders desc limit 1;

-- 6.What is the gender distribution per branch?
select branch, gender, Count(gender) as branch_gender
from sales group by branch,gender order by branch;

-- 7.Which time of the day do customers give most ratings?
select* from sales;

select time_of_day, avg(rating) as average
from sales group by time_of_day order by average desc limit 1;

-- 8. Which day of the week has the best avg ratings?

select day_name, avg(rating) as most_rating
from sales group by day_name order by most_rating desc limit 1;

