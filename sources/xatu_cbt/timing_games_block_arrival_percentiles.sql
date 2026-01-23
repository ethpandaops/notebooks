SELECT
    quantile(0.05)(seen_slot_start_diff) / 1000.0 AS p5_seconds,
    quantile(0.50)(seen_slot_start_diff) / 1000.0 AS p50_seconds,
    quantile(0.95)(seen_slot_start_diff) / 1000.0 AS p95_seconds,
    count() AS total_blocks
FROM mainnet.fct_block_first_seen_by_node FINAL
WHERE slot_start_date_time >= '2026-01-13' AND slot_start_date_time < '2026-01-21'
