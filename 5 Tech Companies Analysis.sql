

create table Apple_Stock
( 
		 Date date primary key,
		 Close_Price float,
	 	 Volume bigint,
		 Open_price float,
		 High_price float,
		 Low_price float				
);

create table Meta_Stock
( 
		 Date date primary key,
		 Close_Price float,
	 	 Volume bigint,
		 Open_price float,
		 High_price float,
		 Low_price float				
);

create table Microsoft_Stock
( 
		 Date date primary key,
		 Close_Price float,
	 	 Volume bigint,
		 Open_price float,
		 High_price float,
		 Low_price float				
);

create table Nvidia_Stock
( 
		 Date date primary key,
		 Close_Price float,
	 	 Volume bigint,
		 Open_price float,
		 High_price float,
		 Low_price float				
);

create table Tesla_Stock
( 
		 Date date primary key,
		 Close_Price float,
	 	 Volume bigint,
		 Open_price float,
		 High_price float,
		 Low_price float				
);


-- Data cleaning:
select * from Apple_Stock
select * from Meta_Stock
select * from Microsoft_Stock
select * from Nvidia_Stock
select * from Tesla_Stock


--1.  Highest price, lowest price and volume of each stock:

create table stocks(stock_name char(10),
					Highest_Price int,
					Lowest_Price int,
					Highest_volume  bigint
					);

insert into stocks(stock_name)
values ('apple'),
	   ('meta'),
	   ('microsoft'),
	   ('nvidia'),
	   ('tesla');
	   
select * from stocks

with Apple as(
select 'Apple' as apple_stock, max(high_price) as Highest_price, min(low_price) as Lowest_price, max(volume) as Highest_Volume
from apple_stock),
Meta as(select 'Meta' as meta_stock, max(high_price) as Highest_price, min(low_price) as Lowest_price, max(volume) as Highest_Volume
from meta_stock),
Microsoft as (select 'Microsoft' as microsoft_stock, max(high_price) as Highest_price, min(low_price) as Lowest_price, max(volume) as Highest_Volume
from microsoft_stock),
Nvidia as (select 'Nvidia' as nvidia_stock, max(high_price) as Highest_price, min(low_price) as Lowest_price, max(volume) as Highest_Volume
from nvidia_stock),
Tesla as (select 'Tesla' as tesla_stock, max(high_price) as Highest_price, min(low_price) as Lowest_price, max(volume) as Highest_Volume
from tesla_stock),
stocks as (select * from apple
		  union all
		  select * from meta
		  union all
		  select * from microsoft
		  union all
		  select * from nvidia
		  union all
		  select * from tesla
		  )
select * from stocks;
		  
--2.  Price volatility of stocks = Average(day high - day low)* over a period of time:	

create view list_of_stocks as
select  high_price, low_price, 'Apple' as stock_name
from apple_stock
union 
select  high_price, low_price, 'Meta' as stock_name
from meta_stock
union
select high_price, low_price, 'Microsoft' as stock_name
from microsoft_stock
union
select  high_price, low_price, 'Nvidia' as stock_name
from nvidia_stock
union
select  high_price, low_price, 'Tesla' as stock_name
from tesla_stock



select * from list_of_stocks;

create view volatility as
select stock_name, avg(high_price-low_price) as avg_volatility, dense_rank() over (order by avg(high_price-low_price) asc) as volatility
from list_of_stocks
group by stock_name;

select * from volatility;

--3. Year to year growth of each stock in 5 years:

--select * from list_of_stocks;

create view yearly_stock_price as
select 
extract (year from date) as year,
	'Apple' as stock,
	avg(close_price) as average_close_price
	from apple_stock
	group by extract (year from date)
	
union all
select 
extract (year from date) as year,
	'Meta' as stock,
	avg(close_price) as average_close_price
	from meta_stock
	group by extract (year from date)

union all
select 
extract (year from date) as year,
	'Microsoft' as stock,
	avg(close_price) as average_close_price
	from microsoft_stock
	group by extract (year from date)
	
union all
select 
extract (year from date) as year,
	'Nvidia' as stock,
	avg(close_price) as average_close_price
	from nvidia_stock
	group by extract (year from date)
	
union all
select 
extract (year from date) as year,
	'Tesla' as stock,
	avg(close_price) as average_close_price
	from tesla_stock
	group by stock,extract (year from date)
	
		
	WITH growth_calc AS (
    SELECT
        year,
        stock,
        average_close_price,
        LAG(average_close_price) OVER (
            PARTITION BY stock
            ORDER BY year
        ) AS prev_year_avg
    FROM yearly_stock_price
)
SELECT
    year,
    stock,
    average_close_price,
    prev_year_avg,
    (
        round(cast((100.0 * (average_close_price - prev_year_avg) / prev_year_avg) as numeric),2) --Note: data type is double percision so used cast to change to numeric
    ) AS year_to_year_growth_percent
FROM growth_calc
WHERE prev_year_avg IS NOT NULL
ORDER BY stock, year;








	
	
	


	



 

	
		 






