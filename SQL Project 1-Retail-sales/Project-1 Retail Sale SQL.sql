--Creating the Table
create table sale(
transactions_id int primary key,	
sale_date date,
sale_time time,
customer_id int,
gender varchar,
age int,
category varchar,
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

--Importing the Data
select * from sale limit 10

--Data Cleaning and checking Null Values
select * from sale where transactions_id isnull or
sale_date isnull or
sale_time isnull or
customer_id isnull or
gender isnull or
category isnull or
quantiy	isnull or
price_per_unit isnull or
cogs isnull or
total_sale isnull

--Deleting the null values
delete from sale where
sale_date isnull or
sale_time isnull or
customer_id isnull or
gender isnull or
category isnull or
quantiy	isnull or
price_per_unit isnull or
cogs isnull or
total_sale isnull

---Data Explorations
select * from sale
--Total sales
select count(*) as Total_Sales from sale

--Total Unique Coustomer
select count(distinct customer_id) as Total_Customers from sale

--Total Distinct Category
select  distinct category as Category from sale

--1.Retrive all columns for sales made on 2022-11-15
select * from sale where sale_date='2022-11-15'

--2.Retrive All transaction where the category is clothing and quatity sold is more than 10 in month of nov-2022
select * from sale where category='Clothing'
and to_char(sale_date,'yyyy-mm')='2022-11'
and quantiy>=4

--3.Calculate the Total Sales for each category
select category,sum(total_sale) as net_sale,
count(*) as Total_Orders
from sale group by 1

--4.Find the Avg age of customers who purchased items from the Beauty Category
select round((avg(age)),2) as avg_age from sale where category='Beauty'

--5.Find the all Transaction where the total sale is greater then 1000
select * from sale where total_sale >1000

--6.Find the no of transaction made by each gender in each category
select category,gender,count(*) as Total_Transaction from sale group by category,gender order by 1

--7.calculate the avg sale for each month find out the best selling month in each year
select year,month,avg_sale from(
select extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale,
rank() over (partition by extract(year from sale_date) order by avg(total_sale) desc) as rank from sale group by 1,2
) as t1 where rank=1

--8.Find the Top 5 customer based on the highest total sale
select customer_id,sum(total_sale) as total_sale from sale group by 1 order by 2 desc limit 5

--9Find the no of unquie customer who purchased item from each category
select category,count(distinct customer_id) as unique_customer from sale group by 1

--10.Create Each shift and no of order example moring<=12, Afternoon 12 & 17 evening>17
with hourly_sale as(
select *,
case when extract(hour from sale_time)<12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening' end as shift from sale
) select shift,count(*) as Total_order from hourly_sale group by shift


               ----END OF PROJECT----