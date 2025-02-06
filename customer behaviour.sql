create database retail;
use retail;

create table sales(
invoiceno int,
stockcode varchar(50),
description varchar(200),
quantity int,
invoicedate datetime,
unitprice float(10,8),
customerid int,
country varchar(50)
);

select * from sales;
drop database retail;
select count(*) from sales;

select max(quantity) from sales;
select count(country) from sales where country = "United Kingdom";
select sum(quantity) from sales;

select sum(quantity*unitprice) from sales;
ALTER TABLE sales ADD COLUMN sales VARCHAR(50);

UPDATE Sales
SET sales = (
    SELECT SUM(quantity * unitprice)
    
);