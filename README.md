# 📚 Case Study: Clothing Company
## Business Task
A Clothing Company prides themselves on providing an optimised range of clothing and lifestyle wear for the modern adventurer!

The CEO of this trendy fashion company has asked you to assist the team’s merchandising teams analyse their sales performance and generate a basic financial report to share with the wider business.

Please note that all the information regarding the case study has been sourced from the following link: [here](https://8weeksqlchallenge.com/case-study-7/). 
***
## Given Data
**Table 1: `product_details`**

|product_id|price|product_name|category_id|segment_id|style_id|category_name|segment_name|style_name|
|:----|:----|:----|:----|:----|:----|:----|:----|:----|
|c4a632|13|Navy Oversized Jeans - Womens|1|3|7|Womens|Jeans|Navy Oversized|
|e83aa3|32|Black Straight Jeans - Womens|1|3|8|Womens|Jeans|Black Straight|
|e31d39|10|Cream Relaxed Jeans - Womens|1|3|9|Womens|Jeans|Cream Relaxed|
|d5e9a6|23|Khaki Suit Jacket - Womens|1|4|10|Womens|Jacket|Khaki Suit|
|72f5d4|19|Indigo Rain Jacket - Womens|1|4|11|Womens|Jacket|Indigo Rain|
|9ec847|54|Grey Fashion Jacket - Womens|1|4|12|Womens|Jacket|Grey Fashion|
|5d267b|40|White Tee Shirt - Mens|2|5|13|Mens|Shirt|White Tee|
|c8d436|10|Teal Button Up Shirt - Mens|2|5|14|Mens|Shirt|Teal Button Up|
|2a2353|57|Blue Polo Shirt - Mens|2|5|15|Mens|Shirt|Blue Polo|
|f084eb|36|Navy Solid Socks - Mens|2|6|16|Mens|Socks|Navy Solid|


**Table 2: `sales`**

|prod_id|qty|price|discount|member|txn_id|start_txn_time|
|:----|:----|:----|:----|:----|:----|:----|
|c4a632|4|13|17|true|54f307|2021-02-13T01:59:43.296Z|
|5d267b|4|40|17|true|54f307|2021-02-13T01:59:43.296Z|
|b9a74d|4|17|17|true|54f307|2021-02-13T01:59:43.296Z|
|2feb6b|2|29|17|true|54f307|2021-02-13T01:59:43.296Z|
|c4a632|5|13|21|true|26cc98|2021-01-19T01:39:00.345Z|
|e31d39|2|10|21|true|26cc98|2021-01-19T01:39:00.345Z|
|72f5d4|3|19|21|true|26cc98|2021-01-19T01:39:00.345Z|
|2a2353|3|57|21|true|26cc98|2021-01-19T01:39:00.345Z|
|f084eb|3|36|21|true|26cc98|2021-01-19T01:39:00.345Z|
|c4a632|1|13|21|false|ef648d|2021-01-27T02:18:17.164Z|

**Table 3: `product_hierarchy`**

|id|parent_id|level_text|level_name|
|:----|:----|:----|:----|
|1|null|Womens|Category|
|2|null|Mens|Category|
|3|1|Jeans|Segment|
|4|1|Jacket|Segment|
|5|2|Shirt|Segment|
|6|2|Socks|Segment|
|7|3|Navy Oversized|Style|
|8|3|Black Straight|Style|
|9|3|Cream Relaxed|Style|
|10|4|Khaki Suit|Style|

**Table 4: `product_prices`**

|id|product_id|price|
|:----|:----|:----|
|7|c4a632|13|
|8|e83aa3|32|
|9|e31d39|10|
|10|d5e9a6|23|
|11|72f5d4|19|
|12|9ec847|54|
|13|5d267b|40|
|14|c8d436|10|
|15|2a2353|57|
|16|f084eb|36|

***
## Questions
## 📈 A. High Level Sales Analysis

**1. What was the total quantity sold for all products?**


**2. What is the total generated revenue for all products before discounts?**

**3. What was the total discount amount for all products?**
***

## 🧾 B. Transaction Analysis

**1. How many unique transactions were there?**

**2. What is the average unique products purchased in each transaction?**

**3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?**

**4. What is the average discount value per transaction?**

**5. What is the percentage split of all transactions for members vs non-members?**
***

## 👚 C. Product Analysis

**1. What are the top 3 products by total revenue before discount?**

**2. What is the total quantity, revenue and discount for each segment?**

**3. What is the top selling product for each segment?**

**4. What is the total quantity, revenue and discount for each category?**

**5. What is the top selling product for each category?**
