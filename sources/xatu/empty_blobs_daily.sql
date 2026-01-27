-- Daily empty blob counts with total blob counts for context
-- Fixed time window: 2026-01-16 to 2026-01-23
SELECT
    toDate(slot_start_date_time) AS day,
    sum(length(blob_hashes)) AS "Total Blobs",
    sum(arrayCount(x -> x = '0x010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014', blob_hashes)) AS "Empty Blobs",
    round(sum(arrayCount(x -> x = '0x010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014', blob_hashes)) * 100.0 / sum(length(blob_hashes)), 2) AS "Empty Blob %"
FROM canonical_beacon_block_execution_transaction
WHERE meta_network_name = 'mainnet'
  AND slot_start_date_time >= '2026-01-16 00:00:00'
  AND slot_start_date_time < '2026-01-23 00:00:00'
  AND length(blob_hashes) > 0
GROUP BY day
ORDER BY day ASC
