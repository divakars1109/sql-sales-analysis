WITH customer_last_purchase AS (
 SELECT 
	customerkey , orderdate,
	cleaned_name,
	ca.first_purchase_date ,
	cohort_year, 
	row_number() over(PARTITION BY customerkey ORDER BY orderdate desc) AS rn
FROM 	
		cohort_analysis ca 
GROUP BY ca.customerkey , ca.cleaned_name , ca.first_purchase_date , ca.orderdate , cohort_year 
), churned_customer AS 
(SELECT 
	customerkey  , 
	cleaned_name , 
	first_purchase_date,
	orderdate AS last_purchase_date,
	cohort_year,
	CASE 
		WHEN orderdate < '2024-04-20'::date - INTERVAL '6 months' THEN 'Churned'
		ELSE 'Active'
	END AS customer_status
FROM customer_last_purchase 
WHERE rn = 1 AND
		first_purchase_date < '2024-04-20'::date- INTERVAL '6 months'
) 
SELECT 
	cohort_year, 
	customer_status ,
	count(customerkey) AS num_customers,
	sum(count(customerkey)) OVER (PARTITION BY cohort_year) AS total_customers,
	round( count(customerkey) / sum(count(customerkey)) OVER(PARTITION BY cohort_year) ,2 )AS status_percentage
FROM 
	churned_customer
GROUP BY 
	cohort_year,
	customer_status 