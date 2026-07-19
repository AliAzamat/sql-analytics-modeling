-- Rewritten as a CTE PIPELINE: each WITH block is a named, readable step.
-- Read top-to-bottom like a recipe instead of one tangled SELECT.
WITH valid_orders AS (
    -- Step 1: keep only rows we trust enough to report on.
    SELECT * FROM orders WHERE amount IS NOT NULL
),
enriched AS (
    -- Step 2: attach customer and product context.
    SELECT
        o.order_id,
        o.amount,
        o.status,
        o.ordered_at,
        c.name      AS customer_name,
        c.region    AS region,
        c.tier      AS customer_tier,
        -- COALESCE turns a missing product category into a real label.
        COALESCE(p.category, 'unknown') AS product_category
    FROM valid_orders o
    INNER JOIN customers c ON c.customer_id = o.customer_id
    LEFT  JOIN products  p ON p.product_id  = o.product_id
)
SELECT * FROM enriched;
