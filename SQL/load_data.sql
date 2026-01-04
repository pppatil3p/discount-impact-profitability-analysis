DROP TABLE IF EXISTS final_analysis_data;

CREATE TABLE final_analysis_data (
    row_id INT,
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(200),
    sales DOUBLE,
    quantity INT,
    discount DOUBLE,
    profit DOUBLE,
    order_year INT,
    order_month INT,
    order_month_name VARCHAR(20),
    is_loss TINYINT,
    discount_bucket VARCHAR(20),
    profit_margin DOUBLE
);


LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/final_data.csv'
INTO TABLE final_analysis_data
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
 row_id,
 order_id,
 order_date,
 ship_date,
 ship_mode,
 customer_id,
 customer_name,
 segment,
 country,
 city,
 state,
 postal_code,
 region,
 product_id,
 category,
 sub_category,
 product_name,
 sales,
 quantity,
 discount,
 profit,
 order_year,
 order_month,
 order_month_name,
 is_loss,
 discount_bucket,
 profit_margin
);
