Project Title: Credit Card Transactions Analysis Using SQL
Overview:
This project focuses on exploring and analyzing a dataset of credit card transactions to uncover trends, behaviors, and anomalies in consumer spending across various cities and card types in India. The analysis leverages powerful SQL querying techniques to generate insights that could be useful for financial institutions, marketers, and fraud detection teams.

Dataset:
Source: Kaggle - Credit Card Transactions in India

Table Name: credittransactions

Preprocessing:

Column names converted to lowercase and spaces replaced with underscores.

Appropriate data types assigned to columns (e.g., DATE, FLOAT, VARCHAR).

Objectives:
Analyze spending patterns across cities, card types, and expense categories.

Identify top-performing and underperforming regions.

Uncover hidden insights into gender-based spending and behavioral trends.

Evaluate customer engagement by card type and expense type.

Detect early indicators for fraud or anomalies in transaction trends.

Key Analytical Tasks & SQL Techniques Used:
1. Top Spending Cities:
Identified the top 5 cities with the highest total credit card spend.

Calculated each city's percentage contribution to the total national spend.

SQL Concepts: GROUP BY, SUM(), subqueries, ORDER BY, LIMIT.

2. Peak Monthly Spending by Card Type:
Found the month with the highest spending for each card type per year.

Useful for understanding seasonal trends and customer engagement.

SQL Concepts: CTEs, MONTH(), YEAR(), aggregation.

3. First Million-Spend Milestone per Card Type:
Tracked when each card type reached ₹1,000,000 in cumulative spending.

Returned full transaction details where the milestone was hit.

SQL Concepts: WINDOW FUNCTIONS (SUM() OVER, ROW_NUMBER()).

4. Lowest Gold Card Spend by City:
Computed the percentage of spending on Gold cards in each city.

Identified the city with least engagement for Gold card users.

SQL Concepts: CASE, CTEs, GROUP BY, ORDER BY.

5. Highest & Lowest Expense Types by City:
Aimed to identify which expense types dominated and were least used in cities.

While partially implemented, this forms the basis for deeper city-wise preference analysis.

6. Female Spending Contribution per Expense Type:
Measured how much females contribute to total spending for each expense category.

Insightful for gender-based marketing and customer targeting.

SQL Concepts: filtering using WHERE, subqueries, aggregation.

7. Highest Month-over-Month Growth (Jan 2014):
Intended to detect which card-expense combination showed the highest MoM growth.

Used nested CTEs, joins, and row tracking — although logic may require refinement for actual growth comparison.

8. Weekend Spend Efficiency by City:
Calculated the ratio of total weekend spend to number of weekend transactions.

Identified the city with the highest transaction value efficiency on weekends.

SQL Concepts: DATE PARSING, DAYOFWEEK(), CTEs, aggregation.

9. Fastest City to Reach 500 Transactions:
Determined which city reached its first 500 transactions the fastest after its first transaction.

Highlights rapid adoption or high activity zones.

SQL Concepts: ROW_NUMBER(), FIRST_VALUE(), DATEDIFF(), filtering on row ranks.
