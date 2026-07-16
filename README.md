# Chinook SQL Music Store Analytics

End-to-end SQL analysis of a digital music store database, covering revenue trends, customer behavior, employee performance, and RFM-based customer segmentation. Built to demonstrate real-world analytical SQL — joins, CTEs, window functions, and business-focused query design — as a companion to my machine learning portfolio.

## Key Insights

- Revenue is heavily concentrated in three genres — **Rock, Latin, and Metal** — which together account for a large share of total sales
- The **USA and Canada** lead in total revenue, but smaller markets like Chile and Ireland show the **highest average order values**
- RFM segmentation split customers into four actionable tiers (**Champions, Loyal Customers, At Risk, Lost**), identifying which customers are worth retention efforts vs. re-engagement campaigns
- Top sales employee (Jane Peacock) generated noticeably higher revenue than peers, driven by both customer count and invoice volume

## Tools Used

- **MySQL 8.0** (Workbench) — all analysis
- **Power BI** — dashboard (in progress)
- **Dataset:** [Chinook Database](https://github.com/lerocha/chinook-database) — a sample digital media store dataset (Artists, Albums, Tracks, Customers, Employees, Invoices)

## SQL Scripts

| Script | Description | Key SQL Concepts |
|---|---|---|
| `01_data_exploration.sql` | Table row counts, date ranges, null checks | Basic aggregation |
| `02_revenue_analysis.sql` | Revenue by month, country, genre, top tracks | Multi-table JOINs, GROUP BY |
| `03_customer_analysis.sql` | Top customers, average order value, repeat buyers | HAVING, aggregate filtering |
| `04_window_functions.sql` | Month-over-month growth, running totals, ranked customers/tracks | LAG(), SUM() OVER(), RANK() OVER(PARTITION BY) |
| `05_employee_performance.sql` | Revenue per employee, org hierarchy | Multi-hop JOINs, self-JOIN |
| `06_rfm_segmentation.sql` | Recency/Frequency/Monetary customer segmentation | CTEs, NTILE(), CASE-based business logic |

## Sample Query — RFM Segmentation

The segmentation query combines three CTEs and window functions to score every customer on recency, frequency, and monetary value, then buckets them into business-readable tiers:

```sql
NTILE(4) OVER (ORDER BY recency_days DESC) AS recency_score,
NTILE(4) OVER (ORDER BY frequency ASC) AS frequency_score,
NTILE(4) OVER (ORDER BY monetary ASC) AS monetary_score
```

See `06_rfm_segmentation.sql` for the full query.

## Power BI Dashboard

A 3-page interactive dashboard connected directly to the Chinook MySQL database.

**Page 1 — Overview:** KPI cards (Total Revenue, Avg Order Value, Total Customers), monthly revenue trend line, revenue-by-country map, with country and date-range slicers.

**Page 2 — Customer Insights:** RFM-based customer segmentation (Champions, Loyal Customers, At Risk, Lost) as an interactive donut chart that cross-filters a top-customer table and revenue-by-country breakdown.

**Page 3 — Product & Genre Performance:** Revenue by genre, top 10 tracks by revenue, filterable by a genre slicer.

📁 [Download the .pbix file](chinook_dashboard.pbix)

## Related Projects

Part of a broader portfolio spanning ML, deep learning, and analytics:
- [ITSM Incident ML Prediction](https://github.com/Mythili-Pandiyarajan/ITSM-Incident-ML-Prediction)
- [Employee Performance Prediction](https://github.com/Mythili-Pandiyarajan/employee-performance-prediction)
- [Skin Disorder Prediction](https://github.com/Mythili-Pandiyarajan/skin-disorder-prediction-ml)
