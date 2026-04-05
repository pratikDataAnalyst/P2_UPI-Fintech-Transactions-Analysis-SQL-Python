create database upi_project;
use upi_project;
create table transaction(
    transaction_id varchar(50),
    timestamp DATETIME,
    transaction_type VARCHAR(50),
    merchant_category VARCHAR(100),
    amount_inr FLOAT,
    transaction_status VARCHAR(20),
    sender_age_group VARCHAR(20),
    receiver_age_group VARCHAR(20),
    sender_state VARCHAR(50),
    sender_bank VARCHAR(50),
    receiver_bank VARCHAR(50),
    device_type VARCHAR(20),
    network_type VARCHAR(20),
    fraud_flag INT,
    hour_of_day INT,
    day_of_week VARCHAR(20),
    is_weekend VARCHAR(10)
);
select * from transactions;
select count(*) as total_transaction from transaction;
## 1. TOTAL TRANSACTIONS
SELECT COUNT(*) AS total_transactions FROM transactions;
## 2. TOTAL AMOUNT.
SELECT SUM(amount_inr) AS total_amount FROM transactions;
## 3. SUCCESS vs FAILED.
SELECT transaction_status, COUNT(*) 
FROM transactions
GROUP BY transaction_status;
## 4. TOP BANKS.
SELECT sender_bank, COUNT(*) AS total_txn
FROM transactions
GROUP BY sender_bank
ORDER BY total_txn DESC
LIMIT 5;
## 5. FRAUD ANALYSIS.
select fraud_flag,count(*)
from transactions
group by fraud_flag;
## 6.PEAK TRANSACTION HOUR.
SELECT hour_of_day, COUNT(*) AS total_txn
FROM transactions
GROUP BY hour_of_day
ORDER BY total_txn DESC
LIMIT 1;
 ## 7. TOP 5 STATES BY TRANSACTIONS.
 SELECT sender_state, COUNT(*) AS total_txn
FROM transactions
GROUP BY sender_state
ORDER BY total_txn DESC
LIMIT 5;
## 8.WEEKEND vs WEEKDAY PERFORMANCE.
SELECT is_weekend,COUNT(*) AS total_txn,SUM(amount_inr) AS total_amount
FROM transactions
GROUP BY is_weekend;
## 9.FRAUD RATE (VERY IMPRESSIVE)
SELECT 
    (SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS fraud_percentage
FROM transactions;
## 10.AVERAGE TRANSACTION AMOUNT BY TYPE.
SELECT transaction_type, 
       AVG(amount_inr) AS avg_amount
FROM transactions
GROUP BY transaction_type;
## 11.Top Bank By Total_Amount.
SELECT sender_bank,SUM(amount_inr) AS total_amount
FROM transactions
GROUP BY sender_bank
ORDER BY total_amount DESC
LIMIT 5;
## 12.HIGH VALUE TRANSACTIONS.
select count(*) as high_value_tran
from transactions
where amount_inr>6000;
## 13.Fraud Rate by states.
SELECT sender_state,COUNT(*) AS total_transactions,SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
ROUND((SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 
        2) AS fraud_percentage
FROM transactions
GROUP BY sender_state
ORDER BY fraud_percentage DESC
limit 5;
## "I calculated fraud rate by dividing fraudulent transactions by total
#  transactions for each state to identify high-risk regions.”
### final Conclusion
# The analysis of UPI transactions reveals a strong adoption of digital payments, 
# with a high success rate indicating system reliability.
# Most transactions are low-value and occur through mobile devices,
# especially Android, highlighting everyday usage patterns. 
# Certain banks and states dominate transaction volume, 
# showing higher user trust and regional adoption. 
# Fraudulent transactions are minimal but present, 
# suggesting the need for continuous monitoring. 
# Overall, the UPI ecosystem is efficient, widely adopted, 
# and growing rapidly across different user segments.
