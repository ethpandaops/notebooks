WITH min_arrival AS (
    SELECT
        slot,
        MIN(seen_slot_start_diff) / 1000.0 AS arrival_seconds
    FROM mainnet.fct_block_first_seen_by_node FINAL
    WHERE slot_start_date_time >= '2026-01-13' AND slot_start_date_time < '2026-01-21'
    GROUP BY slot
    HAVING arrival_seconds > 2.0
)
SELECT
    COALESCE(p.entity, 'unknown') AS entity,
    count() AS late_block_count,
    round(avg(m.arrival_seconds), 3) AS avg_arrival_seconds
FROM mainnet.fct_block_proposer_entity p FINAL
INNER JOIN min_arrival m ON p.slot = m.slot
WHERE p.slot_start_date_time >= '2026-01-13' AND p.slot_start_date_time < '2026-01-21'
GROUP BY entity
ORDER BY late_block_count DESC
LIMIT 15
