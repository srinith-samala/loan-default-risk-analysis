# loan-default-risk-analysis
# Loan Default Risk Analysis

## Overview

This project analyzes loan default patterns to identify high-risk borrower segments and uncover the factors most associated with loan defaults. The objective is to help lenders improve risk assessment, reduce default exposure, and make more informed lending decisions.

The analysis was performed using MySQL for data cleaning and business analysis, followed by Power BI for interactive dashboard development.

---

## Business Problem

Loan defaults represent a major risk for lending institutions. Understanding which customer segments contribute most to defaults can help businesses improve underwriting policies, optimize portfolio performance, and reduce financial exposure.

This project investigates the drivers of loan defaults and identifies borrower segments that contribute the highest default exposure.

---

## Dataset Information

**Source:** Kaggle Loan Dataset

**Raw Records:** 100,514

**Features Included:**

* Loan Status
* Current Loan Amount
* Credit Score
* Annual Income
* Home Ownership
* Loan Purpose
* Monthly Debt
* Years in Current Job
* Number of Open Accounts
* Credit History
* Current Credit Balance
* Tax Liens
* Bankruptcies

For analysis purposes:

* Fully Paid → Non-Default
* Charged Off → Default

---

## Data Cleaning & Preparation

### Data Quality Issues Identified

#### Duplicate Records

* Raw dataset contained 100,514 records.
* Exact duplicate rows were identified and removed using SQL DISTINCT.
* Remaining duplicate Loan IDs were investigated.
* Since duplicate Loan IDs often contained conflicting information and no reliable business rule existed to determine an authoritative record, these records were retained and documented.

#### Missing Values

Missing values were primarily observed in:

* Credit Score
* Annual Income

Approximately 21% of records contained missing values in these fields.

These values were retained rather than imputed to avoid introducing bias through arbitrary replacements.

#### Data Standardization

The following standardization steps were performed:

* Standardized inconsistent categorical values.
* Corrected category naming inconsistencies such as:

  * "other" → "Other"
* Removed unnecessary whitespace.
* Ensured consistent formatting across categorical variables.

#### Data Type Conversion

Appropriate data types were assigned to support analysis and reporting.

---

## Business Questions

### 1. Does credit score and annual income influence loan defaults?

### 2. Is monthly debt directly associated with loan defaults?

### 3. Do customers with more open accounts have a higher default rate?

### 4. What is the total defaulted loan amount, and which customer segment contributes the highest share of default exposure?

---

## Tools Used

* MySQL
* Power BI

---

## SQL Analysis

The analysis was conducted using SQL queries designed to answer each business question.

Key techniques used:

* CASE Statements
* Aggregations
* Common Table Expressions (CTEs)
* Window Functions
* Grouping and Segmentation Analysis
* Percentage Calculations

---

## Key Insights

### Insight 1

I found that borrowers with medium credit scores and medium annual income default the most, with approximately 11,850 defaults and more than 3.4 billion in defaulted loan amount. This matters because medium credit score and medium income borrowers represent one of the largest segments in the lending portfolio and contribute the greatest share of default exposure. The business should tighten approval criteria, strengthen income verification, and increase monitoring for medium-risk borrowers.

### Insight 2

I found that default rates remain relatively stable across debt bands and open account bands, ranging between approximately 24% and 26% across all categories. This matters because neither monthly debt nor the number of open accounts appears to be a strong standalone predictor of loan default. The business should place greater emphasis on credit score and income indicators instead of focusing heavily on debt levels or account counts.

### Insight 3

I found that renters taking debt consolidation loans account for approximately 2.56 billion in defaulted loan amount, representing around 34.8% of total default exposure. This matters because a single borrower segment contributes more than one-third of the overall portfolio risk. The business should implement stricter approval policies, increase repayment monitoring, and introduce early intervention programs for debt consolidation borrowers within the renter segment.

---

## Dashboard Features

The Power BI dashboard includes:

* Default vs Non-Default Overview
* Credit Score Analysis
* Income Segment Analysis
* Home Ownership Analysis
* Loan Purpose Analysis
* Monthly Debt Analysis
* Open Account Analysis
* Default Exposure Analysis
* Customer Segment Risk Analysis

---

## Recommendations

### Recommendation 1

Strengthen underwriting standards for medium credit score and medium income borrowers, as they contribute the highest default volume and default exposure.

### Recommendation 2

Reduce reliance on monthly debt and open account counts when evaluating borrower risk, as both variables show limited predictive value.

### Recommendation 3

Implement targeted risk management strategies for renters seeking debt consolidation loans through enhanced monitoring and proactive repayment support.

---

## Conclusion

This analysis identified the borrower segments responsible for the largest share of loan defaults and default exposure. The findings indicate that credit score and income are more meaningful indicators of default risk than monthly debt or open account counts.

By focusing on medium-risk borrowers and high-risk loan-purpose segments, lenders can improve portfolio quality, reduce default exposure, and make more effective lending decisions.
