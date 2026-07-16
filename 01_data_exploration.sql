USE Chinook;

-- Row counts for every table
SELECT 'Artist' AS table_name, COUNT(*) AS row_count FROM Artist
UNION ALL
SELECT 'Album', COUNT(*) FROM Album
UNION ALL
SELECT 'Track', COUNT(*) FROM Track
UNION ALL
SELECT 'Genre', COUNT(*) FROM Genre
UNION ALL
SELECT 'MediaType', COUNT(*) FROM MediaType
UNION ALL
SELECT 'Playlist', COUNT(*) FROM Playlist
UNION ALL
SELECT 'PlaylistTrack', COUNT(*) FROM PlaylistTrack
UNION ALL
SELECT 'Customer', COUNT(*) FROM Customer
UNION ALL
SELECT 'Employee', COUNT(*) FROM Employee
UNION ALL
SELECT 'Invoice', COUNT(*) FROM Invoice
UNION ALL
SELECT 'InvoiceLine', COUNT(*) FROM InvoiceLine;

-- Date range of invoices (helps you know what period you're analyzing)
SELECT 
    MIN(InvoiceDate) AS earliest_invoice,
    MAX(InvoiceDate) AS latest_invoice
FROM Invoice;

-- Check for nulls in key customer columns
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Email IS NULL THEN 1 ELSE 0 END) AS null_emails,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS null_countries,
    SUM(CASE WHEN SupportRepId IS NULL THEN 1 ELSE 0 END) AS null_support_rep
FROM Customer;

-- How many distinct countries do customers come from?
SELECT COUNT(DISTINCT Country) AS distinct_countries FROM Customer;

-- Quick look at genres available
SELECT Name FROM Genre ORDER BY Name;