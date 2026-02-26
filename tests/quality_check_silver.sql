--check for null of duplicates in primary key
SELECT 
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) >1 OR cst_id IS NULL 

--CHECHKS FOR UNWANTED SPACES
--FOR FIRSTNAME
SELECT cst_firstname
From bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
--FOR LASTNAME
SELECT cst_lastname
From bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)
--FOR GENDER
SELECT cst_gndr
From bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)

--CHECKS CONSISTENCY OF VALUES (LOW CARDINALITY) OR DATA STANDARDDIZATION AND CONSISTENCY
--for gender
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info
--for marital status
SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info

--for crm_prd_info
SELECT 
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) >1 OR prd_id IS NULL
--for unwanted spaces 
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)
--checks for negative numbers or nulls
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost <0 OR prd_cost IS NULL
--checks for cardinality 
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

--checks for invalid date
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt< prd_start_dt

--check for date order 
SELECT 
*
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt
-- data is consistent or not in sales column
SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
THEN sls_quantity *ABS(sls_price)
ELSE sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price<=0
THEN sls_sales/NULLIF(sls_quantity, 0)
ELSE sls_price

FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL

SELECT* FROM bronze.crm_prd_info
