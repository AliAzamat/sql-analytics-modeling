-- A DIMENSION: descriptive attributes about an entity, one row per customer.
-- Facts (orders) reference dimensions to gain context without re-storing it.
SELECT
    customer_id,                     -- natural key: stable id from the source
    name,
    region,
    tier,
    -- A derived attribute: a tier-based segment label, defined ONCE here.
    CASE tier
        WHEN 'enterprise' THEN 'strategic'
        WHEN 'mid'        THEN 'growth'
        ELSE                   'self-serve'
    END                              AS segment
FROM stg_customers;
