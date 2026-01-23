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
),
global_stats AS (
    SELECT
        avg(median_arrival_seconds) AS mean_arrival,
        stddevPop(median_arrival_seconds) AS std_arrival
    FROM entity_stats
),
scored AS (
    SELECT
        (e.median_arrival_seconds - g.mean_arrival) / g.std_arrival AS z_score
    FROM entity_stats e
    CROSS JOIN global_stats g
)
SELECT
    CASE
        WHEN z_score < -2 THEN 'z < -2'
        WHEN z_score < -1 THEN '-2 ≤ z < -1'
        WHEN z_score < 0 THEN '-1 ≤ z < 0'
        WHEN z_score < 1 THEN '0 ≤ z < 1'
        WHEN z_score < 2 THEN '1 ≤ z < 2'
        WHEN z_score < 3 THEN '2 ≤ z < 3'
        ELSE 'z ≥ 3'
    END AS score_bucket,
    CASE
        WHEN z_score < -2 THEN 1
        WHEN z_score < -1 THEN 2
        WHEN z_score < 0 THEN 3
        WHEN z_score < 1 THEN 4
        WHEN z_score < 2 THEN 5
        WHEN z_score < 3 THEN 6
        ELSE 7
    END AS bucket_order,
    count() AS entity_count
FROM scored
GROUP BY score_bucket, bucket_order
ORDER BY bucket_order ASC
