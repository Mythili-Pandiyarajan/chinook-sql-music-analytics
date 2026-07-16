USE Chinook;

-- 1. Total revenue by year and month
SELECT 
    YEAR(InvoiceDate) AS invoice_year,
    MONTH(InvoiceDate) AS invoice_month,
    ROUND(SUM(Total), 2) AS total_revenue,
    COUNT(*) AS invoice_count
FROM Invoice
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY invoice_year, invoice_month;

-- 2. Revenue by country
SELECT 
    BillingCountry,
    ROUND(SUM(Total), 2) AS total_revenue,
    COUNT(*) AS invoice_count,
    ROUND(AVG(Total), 2) AS avg_invoice_value
FROM Invoice
GROUP BY BillingCountry
ORDER BY total_revenue DESC;

-- 3. Top 10 best-selling tracks by revenue
SELECT 
    t.Name AS track_name,
    ar.Name AS artist_name,
    ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS track_revenue,
    SUM(il.Quantity) AS units_sold
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
JOIN Album al ON t.AlbumId = al.AlbumId
JOIN Artist ar ON al.ArtistId = ar.ArtistId
GROUP BY t.TrackId, t.Name, ar.Name
ORDER BY track_revenue DESC
LIMIT 10;

-- 4. Revenue by genre
SELECT 
    g.Name AS genre,
    ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS genre_revenue,
    SUM(il.Quantity) AS units_sold,
    COUNT(DISTINCT il.InvoiceId) AS invoice_count
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY genre_revenue DESC;