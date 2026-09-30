# SQL - Sales Analysis

## Overview

Analysis of customer behavior, retention, and lifetime value for an e-commerce company to improve customer retention and maximize revenue.

## Business Questions

1. **Customer Segmentation Analysis:** Who are our most valuable customers?
2. **Cohort Analysis:** How do different customer groups generate revenue?
3. **Retention Analysis:** Which customers haven't purchased recently?

## Assumptions & Definitions

- All queries read from the `cohort_analysis` view/table (one row per customer order, with `customerkey`, `cleaned_name`, `orderdate`, `first_purchase_date`, `cohort_year`, `total_net_revenue`).
- **Segments:** based on customer LTV percentiles (`PERCENTILE_CONT`). Low-Value < 25th percentile, Mid-Value between the 25th and 75th, High-Value > 75th.
- **Cohort:** the year of a customer's first purchase. Revenue per customer in the cohort query is measured on the first-purchase order only.
- **Churn:** a customer is `Churned` if their last purchase was more than 6 months before the as-of date `2024-04-20` (hard-coded in the query). Customers whose first purchase was within those last 6 months are excluded.

## Analysis Approach

### 1. Customer Segmentation Analysis

- Categorized customers based on total lifetime value (LTV)
- Assigned customers to High, Mid, and Low-value segments
- Calculated key metrics: total revenue, customer count, and average LTV per segment

🖥️ Query: [1_customer_segmentation.sql](1_customer_segmentation.sql)

📊 **Key Findings:**
- High-value segment (25% of customers) drives 66% of revenue ($135.4M)
- Mid-value segment (50% of customers) generates 32% of revenue ($66.6M)
- Low-value segment (25% of customers) accounts for 2% of revenue ($4.3M)

💡 **Business Insights:**
- High-Value (66% revenue): Offer a premium membership program to the 12,372 VIP customers, as losing one customer significantly impacts revenue
- Mid-Value (32% revenue): Create upgrade paths through personalized promotions; moving mid-value customers toward high-value spend is the largest growth lever
- Low-Value (2% revenue): Design re-engagement campaigns and price-sensitive promotions to increase purchase frequency

### 2. Cohort Analysis

- Tracked revenue and customer count per cohort
- Cohorts were grouped by year of first purchase
- Compared first-purchase revenue per customer across cohorts

🖥️ Query: [2_cohort_analysis.sql](/2_cohort_analysis.sql)

📊 **Key Findings:**
- Revenue per customer shows an alarming decreasing trend over time
  - 2022-2024 cohorts are consistently performing worse than earlier cohorts
  - NOTE: Although net revenue is increasing, this is likely due to a larger customer base, which is not reflective of customer value

💡 **Business Insights:**
- Value extracted from customers is decreasing over time and needs further investigation.
- In 2023 we saw a drop in the number of customers acquired, which is concerning.
- With both declining customer value and decreasing customer acquisition, the company is facing a potential revenue decline.

### 3. Retention Analysis

- Identified customers at risk of churning
- Analyzed last purchase patterns
- Calculated churn and active rates per cohort

🖥️ Query: [3_retention_analysis.sql](3_retention_analysis.sql)

📊 **Key Findings:**
- Cohort churn stabilizes at ~90% after 2-3 years, indicating a predictable long-term retention pattern.
- Retention rates are consistently low (8-10%) across all cohorts, suggesting retention issues are systemic rather than specific to certain years.
- Newer cohorts (2022-2023) show similar churn trajectories, signaling that without intervention, future cohorts will follow the same pattern.

💡 **Business Insights:**
- Strengthen early engagement strategies to target the first 1-2 years with onboarding incentives, loyalty rewards, and personalized offers to improve long-term retention.
- Re-engage high-value churned customers with targeted win-back campaigns rather than broad retention efforts, as reactivating valuable users may yield higher ROI.
- Predict and preempt churn risk: use customer-specific warning indicators to intervene with at-risk users before they lapse (a next step, not covered by the current query).

## Strategic Recommendations

1. **Customer Value Optimization** (Customer Segmentation)
   - Launch a VIP program for the 12,372 high-value customers (66% of revenue)
   - Create personalized upgrade paths for the mid-value segment
   - Design price-sensitive promotions for the low-value segment to increase purchase frequency

2. **Cohort Performance Strategy** (Customer Revenue by Cohort)
   - Target 2022-2024 cohorts with personalized re-engagement offers
   - Implement loyalty/subscription programs to stabilize revenue fluctuations
   - Apply successful strategies from higher-spending earlier cohorts to newer customers

3. **Retention & Churn Prevention** (Customer Retention)
   - Strengthen first 1-2 year engagement with onboarding incentives and loyalty rewards
   - Focus on targeted win-back campaigns for high-value churned customers
   - Implement a proactive intervention system for at-risk customers before they lapse

## Technical Details

- **Database:** PostgreSQL
- **Analysis Tools:** DBeaver, SQL
- **AI Tools:** Claude
