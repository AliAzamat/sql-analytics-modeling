-- Referential integrity: every order must point at a real customer.
-- An order whose customer_id is missing from the dimension is an orphan.
SELECT o.order_id, o.customer_id
FROM fct_orders o
LEFT JOIN dim_customers d ON d.customer_id = o.customer_id
WHERE d.customer_id IS NULL;
