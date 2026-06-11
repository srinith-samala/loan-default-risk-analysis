CREATE DATABASE Loan;
USE Loan

CREATE TABLE loan(
	Loan_id VARCHAR(100),
	Customer_ID	 VARCHAR(100),
	Loan_Status VARCHAR(100),
    Current_Loan_Amount VARCHAR(100),
    term varchar(100),
    Credit_Score VARCHAR(100),
    Annual_Income VARCHAR(100),
    years_in_current_job VARCHAR(100),
    Home_Ownership VARCHAR(100),
    purpose varchar(100),
    Monthly_Debt VARCHAR(100),
    Years_of_Credit_History VARCHAR(100),
    Months_since_last_delinquent VARCHAR(100),
    Number_of_Open_Accounts VARCHAR(100),
    Number_of_Credit_Problems VARCHAR(100),
    Current_Credit_Balance VARCHAR(100),
    Maximum_Open_Credit VARCHAR(100),
    Bankruptcies VARCHAR(100),
    Tax_Liens VARCHAR(100)
    );

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/credit_train.csv'
INTO TABLE loan
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM loan;
SELECT COUNT(DISTINCT Loan_id) FROM loan;
SELECT COUNT(*) 
FROM (SELECT DISTINCT * FROM loan) t;

SELECT * FROM loan;
select loan_id,count(*) as occuarce 
from loan 
group by loan_id 
having count(*) > 1;

select * from clean_loan
where loan_id = 'dc17c812-a350-459f-84dd-906fd42a5ab2';

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Loan_ID) AS unique_loans
FROM clean_loan;

create table clean_loan(
select distinct * from loan );

SELECT *
FROM clean_loan
WHERE Loan_ID IN (
    SELECT Loan_ID
    FROM clean_loan
    GROUP BY Loan_ID
    HAVING COUNT(*) > 1
)
LIMIT 20;

select DISTINCT(Credit_Score) from clean_loan;

select (Credit_Score) ,length(Credit_score) as reeetiion 
from clean_loan;

UPDATE CLEAN_LOAN 
SET CREDIT_SCORE = CREDIT_SCORE/10
WHERE CREDIT_SCORE <300 OR CREDIT_SCORE >850;

UPDATE clean_loan
set credit_score = null 
where credit_score > 850 or credit_score < 300;

select distinct(Annual_Income) from clean_loan;

update clean_loan 
set Annual_Income = trim(Annual_Income);

update clean_loan 
set years_in_current_job = trim(years_in_current_job);

select Current_Loan_Amount from clean_loan 
WHERE Current_Loan_Amount = 10000000 
OR Current_Loan_Amount < 0 
OR Current_Loan_Amount = '' 
OR Current_Loan_Amount IS NULL;

update clean_loan 
set Loan_Status = 'Default'
where Loan_Status = 'Charged off';

update clean_loan 
set Loan_Status = 'Non-Default'
where Loan_Status = 'Fully Paid'
 
select * from clean_loan limit 3;
-- 1) Does credit score and annual income matter for a loan default?
select 
    CASE
		when credit_score < 600 then 'low Score'
        when credit_score between 600 and 800 then 'medium Score'
        else 'High Score'
	end as credit_score_band, 
    
    CASE 
		WHEN Annual_income < 500000 then 'Low Income'
        when Annual_income between 500000 and 1500000 then 'Medium Income'
        else 'High Income'
	end as Income_band,
    
    count(*) as total_customer,
    sum(case when loan_status = 'Default' then 1 else 0 end )as default_count,
    sum(case when loan_status = 'Default' then Current_Loan_Amount else 0 end ) as revenue_loss 
    from clean_loan 
    group by credit_score_band,Income_band;



-- 2)is monthly debt directly associated with default loans?
select 
	CASE 
		WHEN Monthly_Debt < 20000 THEN 'Low Debt'
        when Monthly_Debt between 20000 and 50000 then 'Medium Debt'
        ELSE 'High Debt'
        end as DEBT_BAND,
        
	COUNT(*) AS TOTAL_CUSTOMER,
    sum(case when loan_status = 'Default' then 1 else 0 end ) as default_count,
    sum(case when loan_status = 'Default' then 1 else 0 end) *100.0 / count(*) as default_rate
    from clean_loan
    group by debt_band;
-- 3) Do customers with more open accounts have a higher default rate?
select 
	case 
		when Number_of_Open_Accounts < 2 then " Low Account"
		when Number_of_Open_Accounts between 2 and 8  then "Medium Account"
        else "High Account"
        end as account_band,
        
	count(*) as total_customer,
    sum(case when loan_status = 'Default' then 1 else 0 end ) as default_count,
    sum(case when loan_status = 'Default' then 1 else 0 end) *100.0 / count(*) as default_rate
    from clean_loan
    group by account_band;

-- 4)	What is the total revenue loss from defaulted loans, and which customer segment contributes the highest share of this loss? 
select 
	Home_ownership,
	purpose,
	 SUM(CASE WHEN Loan_Status = 'Default' THEN Current_Loan_Amount else 0 END) as total_revenue_loss,
      SUM(CASE WHEN Loan_Status = 'Default' THEN Current_Loan_Amount else 0 END) * 100.0/
      sum( SUM(CASE WHEN Loan_Status = 'Default' THEN Current_Loan_Amount else 0 END)) over() as loss_share
      from clean_loan
      group by Home_ownership,purpose;
