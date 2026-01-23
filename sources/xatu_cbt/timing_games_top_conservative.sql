WITH min_arrival_per_slot AS (
    SELECT
        slot,
        MIN(seen_slot_start_diff) AS min_arrival_ms
    FROM mainnet.fct_block_first_seen_by_node FINAL
    WHERE slot_start_date_time >= '2026-01-13' AND slot_start_date_time < '2026-01-21'
    GROUP BY slot
),
slot_with_entity AS (
    SELECT
        p.slot,
        COALESCE(p.entity, 'unknown') AS entity,
        m.min_arrival_ms
    FROM mainnet.fct_block_proposer_entity p FINAL
    INNER JOIN min_arrival_per_slot m ON p.slot = m.slot
    WHERE p.slot_start_date_time >= '2026-01-13' AND p.slot_start_date_time < '2026-01-21'
),
entity_stats AS (
    SELECT
        entity,
        COUNT() AS block_count,
        median(min_arrival_ms) / 1000.0 AS median_arrival_seconds
    FROM slot_with_entity
    GROUP BY entity
    HAVING block_count >= 10
),
global_stats AS (
    SELECT
        avg(median_arrival_seconds) AS mean_arrival,
        stddevPop(median_arrival_seconds) AS std_arrival
    FROM entity_stats
)
SELECT
    e.entity,
    e.block_count,
    round(e.median_arrival_seconds, 3) AS arrival_seconds,
    round((e.median_arrival_seconds - g.mean_arrival) / g.std_arrival, 2) AS z_score
FROM entity_stats e
CROSS JOIN global_stats g
WHERE (e.median_arrival_seconds - g.mean_arrival) / g.std_arrival < 0
ORDER BY z_score ASC
LIMIT 20
