WITH min_arrival_per_slot AS (
    SELECT
        slot,
        MIN(seen_slot_start_diff) AS min_arrival_ms
    FROM mainnet.fct_block_first_seen_by_node FINAL
    WHERE slot_start_date_time >= '2026-01-13' AND slot_start_date_time < '2026-01-21'
    GROUP BY slot
),
entity_stats AS (
    SELECT
        COALESCE(p.entity, 'unknown') AS entity,
        COUNT() AS block_count,
        median(m.min_arrival_ms) / 1000.0 AS median_arrival_seconds
    FROM mainnet.fct_block_proposer_entity p FINAL
    INNER JOIN min_arrival_per_slot m ON p.slot = m.slot
    WHERE p.slot_start_date_time >= '2026-01-13' AND p.slot_start_date_time < '2026-01-21'
    GROUP BY entity
),
global_stats AS (
    SELECT
        avg(median_arrival_seconds) AS mean_arrival,
        stddevPop(median_arrival_seconds) AS std_arrival
    FROM entity_stats
),
classified AS (
    SELECT
        e.entity,
        e.block_count,
        e.median_arrival_seconds,
        CASE
            WHEN (e.median_arrival_seconds - g.mean_arrival) / g.std_arrival < 0 THEN 'Conservative'
            WHEN (e.median_arrival_seconds - g.mean_arrival) / g.std_arrival <= 2 THEN 'Neutral'
            ELSE 'Suspect'
        END AS classification
    FROM entity_stats e
    CROSS JOIN global_stats g
)
SELECT
    classification,
    count() AS entity_count,
    sum(block_count) AS total_blocks,
    round(avg(median_arrival_seconds), 3) AS avg_arrival_seconds
FROM classified
GROUP BY classification
ORDER BY
    CASE classification
        WHEN 'Conservative' THEN 1
        WHEN 'Neutral' THEN 2
        WHEN 'Suspect' THEN 3
    END
