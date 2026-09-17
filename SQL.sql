create database Bank_Customer_Churn;

use Bank_Customer_Churn;

select * from account_fact_f;

select * from customer_dim_f;


-- Quetions 

-- Q1. Show all customers with their country and balance.
SELECT c.customer_id, c.country, a.balance FROM customer_dim_f c
JOIN account_fact_f a ON c.customer_id = a.customer_id;

-- Q2. Display customers who have a credit card.
 SELECT * FROM account_fact_f WHERE credit_card = 1;

-- Q3. Count total number of customers.
SELECT COUNT(*) as Total_Customers FROM customer_dim_f;

-- Q4. Find the average balance by country, but only include countries having more than 50 customers. 
SELECT c.country, ROUND(AVG(a.balance)) as Avg_Balance, COUNT(*) as Total_Customers FROM customer_dim_f c
JOIN account_fact_f a ON c.customer_id = a.customer_id
GROUP BY c.country
HAVING COUNT(*) > 50;

-- Q5. Find gender-wise average credit score, but only for active members. 
SELECT c.gender, AVG(a.credit_score) as Avg_Credit_Score FROM customer_dim_f c
JOIN account_fact_f a ON c.customer_id = a.customer_id
WHERE a.active_member = 1
GROUP BY c.gender;

-- Q6. Find number of churned customers. 
SELECT COUNT(*) as Churned_Customers FROM account_fact_f WHERE churn = 1;

-- Q7. Find average credit score of active members. 
SELECT ROUND(AVG(credit_score)) as Avg_Credit_Score_Active FROM account_fact_f WHERE active_member = 1;

-- Q8. Find customers whose balance is higher than average balance. 
SELECT * FROM account_fact_f WHERE balance > (SELECT AVG(balance) FROM account_fact_f );

-- Q9. Find country-wise churn count and average balance, but show only those countries where churn count is greater than 10. 
SELECT c.country, COUNT(CASE WHEN a.churn = 1 THEN 1 END) as Churn_Count, ROUND(AVG(a.balance)) as Avg_Balance FROM customer_dim_f c
JOIN account_fact_f a ON c.customer_id = a.customer_id
GROUP BY c.country
HAVING COUNT(CASE WHEN a.churn = 1 THEN 1 END) > 10;

-- Q10. Find the country-wise average balance, but show only those 
-- countries whose average balance is greater than the overall average balance of all customers.
SELECT c.country, AVG(a.balance) as Avg_Balance FROM customer_dim_f c
JOIN account_fact_f a ON c.customer_id = a.customer_id
GROUP BY c.country
HAVING AVG(a.balance) > (SELECT AVG(balance) FROM account_fact_f);