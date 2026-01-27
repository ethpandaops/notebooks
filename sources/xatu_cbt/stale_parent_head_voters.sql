-- Who voted for the orphaned block at slot 13505944?
SELECT
    COALESCE(d.source, 'unknown') AS entity,
    COUNT(DISTINCT a.attesting_validator_index) AS validator_count
FROM mainnet.fct_attestation_correctness_by_validator_head AS a
LEFT JOIN mainnet.dim_node AS d ON a.attesting_validator_index = d.validator_index
WHERE a.slot = 13505944
  AND a.slot_start_date_time >= '2026-01-20'
  AND a.slot_start_date_time < '2026-01-21'
  AND a.slot_distance = 0
GROUP BY entity
ORDER BY validator_count DESC
