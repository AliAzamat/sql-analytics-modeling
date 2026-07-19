-- Group by MONTH by truncating the date to its first day.
-- strftime('%Y-%m', day) gives 'YYYY-MM' — a clean monthly bucket key.
SELECT
    region,
    strftime('%Y-%m', ordered_at)       AS month,
    SUM(amount)                         AS revenue,
    COUNT(DISTINCT order_id)            AS orders
FROM enriched_orders
WHERE status = 'paid'
GROUP BY region, strftime('%Y-%m', ordered_at);
