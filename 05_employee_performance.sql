USE Chinook;

-- 12. Revenue generated per employee (via their assigned customers)
SELECT 
    e.EmployeeId,
    CONCAT(e.FirstName, ' ', e.LastName) AS employee_name,
    e.Title,
    ROUND(SUM(i.Total), 2) AS total_revenue_generated,
    COUNT(DISTINCT c.CustomerId) AS customers_managed,
    COUNT(i.InvoiceId) AS invoices_handled
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId, employee_name, e.Title
ORDER BY total_revenue_generated DESC;

-- 13. Employee hierarchy (self-join on ReportsTo)
SELECT 
    e.EmployeeId,
    CONCAT(e.FirstName, ' ', e.LastName) AS employee_name,
    e.Title,
    CONCAT(m.FirstName, ' ', m.LastName) AS manager_name,
    m.Title AS manager_title
FROM Employee e
LEFT JOIN Employee m ON e.ReportsTo = m.EmployeeId
ORDER BY manager_name, employee_name;