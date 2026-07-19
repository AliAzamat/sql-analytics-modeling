-- One staging model per source table — here, customers.
SELECT
    customer_id,
    name,
    region,
    LOWER(tier) AS tier              -- standardize: 'SMB' / 'Smb' → 'smb'
FROM raw.customers
WHERE customer_id IS NOT NULL;
