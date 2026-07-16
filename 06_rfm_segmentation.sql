USE Chinook;

WITH customer_rfm AS (
    SELECT 
        c.CustomerId,
        CONCAT(c.FirstName, ' ', c.LastName) AS customer_name,
        c.Country,
        DATEDIFF((SELECT MAX(InvoiceDate) FROM Invoice), MAX(i.InvoiceDate)) AS recency_days,
        COUNT(i.InvoiceId) AS frequency,
        ROUND(SUM(i.Total), 2) AS monetary
    FROM Customer c
    JOIN Invoice i ON c.CustomerId = i.CustomerId
    GROUP BY c.CustomerId, customer_name, c.Country
),
rfm_scores AS (
    SELECT 
        *,
        NTILE(4) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(4) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(4) OVER (ORDER BY monetary ASC) AS monetary_score
    FROM customer_rfm
)
SELECT 
    CustomerId,
    customer_name,
    Country,
    recency_days,
    frequency,
    monetary,
    recency_score,
    frequency_score,
    monetary_score,
    (recency_score + frequency_score + monetary_score) AS rfm_total,
    CASE 
        WHEN (recency_score + frequency_score + monetary_score) >= 10 THEN 'Champions'
        WHEN (recency_score + frequency_score + monetary_score) >= 7 THEN 'Loyal Customers'
        WHEN (recency_score + frequency_score + monetary_score) >= 4 THEN 'At Risk'
        ELSE 'Lost'
    END AS customer_segment
FROM rfm_scores
ORDER BY rfm_total DESC;