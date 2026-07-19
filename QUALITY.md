# Data-quality checks

A check is just a SELECT. Two conventions:

- **Violation queries** select the BAD rows — duplicates, orphans, NULLs.
  An empty result means the check passes. Wire these into CI.
- **Reconciliation** compares an independent total (the raw source) against
  the modeled total. A non-zero `difference` means money was lost or
  duplicated by a join/filter — the most dangerous bug in analytics.

## What we guard here
- `duplicates.sql` — no order is counted twice.
- `orphan_customers.sql` — every order references a real customer (INNER-join safety).
- `reconcile_revenue.sql` — modeled revenue == source revenue, to the cent.

These same checks become first-class dbt tests in the next project.
