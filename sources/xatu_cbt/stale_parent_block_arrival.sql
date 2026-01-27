-- Block arrival time by CL client for slot 13505944
SELECT
    meta_consensus_implementation AS cl_client,
    MIN(seen_slot_start_diff) AS min_arrival_ms,
    round(quantile(0.50)(seen_slot_start_diff)) AS p50_arrival_ms,
    MAX(seen_slot_start_diff) AS max_arrival_ms,
    COUNT() AS node_count
FROM mainnet.fct_block_first_seen_by_node FINAL
WHERE slot = 13505944
  AND slot_start_date_time >= '2026-01-20'
  AND slot_start_date_time < '2026-01-21'
  AND meta_consensus_implementation != ''
GROUP BY cl_client
ORDER BY p50_arrival_ms ASC
