-- Head vote accuracy for slots surrounding the orphaned block at slot 13505944
SELECT
    slot,
    COUNT() AS total_attestations,
    countIf(slot_distance = 0) AS correct_head_votes,
    round(countIf(slot_distance = 0) * 100.0 / COUNT(), 2) AS head_accuracy_pct
FROM mainnet.fct_attestation_correctness_by_validator_head FINAL
WHERE slot BETWEEN 13505940 AND 13505950
  AND slot_start_date_time >= '2026-01-20'
  AND slot_start_date_time < '2026-01-21'
GROUP BY slot
ORDER BY slot ASC
