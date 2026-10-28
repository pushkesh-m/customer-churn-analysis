USE churn_analysis;
SELECT * FROM customers ;
-- SECTION 1: OVERVIEW
-- 1. Total customers and overall churn rate

SELECT 
COUNT(*) AS Total_Customers ,
SUM(CASE WHEN churn_label = 'Yes' THEN 1 ELSE 0 END ) AS Churned ,
ROUND(100.0 * SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END ) / COUNT(*) , 2) AS Churn_Rate_Pct 
FROM customers;

-- 2. Churn by gender
SELECT gender , COUNT(*) AS Total ,
SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END) AS Churned , 
ROUND(100.0 * SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END ) / COUNT(*) , 2) AS Churn_Rate_Pct 
FROM customers
GROUP BY gender ; 

-- SECTION 2: CONTRACT AND SERVICE ANALYSIS
-- 3. Churn rate by contract type
SELECT contract,
COUNT(*) AS Total,
SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END) AS Churned,
ROUND(100.0 * SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END) / COUNT(*) , 2) AS Churn_Rate_Pct
FROM customers 
GROUP BY contract 
ORDER BY Churn_Rate_Pct DESC;

-- 4. Churn rate by internet type
SELECT internet_type, 
COUNT(*) AS Total, 
SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END) AS Churned,
ROUND(100.0 * SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END) / COUNT(*) , 2) AS Churn_Rate_Pct
FROM customers 
GROUP BY internet_type 
ORDER BY Churn_Rate_Pct DESC;

-- 5. Churn rate by payment method
SELECT payment_method, 
COUNT(*) AS Total, 
SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END) AS Churned,
ROUND(100.0 * SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END) / COUNT(*) , 2) AS Churn_Rate_Pct
FROM customers 
GROUP BY payment_method 
ORDER BY Churn_Rate_Pct DESC;

-- SECTION 3: FINANCIAL ANALYSIS
-- 6. Avg monthly charge, total charges, and CLTV - churned vs retained
SELECT 
ROUND(AVG(monthly_charge)) AS Average_Monthly_Charge,
ROUND(AVG(total_charges)) AS Average_Total_Charge,
ROUND(AVG(cltv)) AS Average_CLTV
FROM customers
GROUP BY churn_label;

-- 7. Monthly revenue at risk from high-value churned customers
SELECT COUNT(*) AS high_valued_churners,
ROUND(SUM(monthly_charge),2) AS Monthly_Revenue_At_Risk
FROM customers
WHERE churn_label = 'Yes' AND monthly_charge > 70 ;

-- SECTION 4: CHURN REASONS
-- 8. Top 10 churn reasons
SELECT churn_reason,
COUNT(*) AS customers_lost
FROM customers
WHERE churn_label ='Yes'
GROUP BY churn_reason
ORDER BY customers_lost DESC 
LIMIT 10;

-- 9. Churn category breakdown
SELECT churn_category,
COUNT(*) AS customers_lost,
ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM customers WHERE churn_label ="Yes") , 2) AS Pct_Of_Churners 
FROM customers 
WHERE churn_label="Yes"
GROUP BY churn_category
ORDER BY customers_lost DESC;

-- 10. CTE - Tenure buckets with churn rate and avg CLTV
WITH tenure_groups AS (
	SELECT 
		CASE 
			WHEN tenure_months <= 12 THEN '0-12 Months'
            WHEN tenure_months <= 24 THEN '13-24 Months'
            WHEN tenure_months <= 48 THEN '25-48 Months'
            ELSE '49 + Months'
		END AS tenure_bucket , 
        churn_label,
        cltv 
	FROM customers
)

SELECT tenure_bucket , 
COUNT(*) AS Total,
SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END) AS Churned,
ROUND(100.0 * SUM(CASE WHEN churn_label ='Yes' THEN 1 ELSE 0 END) / COUNT(*) , 2) AS Churn_Rate_Pct,
ROUND(AVG(cltv), 0 ) AS Average_CLTV
FROM tenure_groups
GROUP BY tenure_bucket
ORDER BY churn_rate_pct DESC;
