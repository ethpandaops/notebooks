WITH min_arrival AS (
    SELECT
        slot,
        MIN(seen_slot_start_diff) / 1000.0 AS arrival_seconds
    FROM mainnet.fct_block_first_seen_by_node FINAL
    WHERE slot_start_date_time >= now() - INTERVAL 6 HOUR
    GROUP BY slot
    HAVING arrival_seconds > 2.0
)
SELECT
    p.slot,
    p.slot_start_date_time,
    COALESCE(p.entity, 'unknown') AS entity,
    m.arrival_seconds
FROM mainnet.fct_block_proposer_entity p FINAL
INNER JOIN min_arrival m ON p.slot = m.slot
WHERE p.slot_start_date_time >= now() - INTERVAL 6 HOUR
ORDER BY p.slot_start_date_time DESC
LIMIT 50
