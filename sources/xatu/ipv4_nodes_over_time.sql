-- Distinct nodes (peer_ids) observed per day (Jan 16-23, 2026)
SELECT
    toDate(event_date_time) AS day,
    countDistinct(remote_peer_id_unique_key) AS "Distinct Nodes"
FROM libp2p_synthetic_heartbeat
WHERE meta_network_name = 'mainnet'
  AND event_date_time >= '2026-01-16 00:00:00'
  AND event_date_time < '2026-01-23 00:00:00'
  AND remote_ip IS NOT NULL
GROUP BY day
ORDER BY day ASC
