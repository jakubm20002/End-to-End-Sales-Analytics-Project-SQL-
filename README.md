# End-to-End-Sales-Analytics-Project-SQL-
End-to-End data analytics project: building a data warehouse from CSV files, performing EDA, advanced analytics and customer segmentation.

1. Project Overwiev

Project is designed to portray complete analytic pipeline. It is based on raw data stored in CSV files. 

The Data Warehouse creation approach is based on a Medalion architecture. There are three different layers, each with individual purpose: bronze, silver and gold.

In the next step, project provides Exploratory Data Analysis and Advanced Analytics.

The final step is a report that includes detailed informations about top customers.

2. Architecture & Data Layers

Bronze Layer – it includes raw data imported directly from CSV files. The data was imported using a basic import process. Additional configuration was required to handle foreign characters in text fields. After successful import, first quality check of the data was performed.

Silver Layer – the main goal of this layer was to clean and technically correct the data.
Unnecessary NULL values were removed, column data types were corrected and the second quality check was perfomormed. 

Gold Layer – the tables from silver layer were combined into thematic views in a more convenient analytical form. The main purpose of these views is to provide analise-ready-data without unnecessary columns. The last step of this layer wast the third quality check.

3. Data Model

The Gold Layer is devided into two groups of views. 

First group is a fact view and is created as single view which includes measurable data, ready for aggregations and other analysis.

The second group consists of dimensions views, created as three thematic views: customers, orders, products. Each of these views provides desciptive informations about specific side of the business.

In the customer view a surrogate key is created. Its purpose is to maintain integrity during joining views and provide a easier use during analysis. The business key in the original data is less convenient for analysis and more likely to introduce instability when joining views.

4. Quality control check

Bronze Quality Check -  its purpose is to detect imperfections in the raw data, but not to fix them.

Silver Quality Check – verifies that issues detected in the previous step were corrected. It also validates the data logically (no extreme old or future dates, no negative values in columns like price or quantity).

Gold Quality Check – checks the consistency of keys between the newly created anlytical views.

5. Exploatory Data Analysis (EDA)

Dimension Exlporation – this analysis provides geographical range of operation of this company alongside their operational partners and categories of products in which they specialize.

Dates Exploration – shows the activity period of company and provides details about order fulfilment efficiency.
Provides both extremes and average speed of order fulfilment. As a bonus it shows comparison of orders shipped and not shipped.

Measure Exploration – provides insight into basic numerical values that determine the size of a company during its period of activity.

Magnitude Exploration – uses previous analyses to show the distribution of activity and revenue by country and provides in-depth information on revenue from individual product categories.

Ranking Analysis – shows the most and least profitable customers and suppliers whose products generate the highest revenue.

6. Advanced Analytics
Time-Based Performance Analysis – using information about the company's operating period, it shows the dynamic of sales change month by month and presents monthly seasonality.

Cumulative Analysis – shows sales in a cumulative form over time, making it easier to identify moments when selected thresholds are exceeded.

Part-to-Whole Analysis – using information about product categories, it shows their contribution to total sales.

Segmentation – provides insight into customer segmentation in two ways: first based on arbitrary revenue thresholds and second based on percentile distribution of customers.

Segmentation comparison – shows difference between arbitrary segmentation approach and the real distribution of customers.

7. Top Customer Analysis (report) 
Purpose – providing informations about characteristics and contribution of the top 20% revenue-generating customers.

Key findings:
Top 20% of customers generate 58% of total revenue.
Most of these customers comes from Germany and the USA.
Their average lifespan is 18 months.
The average number of orders placed by these customers is 51.
The average discount the company provide for these customers is 6,8%.

Business Implications:
The company may benefit after further analysis of these customers, identifying factors that drives their higher revenue contribution.
It may also be beneficial to analyse how these customers react to pricing changes. It is possible that these 20% of customers do not require discounts at all or that adjusted discount strategies could improve overall revenue.
Understanding their purchasing patterns could help improve customer retention strategies.

8. Project structure
/docs
/01_database_setup
/02_bronze_layer
/03_silver_layer
/04_gold_layer
/05_quality_checks
/06_eda
/07_advanced_analytics
/08_final_report

9. Tools & Environment
SQL (SQL Server)
CSV files
Draw.io
Git
