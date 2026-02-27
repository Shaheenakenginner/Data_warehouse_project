SELECT DISTINCT gender FROM gold.dim_customers
SELECT * FROM gold.dim_products
SELECT * FROM gold.fact_sales
-- foreign key integrity 
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL
