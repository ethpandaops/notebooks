-- Distinct nodes per hour by client type (Jan 16-23, 2026)
SELECT
    if(toHour(toStartOfHour(event_date_time)) = 0,
       formatDateTime(toStartOfHour(event_date_time), '%m-%d'),
       '') AS hour,
    remote_agent_implementation AS client,
    countDistinct(remote_peer_id_unique_key) AS nodes
FROM libp2p_synthetic_heartbeat
WHERE meta_network_name = 'mainnet'
  AND event_date_time >= '2026-01-16 00:00:00'
  AND event_date_time < '2026-01-23 00:00:00'
  AND remote_ip IS NOT NULL
  AND remote_agent_implementation != ''
GROUP BY toStartOfHour(event_date_time), client
ORDER BY toStartOfHour(event_date_time) ASC, client ASC
