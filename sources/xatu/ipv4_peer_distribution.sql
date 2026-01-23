-- Distribution of max concurrent peer_ids per IPv4 address (Jan 16-23, 2026)
-- Uses hourly snapshots to measure actual concurrent peers, not cumulative churn
WITH per_hour AS (
    SELECT
        remote_ip,
        toStartOfHour(event_date_time) AS hour,
        countDistinct(remote_peer_id_unique_key) AS peers_this_hour
    FROM libp2p_synthetic_heartbeat
    WHERE meta_network_name = 'mainnet'
      AND event_date_time >= '2026-01-16 00:00:00'
      AND event_date_time < '2026-01-23 00:00:00'
      AND remote_ip IS NOT NULL
    GROUP BY remote_ip, hour
)
SELECT
    max_concurrent_peers AS "Peer IDs",
    count() AS "IP Count"
FROM (
    SELECT
        remote_ip,
        max(peers_this_hour) AS max_concurrent_peers
    FROM per_hour
    GROUP BY remote_ip
)
GROUP BY max_concurrent_peers
ORDER BY max_concurrent_peers ASC
