WITH min_arrival_per_slot AS (
    SELECT
        slot,
        MIN(seen_slot_start_diff) AS min_arrival_ms
    FROM mainnet.fct_block_first_seen_by_node FINAL
    WHERE slot_start_date_time >= now() - INTERVAL 1 WEEK
    GROUP BY slot
),
slot_with_entity AS (
    SELECT
        p.slot,
        COALESCE(p.entity, 'unknown') AS entity,
        m.min_arrival_ms
    FROM mainnet.fct_block_proposer_entity p FINAL
    INNER JOIN min_arrival_per_slot m ON p.slot = m.slot
    WHERE p.slot_start_date_time >= now() - INTERVAL 1 WEEK
),
entity_stats AS (
    SELECT
        entity,
        COUNT() AS block_count,
        median(min_arrival_ms) / 1000.0 AS median_arrival_seconds
    FROM slot_with_entity
    GROUP BY entity
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
    round((e.median_arrival_seconds - g.mean_arrival) / g.std_arrival, 2) AS z_score,
    CASE
        WHEN (e.median_arrival_seconds - g.mean_arrival) / g.std_arrival < 0 THEN 'Conservative'
        WHEN (e.median_arrival_seconds - g.mean_arrival) / g.std_arrival <= 2 THEN 'Neutral'
        ELSE 'Suspect'
    END AS classification
FROM entity_stats e
CROSS JOIN global_stats g
ORDER BY z_score DESC
