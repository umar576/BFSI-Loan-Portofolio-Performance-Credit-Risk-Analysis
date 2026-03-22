use BFSI
select * from Monthly_balance_base
select count(*) from main_loan_base
select count(*) as Null_count from Monthly_balance_base where balance_amount is null
select count(*) as Total_Row from main_loan_base
select count(*) as Total_Rows from Monthly_balance_base
select count(*) as Total_Rows from Repayment_base
select * from Repayment_base
select count(*) as Null_count from Repayment_base where repayment_amount is null

select loan_acc_num,loan_type,loan_amount,disbursal_date ,count(*) as Duplicates 
from main_loan_base 
group by loan_acc_num,loan_type,loan_amount,disbursal_date 
having count(*)>1

SELECT
    loan_acc_num,
    loan_type,
    loan_amount,
    missed_repayments,
    default_date,
    CASE
        WHEN default_date IS NOT NULL THEN 'Defaulted'
        WHEN missed_repayments >= 3 THEN 'Delinquent'
        ELSE 'Performing'
    END AS loan_status
FROM main_loan_base;

SELECT missed_repayments, COUNT(*) AS loans
FROM main_loan_base
GROUP BY missed_repayments
ORDER BY missed_repayments;

SELECT cheque_bounces, COUNT(*) AS loans
FROM main_loan_base
GROUP BY cheque_bounces
ORDER BY cheque_bounces;

SELECT vintage_in_months, COUNT(*) AS loans
FROM main_loan_base
GROUP BY vintage_in_months
ORDER BY vintage_in_months;

SELECT
    loan_acc_num,
    loan_type,
    loan_amount,
    missed_repayments,
    cheque_bounces,
    CASE
        WHEN missed_repayments >= 5 THEN 'High Risk'
        WHEN missed_repayments BETWEEN 3 AND 4 THEN 'Delinquent'
        ELSE 'Performing'
    END AS loan_health
FROM main_loan_base;

CREATE VIEW loan_health_view AS
SELECT
    loan_acc_num,
    loan_type,
    loan_amount,
    interest,
    monthly_emi,
    missed_repayments,
    cheque_bounces,
    vintage_in_months,
    CASE
        WHEN missed_repayments >= 5 THEN 'High Risk'
        WHEN missed_repayments BETWEEN 3 AND 4 THEN 'Delinquent'
        ELSE 'Performing'
    END AS loan_health
FROM main_loan_base;

select * from loan_health_view

SELECT
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_exposure,
    AVG(loan_amount) AS avg_loan_size
FROM main_loan_base;

SELECT TOP 10 * FROM loan_health_view;

SELECT loan_health, COUNT(*) AS loans
FROM loan_health_view
GROUP BY loan_health;

SELECT
    loan_health,
    SUM(cast(loan_amount as bigint)) AS exposure
FROM loan_health_view
GROUP BY loan_health;

SELECT loan_type, loan_health, COUNT(*) AS loans
FROM loan_health_view
GROUP BY loan_type, loan_health
ORDER BY loan_type;

SELECT vintage_in_months, loan_health, COUNT(*) AS loans
FROM loan_health_view
GROUP BY vintage_in_months, loan_health
ORDER BY vintage_in_months;