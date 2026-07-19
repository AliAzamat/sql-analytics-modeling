# Analytics modeling layers

Data flows through layers, each with one job:

    raw  →  staging  →  marts  →  dashboards / AI

## staging (`sql/staging/`)
- One model per source table. Rename, cast, standardize, drop corrupt rows.
- NO joins, NO business logic. The clean, trusted base.

## marts (`sql/marts/`)
- Business-facing. Joins staged models and encodes agreed definitions
  (what "revenue" means, who is "enterprise").
- Dashboards, reports, and AI workflows read ONLY from marts.

## Why layer?
- **Single source of truth**: "revenue" is defined once, in `mart_revenue`.
- **Reusability**: every mart starts from the same clean staging models.
- **Trust**: a number on a dashboard traces back through a mart to a source.
