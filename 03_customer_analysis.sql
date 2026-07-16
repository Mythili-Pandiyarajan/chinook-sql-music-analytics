USE Chinook;

-- 5. Top 10 customers by total spend
SELECT 
    c.CustomerId,
    CONCAT(c.FirstName, ' ', c.LastName) AS customer_name,
    c.Country,
    ROUND(SUM(i.Total), 2) AS total_spend,
    COUNT(i.InvoiceId) AS invoice_count
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, customer_name, c.Country
ORDER BY total_spend DESC
LIMIT 10;

-- 6. Average order value by country
SELECT 
    Country,
    ROUND(AVG(Total), 2) AS avg_order_value,
    COUNT(*) AS total_orders
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId
GROUP BY Country
ORDER BY avg_order_value DESC;

-- 7. Repeat customers: more than 5 invoices
SELECT 
    c.CustomerId,
    CONCAT(c.FirstName, ' ', c.LastName) AS customer_name,
    COUNT(i.InvoiceId) AS invoice_count,
    ROUND(SUM(i.Total), 2) AS total_spend
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, customer_name
HAVING COUNT(i.InvoiceId) > 5
ORDER BY invoice_count DESC;