-- MART: business-facing model. Joins staged sources and applies the
-- definitions executives agree on. Dashboards query MARTS, never raw tables.
WITH orders AS (SELECT * FROM stg_orders),
     customers AS (SELECT * FROM stg_customers)
SELECT
    c.region,
    c.tier            AS customer_tier,
    COUNT(*)          AS paid_orders,
    SUM(o.amount)     AS revenue          -- THE official revenue definition
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status = 'paid'
GROUP BY c.region, c.tier;
