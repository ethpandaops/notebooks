WITH slot_timing AS (
    SELECT
        slot,
        MIN(seen_slot_start_diff) / 1000.0 AS arrival_seconds
    FROM mainnet.fct_block_first_seen_by_node FINAL
    WHERE slot_start_date_time >= now() - INTERVAL 1 WEEK
    GROUP BY slot
),
entity_stats AS (
    SELECT
        COALESCE(p.entity, 'unknown') AS entity,
        median(t.arrival_seconds) AS median_arrival_seconds
    FROM mainnet.fct_block_proposer_entity p FINAL
    INNER JOIN slot_timing t ON p.slot = t.slot
    WHERE p.slot_start_date_time >= now() - INTERVAL 1 WEEK
    GROUP BY entity
),
global_stats AS (
    SELECT
        avg(median_arrival_seconds) AS mean_arrival,
        stddevPop(median_arrival_seconds) AS std_arrival
    FROM entity_stats
),
entity_classification AS (
    SELECT
        e.entity,
        CASE
            WHEN (e.median_arrival_seconds - g.mean_arrival) / g.std_arrival < 0 THEN 'Conservative'
            WHEN (e.median_arrival_seconds - g.mean_arrival) / g.std_arrival <= 2 THEN 'Neutral'
            ELSE 'Suspect'
        END AS classification
    FROM entity_stats e
    CROSS JOIN global_stats g
),
head_votes AS (
    SELECT
        h.slot,
        p.entity,
        h.votes_head,
        h.votes_max,
        COALESCE(b.blob_count, 0) AS blob_count
    FROM mainnet.fct_attestation_correctness_head h FINAL
    INNER JOIN mainnet.fct_block_proposer_entity p FINAL ON h.slot = p.slot
    LEFT JOIN mainnet.fct_block_blob_count_head b FINAL ON h.slot = b.slot
    WHERE h.slot_start_date_time >= now() - INTERVAL 1 WEEK
      AND h.votes_head IS NOT NULL
)
SELECT
    c.classification,
    hv.blob_count,
    round(100.0 * sum(hv.votes_head) / sum(hv.votes_max), 2) AS head_vote_percentage,
    sum(hv.votes_max) AS total_attestations
FROM head_votes hv
INNER JOIN entity_classification c ON hv.entity = c.entity
GROUP BY c.classification, hv.blob_count
ORDER BY
    CASE c.classification
        WHEN 'Conservative' THEN 1
        WHEN 'Neutral' THEN 2
        WHEN 'Suspect' THEN 3
    END,
    hv.blob_count
