SELECT
    meta_consensus_implementation AS consensus_client,
    quantile(0.50)(seen_slot_start_diff) / 1000.0 AS median_arrival_seconds,
    count() AS sample_count
FROM mainnet.fct_block_first_seen_by_node FINAL
WHERE slot_start_date_time >= now() - INTERVAL 1 HOUR
GROUP BY meta_consensus_implementation
ORDER BY median_arrival_seconds ASC
