use credit;

-- SQL porfolio project.
-- download credit card transactions dataset from below link :
-- https://www.kaggle.com/datasets/thedevastator/analyzing-credit-card-spending-habits-in-india
-- import the dataset in sql server with table name : credit_card_transcations
-- change the column names to lower case before importing data to sql server.Also replace space within column names with underscore.
-- (alternatively you can use the dataset present in zip file)
-- while importing make sure to change the data types of columns. by defualt it shows everything as varchar.

-- write 4-6 queries to explore the dataset and put your findings 
select * 
from credittransactions;
-- solve below questions
-- 1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 
	
     
    select sum(amount) as cityspend,sum(amount) /(select sum(amount)
    from credittransactions) as percentofamountspend,city
    from credittransactions
    group by city
    order by cityspend desc
    limit 5;
    
    
    

-- 2- write a query to print highest spend month for each year and amount spent in that month for each card type
with cte as (
select
sum(amount) as total,
card_type,
month(transaction_date) as mn,
year(transaction_date) as yr
from credittransactions
group by month(transaction_date),
year(transaction_date),card_type)
select card_type,mn,yr,total
from cte
where total in (select max(total) from cte group by card_type);
    
select 
* from credittransactions;

-- 3- write a query to print the transaction details(all columns from the table) for each card type when
	-- it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)
    with cityspend as(
    select *,
    SUM(amount) OVER ( partition by card_type order by transaction_date,transaction_id) AS cumulative_amount,
    ROW_NUMBER() OVER ( partition by card_type order by transaction_date,transaction_id) as rn
    from credittransactions
    )
    ,transactiontable as (
    select *
    from cityspend
    where cumulative_amount >= 1000000)
    select card_type,
    max(cumulative_amount)
    from transactiontable
    group by card_type;
    
    

-- 4- write a query to find city which had lowest percentage spend for gold card type

		with cte1 as 
        (select city, sum(case when card_type="Gold" then amount else 0 end) as goldspentincity,sum(amount) as total_amount
        from credittransactions
        group by city),
        cte2 as(
        select ( goldspentincity/total_amount*100) as goldpercentage,city
        from cte1
        group by city
        )
        select goldpercentage,city
        from cte2
        order by goldpercentage
        limit 1;


-- 5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
with ct1 as(
	select *,
    row_number() over (partition by exp_type)
    from credittransactions
    ),
    ct2 as(
    select sum(amount) as amount ,exp_type
    from ct1
    group by exp_type)
    select min(amount) as min,max(amount) as max
    from ct2;
    
    
-- 6- write a query to find percentage contribution of spends by females for each expense type

    select exp_type,sum(amount)*100/(select sum(amount) as totalamount from credittransactions) as percentage_contribution
    from credittransactions
    where gender='F'
    group by exp_type;
    


-- 7- which card and expense type combination saw highest month over month growth in Jan-2014
		with cte1 as 
        (select card_type,exp_type,sum(amount) as amt
        from credittransactions
        group by card_type,exp_type
        ),cte2 as(
        select max(amount),transaction_date
        from cte1
        join credittransactions
        group by transaction_date),
        cte3 as(
        select *
        from cte2 
        order by transaction_date
        )
        select *,row_number() over(partition by month(transaction_date) )
        from cte3;
        
        select * from credittransactions;
        
        select card_type,exp_type,amount
        from credittransactions;
        
        
        
        
-- 8- during weekends which city has highest total spend to total no of transcations ratio 

WITH weekend_transactions AS (
    SELECT 
        city,
        amount,
        STR_TO_DATE(transaction_date, '%d-%b-%y') AS parsed_date
    FROM credittransactions
),
filtered_weekends AS (
    SELECT 
        city,
        amount
    FROM weekend_transactions
    WHERE DAYOFWEEK(parsed_date) IN (1, 7) -- Sunday=1, Saturday=7 in MySQL
),
city_stats AS (
    SELECT 
        city,
        SUM(amount) AS total_spend,
        COUNT(*) AS total_transactions,
        SUM(amount) * 1.0 / COUNT(*) AS spend_to_transaction_ratio
    FROM filtered_weekends
    GROUP BY city
)
SELECT 
    city,
    spend_to_transaction_ratio
FROM city_stats
ORDER BY spend_to_transaction_ratio DESC
LIMIT 1;



-- 9- which city took least number of days to reach its 500th transaction after the first transaction in that city

		SELECT city, MIN(days_to_500th_transaction) AS least_days
		FROM (
		SELECT 
			city,
			MAX(DATEDIFF(transaction_date, first_transaction_date)) AS days_to_500th_transaction
		FROM (
			SELECT 
				city,
				transaction_date,
				FIRST_VALUE(transaction_date) OVER (PARTITION BY city ORDER BY transaction_date) AS first_transaction_date,
				ROW_NUMBER() OVER (PARTITION BY city ORDER BY transaction_date) AS txn_rank
			FROM credittransactions
		) ranked_txns
		WHERE txn_rank <= 500
		GROUP BY city
		HAVING COUNT(*) = 500
	) city_500_txns
	GROUP BY city
	ORDER BY least_days
	LIMIT 1;
