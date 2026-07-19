-- Window functions compute a value ACROSS a set of rows related to the
-- current row — WITHOUT collapsing them the way GROUP BY does.
WITH daily AS (
    SELECT region,
           ordered_at AS day,
           SUM(amount) AS daily_revenue
    FROM enriched_orders
    WHERE status = 'paid'
    GROUP BY region, ordered_at
)
SELECT
    region,
    day,
    daily_revenue,
    -- Running total of revenue within each region, ordered by day.
    SUM(daily_revenue) OVER (
        PARTITION BY region ORDER BY day
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue,
    -- 3-day moving average: smooth out daily noise to see the trend.
    AVG(daily_revenue) OVER (
        PARTITION BY region ORDER BY day
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3d,
    -- Each day's SHARE of its region's total revenue (a window WITHOUT order).
    daily_revenue * 1.0 / SUM(daily_revenue) OVER (PARTITION BY region) AS pct_of_region,
    -- Bucket days into quartiles by revenue within the region.
    NTILE(4) OVER (PARTITION BY region ORDER BY daily_revenue) AS revenue_quartile
FROM daily;
