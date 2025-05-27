-- Select all columns
SELECT * FROM customers;

-- Select specific columns
SELECT first_name, last_name FROM customers;

-- Select with a condition
SELECT * FROM customers WHERE signup_date > '2023-01-01';
