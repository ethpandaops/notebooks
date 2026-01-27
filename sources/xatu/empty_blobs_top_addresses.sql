-- Top addresses posting empty blobs with entity names
-- Fixed time window: 2026-01-16 to 2026-01-23
WITH submitter_names AS (
    SELECT DISTINCT
        lower(substring(toString(address), 1, 42)) AS address_clean,
        name
    FROM blob_submitter
    WHERE meta_network_name = 'mainnet'
)
SELECT
    t.`from` AS address,
    if(s.name IS NULL OR s.name = '', 'Unknown', s.name) AS entity,
    count() AS total_txs,
    sum(arrayCount(x -> x = '0x010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014', t.blob_hashes)) AS empty_blobs
FROM canonical_beacon_block_execution_transaction t
GLOBAL LEFT JOIN submitter_names s ON lower(t.`from`) = s.address_clean
WHERE t.meta_network_name = 'mainnet'
  AND t.slot_start_date_time >= '2026-01-16 00:00:00'
  AND t.slot_start_date_time < '2026-01-23 00:00:00'
  AND length(t.blob_hashes) > 0
  AND has(t.blob_hashes, '0x010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014')
GROUP BY address, entity
ORDER BY empty_blobs DESC
LIMIT 15
