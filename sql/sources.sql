-- Source tables arrive NORMALIZED: facts and dimensions live apart so each
-- piece of data is stored once. Great for the app; awkward for analytics.
CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    name        TEXT NOT NULL,
    region      TEXT NOT NULL,
    tier        TEXT NOT NULL     -- 'smb' | 'mid' | 'enterprise'
);

CREATE TABLE products (
    product_id  TEXT PRIMARY KEY,
    name        TEXT NOT NULL,
    category    TEXT NOT NULL
);

CREATE TABLE orders (
    order_id    TEXT PRIMARY KEY,
    customer_id TEXT NOT NULL,    -- foreign key → customers
    product_id  TEXT NOT NULL,    -- foreign key → products
    amount      REAL NOT NULL,
    status      TEXT NOT NULL,    -- 'paid' | 'pending' | 'refunded'
    ordered_at  TEXT NOT NULL     -- ISO date
);
