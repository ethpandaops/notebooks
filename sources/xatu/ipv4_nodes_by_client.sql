-- Distinct nodes per day by client type (Jan 16-23, 2026)
SELECT
    toDate(event_date_time) AS day,
    remote_agent_implementation AS client,
    countDistinct(remote_peer_id_unique_key) AS nodes
FROM libp2p_synthetic_heartbeat
WHERE meta_network_name = 'mainnet'
  AND event_date_time >= '2026-01-16 00:00:00'
  AND event_date_time < '2026-01-23 00:00:00'
  AND remote_ip IS NOT NULL
  AND remote_agent_implementation != ''
GROUP BY day, client
ORDER BY day ASC, client ASC
