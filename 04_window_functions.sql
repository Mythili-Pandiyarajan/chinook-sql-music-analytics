USE Chinook;

-- 8. Month-over-month revenue growth %
WITH monthly_revenue AS (
    SELECT 
        YEAR(InvoiceDate) AS yr,
        MONTH(InvoiceDate) AS mo,
        ROUND(SUM(Total), 2) AS revenue
    FROM Invoice
    GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
)
SELECT 
    yr, mo, revenue,
    LAG(revenue) OVER (ORDER BY yr, mo) AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY yr, mo)) 
        / LAG(revenue) OVER (ORDER BY yr, mo) * 100, 2
    ) AS mom_growth_pct
FROM monthly_revenue
ORDER BY yr, mo;

-- 9. Running total of revenue by month
WITH monthly_revenue AS (
    SELECT 
        YEAR(InvoiceDate) AS yr,
        MONTH(InvoiceDate) AS mo,
        ROUND(SUM(Total), 2) AS revenue
    FROM Invoice
    GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
)
SELECT 
    yr, mo, revenue,
    SUM(revenue) OVER (ORDER BY yr, mo) AS running_total
FROM monthly_revenue
ORDER BY yr, mo;

-- 10. Rank customers by spend within their country
WITH customer_spend AS (
    SELECT 
        c.CustomerId,
        CONCAT(c.FirstName, ' ', c.LastName) AS customer_name,
        c.Country,
        SUM(i.Total) AS total_spend
    FROM Customer c
    JOIN Invoice i ON c.CustomerId = i.CustomerId
    GROUP BY c.CustomerId, customer_name, c.Country
)
SELECT 
    *,
    RANK() OVER (PARTITION BY Country ORDER BY total_spend DESC) AS rank_in_country
FROM customer_spend
ORDER BY Country, rank_in_country;

-- 11. Rank tracks within each genre by revenue
-- 11. Top 3 tracks within each genre by revenue (MySQL-compatible)
WITH track_revenue AS (
    SELECT 
        g.Name AS genre,
        t.Name AS track_name,
        SUM(il.UnitPrice * il.Quantity) AS revenue
    FROM InvoiceLine il
    JOIN Track t ON il.TrackId = t.TrackId
    JOIN Genre g ON t.GenreId = g.GenreId
    GROUP BY g.Name, t.Name
),
ranked AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY genre ORDER BY revenue DESC) AS rank_in_genre
    FROM track_revenue
)
SELECT * FROM ranked WHERE rank_in_genre <= 3
ORDER BY genre, rank_in_genre;