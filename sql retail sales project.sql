-- Retail sales project1 --
CREATE DATABASE  RETAIL_SALES_P1;
USE RETAIL_SALES_P1;
CREATE TABLE RETAIL_SALES(
 transation_id int PRIMARY KEY,
 sale_date date,
 sale_time time,
 customer_id int,
 gender varchar(15),
 age int,
 category varchar(15),
 quantity int,
 price_per_unit float,
 cogs float,
 total_sales float
 );
 select *from RETAIL_SALES
 LIMIT 10;
 SELECT COUNT(*) FROM RETAIL_SALES;
 -- DATA CLEANING --
 SELECT * FROM RETAIL_SALES 
 WHERE  transation_id is NULL
 or
 sale_date is Null
 or
 sale_time is null
 or
 customer_id is null
 or
 gender is null
 or
 category is null
 or
 quantity is null
 or
 cogs is null
 or
 total_sales is null
 or
 price_per_unit is null;
-- data exploration --
-- HOW MANY SALES WE HAVE?--
select count(*)as total_sales from retail_sales;
-- HOW MANY UNIQUE CUSTOMERS WE HAVE?--
SELECT COUNT(DISTINCT customer_id) as total_sales from retail_sales;
-- DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWERS--
-- Q1 WRITE A SQL QUERY TO RETRIEVE ALL COLUMN FOR SALES MADE ON'2022-11-05--
SELECT * FROM RETAIL_SALES	WHERE sale_date='2022-11-05';
-- Q2 WRITE SQL QUERY TO RETRIEVE ALL TRANSACTION WHERE THE CATEGORY IS CLOTHING AND THE QUANTITY SOLD IS MORE THAN 4 IN THE MONTH OF NOV 2022
SELECT *FROM RETAIL_SALES
WHERE CATEGORY = 'Clothing'
AND sale_date between '2022-11-01' and '2022-11-30'
AND quantity>=4;
-- Q3 WRITE SQL QUERY TO CALCULATE TOTAL SALES OF TOTAL SALES FOR EACH CATEGORY?--
SELECT category, sum(total_sales) as net_sales,
count(*)as total_orders
from retail_sales 
group by 1;
-- Q4 WRITE SQL QUERY  TO  FIND AVG AGE OF CUSTOMER  WHO PURCHASED ITEM FROM THE BEAUTY CATEGORY?--
 SELECT  round(Avg(age),2) as avg_age
 from retail_sales 
 where category='beauty';
 -- Q5  WRITE A SQL QUERY TO FIND ALL TRANSACTION  WHERE THE TOTAL_SALE  IS GREATER THAN 1000?--
 SELECT * FROM retail_sales
 WHERE TOTAL_SALES >=1000;
 -- Q6  WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTION (TRANSACTION _ID) MADE BY EACH GENDERIN EACH CATEGORY?--
 SELECT  CATEGORY,GENDER, COUNT(*)AS TOTAL_TRANS
 FROM RETAIL_SALES 
 GROUP BY CATEGORY, GENDER
 ORDER BY 1;
 -- Q7 WRITE A SQL QUERY TO  CALCULATE THE AVG SALE FOR EACH MONTH. FIND THE BEST SELLING MONTH IN EACH YEAR?--
 select
 year,
 month,
 avg_sale
 from(
select
year(sale_date)as year,
month(sale_date) as month,
avg(total_sales) as avg_sale,
rank() over (partition by year(sale_date) order by avg(total_sales)desc) as top_rank
from retail_sales 
group by 1,2
)as t1
where top_rank=1;
 
 
 select category, count(distinct customer_id) as unique_customer
 from  retail_sales
 group by category;
 
 
 select  customer_id,sum(total_sales)as total_sales
 from retail_sales
 group by 1
 order by 2 desc
 limit 5;
 
 
 with hourly_sales
 as
 (
 select*,
 case
 when  hour(sale_time) <12 then 'morning'
 when hour(sale_time) between 12 and 17 then'afternoon'
 else 'evening'
 end as shift 
 from retail_sales
 )
 select
 shift,
 count(*) as total_orders
 from hourly_sales
 group by shift

 







