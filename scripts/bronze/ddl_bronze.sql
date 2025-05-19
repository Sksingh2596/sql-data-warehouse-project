/*
============================================================================
DDL Script: Create Bronze Tables
============================================================================
Script Purpose: 
 This script creates tables in the 'bronze' schema, dropping existing tables
 if they alreay exist. 
 Run this script to re-define the DDL structure of 'bronze' Tables
============================================================================ 
*/
If Object_id ('bronze.crm_cust_info', 'U') is not null
	Drop Table bronze.crm_cust_info; 

Create Table bronze.crm_cust_info (
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date Date
);
------>>>>>>>>>>>>>------
If Object_id ('bronze.crm_prd_info', 'U') is not null
	Drop Table bronze.crm_prd_info;

Create Table bronze.crm_prd_info (
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR (50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME
);
------>>>>>>>>>>>>>------
If Object_id ('bronze.crm_sales_details', 'U') is not null 
	Drop Table bronze.crm_sales_details;

Create Table bronze.crm_sales_details (
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT, 
	sls_due_dt INT,
	sls_sales INT, 
	sls_quantity INT,
	sls_price INT
);
------>>>>>>>>>>>>>------
If object_id ('bronze.erp_loc_a101', 'U') is not null
	Drop Table bronze.erp_loc_a101;

Create Table bronze.erp_loc_a101 (
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);
------>>>>>>>>>>>>>------
If Object_id ('bronze.erp_cust_az12', 'U') is not null
	Drop Table bronze.erp_cust_az12;

Create Table bronze.erp_cust_az12 (
	cid NVARCHAR(50),
	bdate DATE ,
	gen NVARCHAR(50)
);
------>>>>>>>>>>>>>------
If Object_id ('bronze.erp_px_cat_g1v2', 'U') is not null
	Drop Table bronze.erp_px_cat_g1v2; 

Create Table bronze.erp_px_cat_g1v2 (
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
);
Go
------>>>>>>>>>>>>>------

