-- Roll enriched orders up to one row per region per day.
SELECT
    region,
    ordered_at                          AS day,
    SUM(amount)                         AS revenue,
    COUNT(*)                            AS order_count,
    AVG(amount)                         AS avg_order_value
FROM enriched_orders
WHERE status = 'paid'
GROUP BY region, ordered_at;
