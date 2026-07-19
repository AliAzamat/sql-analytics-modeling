-- A check query SELECTS the bad rows. Zero rows back = the check passes.
-- Duplicate order_ids would double-count revenue — catch them here.
SELECT order_id, COUNT(*) AS n
FROM fct_orders
GROUP BY order_id
HAVING COUNT(*) > 1;
