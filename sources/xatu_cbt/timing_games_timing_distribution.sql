SELECT
    CASE
        WHEN seen_slot_start_diff / 1000.0 < 0.5 THEN '0-0.5s'
        WHEN seen_slot_start_diff / 1000.0 < 1.0 THEN '0.5-1s'
        WHEN seen_slot_start_diff / 1000.0 < 1.5 THEN '1-1.5s'
        WHEN seen_slot_start_diff / 1000.0 < 2.0 THEN '1.5-2s'
        WHEN seen_slot_start_diff / 1000.0 < 2.5 THEN '2-2.5s'
        WHEN seen_slot_start_diff / 1000.0 < 3.0 THEN '2.5-3s'
        ELSE '3s+'
    END AS timing_bucket,
    CASE
        WHEN seen_slot_start_diff / 1000.0 < 0.5 THEN 1
        WHEN seen_slot_start_diff / 1000.0 < 1.0 THEN 2
        WHEN seen_slot_start_diff / 1000.0 < 1.5 THEN 3
        WHEN seen_slot_start_diff / 1000.0 < 2.0 THEN 4
        WHEN seen_slot_start_diff / 1000.0 < 2.5 THEN 5
        WHEN seen_slot_start_diff / 1000.0 < 3.0 THEN 6
        ELSE 7
    END AS bucket_order,
    count() AS block_count
FROM mainnet.fct_block_first_seen_by_node FINAL
WHERE slot_start_date_time >= now() - INTERVAL 1 HOUR
GROUP BY timing_bucket, bucket_order
ORDER BY bucket_order ASC
