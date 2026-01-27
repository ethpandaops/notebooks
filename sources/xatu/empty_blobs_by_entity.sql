-- Empty blob submissions grouped by entity
-- An "empty blob" has versioned hash 0x010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014
-- which corresponds to the BLS12-381 G1 point-at-infinity KZG commitment
-- Fixed time window: 2026-01-16 to 2026-01-23
WITH submitter_names AS (
    SELECT DISTINCT
        lower(substring(toString(address), 1, 42)) AS address_clean,
        name
    FROM blob_submitter
    WHERE meta_network_name = 'mainnet'
),
empty_blob_senders AS (
    SELECT
        `from` AS sender_address,
        count() AS tx_count,
        sum(length(blob_hashes)) AS total_blobs,
        sum(arrayCount(x -> x = '0x010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014', blob_hashes)) AS empty_blobs
    FROM canonical_beacon_block_execution_transaction
    WHERE meta_network_name = 'mainnet'
      AND slot_start_date_time >= '2026-01-16 00:00:00'
      AND slot_start_date_time < '2026-01-23 00:00:00'
      AND length(blob_hashes) > 0
      AND has(blob_hashes, '0x010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014')
    GROUP BY sender_address
)
SELECT
    if(s.name IS NULL OR s.name = '', 'Unknown', s.name) AS entity,
    sum(e.tx_count) AS total_txs,
    sum(e.empty_blobs) AS empty_blobs,
    count() AS num_addresses
FROM empty_blob_senders e
GLOBAL LEFT JOIN submitter_names s ON lower(e.sender_address) = s.address_clean
GROUP BY entity
ORDER BY empty_blobs DESC
