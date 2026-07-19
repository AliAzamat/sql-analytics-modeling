-- STAGING: light cleanup only — rename, cast, standardize. One staging
-- model per source table. No business logic, no joins. This is the clean,
-- trusted starting point everything else builds on.
SELECT
    order_id,
    customer_id,
    product_id,
    CAST(amount AS REAL)         AS amount,
    LOWER(status)                AS status,        -- standardize casing
    DATE(ordered_at)             AS ordered_date   -- cast text → date
FROM raw.orders
WHERE amount IS NOT NULL;                          -- drop corrupt rows early
