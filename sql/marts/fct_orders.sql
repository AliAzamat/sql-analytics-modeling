-- A FACT table: one row per business event (an order), with measures
-- (amount) and foreign keys to dimensions (customer_id). This is the
-- center of a STAR SCHEMA — facts in the middle, dimensions around it.
SELECT
    o.order_id,
    o.customer_id,                   -- FK → dim_customers
    o.amount,
    o.status,
    o.ordered_date,
    d.region,                        -- pulled from the dimension
    d.segment                        -- the SAME segment every mart sees
FROM stg_orders o
INNER JOIN dim_customers d ON d.customer_id = o.customer_id;
