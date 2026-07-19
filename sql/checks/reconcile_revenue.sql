-- Reconciliation: the mart's revenue must equal the raw source's revenue.
-- If these differ, a join or filter is silently dropping or duplicating money.
SELECT
    (SELECT SUM(amount) FROM raw.orders WHERE status = 'paid')      AS source_revenue,
    (SELECT SUM(revenue) FROM mart_revenue)                         AS mart_revenue,
    (SELECT SUM(amount) FROM raw.orders WHERE status = 'paid')
      - (SELECT SUM(revenue) FROM mart_revenue)                     AS difference;
