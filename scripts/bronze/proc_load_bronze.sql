/*
====================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
====================================================================================
Script Purpose: 
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  - Truncate the bronze tables before loading data. 
  - Uses the 'Bulk Insert' command to load data from csv files external CSV files. 
Parameters:
  None.
This stored procedure does not accept any parameter or return any values. 

Usage Example: 
  EXEC bronze.load_bronze;
====================================================================================
We are gonna load the data using Bulk Insert.

Bulk Insert: It is the method to load the data from source (either text or csv file) 
to the target (data warehouse). */

-- Truncate will empty all the data from the table. 
====================================================================================
-- Execeuting the Stored Procedure: 
Exec bronze.load_bronze
====================================================================================
  
-- Creating Stored Precedure.

Create Or Alter Procedure bronze.load_bronze AS 
BEGIN 
	Declare @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	BEGIN TRY
		Print('===================================');
		Print('Loading Bronze Layer');
		Print('===================================');

		Print('-----------------------------------')
		Print('Loading CRM Tables');
		Print('-----------------------------------');

		SET @batch_start_time = GETDATE();
		SET @start_time = GETDATE();
		Print('Truncating the Table Into: bronze.crm_cust_info');
		Truncate Table bronze.crm_cust_info;

		Print('Inserting Data Into: bronze.crm_cust_info');
		Bulk Insert bronze.crm_cust_info
		From 'C:\Users\sksin\OneDrive\Desktop\SQL Project File\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		With (

			Firstrow = 2, 
			FieldTerminator = ',',
			Tablock
			);
		SET @end_time = GETDATE()
		Print ('Loading Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds');
			------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>------

		SET @start_time = GETDATE();
		Print('Truncating the Table Into: bronze.crm_prd_info');
		Truncate Table bronze.crm_prd_info;

		Print('Inserting Data Into: bronze.crm_prd_info');
		Bulk Insert bronze.crm_prd_info
		From 'C:\Users\sksin\OneDrive\Desktop\SQL Project File\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		With (
			Firstrow = 2,
			FieldTerminator = ',',
			Tablock
		); 
		SET @end_time = GETDATE()
		Print ('Loading Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds');
		------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>------

		SET @start_time = GETDATE();
		Print('Truncating the Table Into: bronze.crm_sales_details');
		Truncate Table bronze.crm_sales_details;

		Print('Inserting Data Into: bronze.crm_sales_details');
		Bulk Insert bronze.crm_sales_details
		From 'C:\Users\sksin\OneDrive\Desktop\SQL Project File\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		With ( Firstrow = 2, Fieldterminator = ',', Tablock)

		SET @end_time = GETDATE()
		Print ('Loading Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds');
		------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>------

		Print('-----------------------------------');
		Print('Loading ERP Tables');
		Print('-----------------------------------');

		SET @start_time = GETDATE();
		Print('Truncating the Table Into: bronze.erp_cust_az12');
		Truncate Table bronze.erp_cust_az12;

		Print('Inserting Data Into: bronze.erp_cust_az12');
		Bulk Insert bronze.erp_cust_az12
		From 'C:\Users\sksin\OneDrive\Desktop\SQL Project File\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		With (Firstrow = 2, FieldTerminator = ',', Tablock)
		SET @end_time = GETDATE()
		Print ('Loading Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds');

		------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>------
		SET @start_time = GETDATE();
		Print('Truncating the Table Into: bronze.erp_loc_a101');
		Truncate Table bronze.erp_loc_a101;

		Print('Inserting Data Into: bronze.erp_erp_loc_a101');
		Bulk Insert bronze.erp_loc_a101
		From 'C:\Users\sksin\OneDrive\Desktop\SQL Project File\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		With (Firstrow = 2, FieldTerminator = ',', Tablock)
		SET @end_time = GETDATE()
		Print ('Loading Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds');
		------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>------

		SET @start_time = GETDATE();
		Print('Truncating the Table Into: erp_px_cat_g1v2');
		Truncate Table bronze.erp_px_cat_g1v2;

		Print('Inserting Data Into: bronze.erp_px_cat_g1v2');
		Bulk Insert bronze.erp_px_cat_g1v2
		From 'C:\Users\sksin\OneDrive\Desktop\SQL Project File\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		With (Firstrow = 2, FieldTerminator = ',', Tablock)
		SET @end_time = GETDATE()
		Print ('Loading Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds');
		Print('------------------------------------')
		SET @batch_end_time = GETDATE();
		Print('Batch Loading Duration: ' + CAST(DATEDIFF (second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds')
	
	END TRY
	Begin Catch 
		Print 'Error Occured during loading the Bronze Layer.';
		Print 'Error Message' + Error_Message();
		Print('Error Number' + CAST (Error_Number() AS NVARCHAR));
	End Catch
End
------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>------
