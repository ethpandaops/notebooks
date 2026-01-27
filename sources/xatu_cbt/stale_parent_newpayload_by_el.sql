-- newPayload execution duration by EL client for slot 13505944
SELECT
    meta_execution_implementation AS el_client,
    avg_duration_ms,
    max_duration_ms,
    observation_count
FROM mainnet.fct_engine_new_payload_by_el_client FINAL
WHERE slot = 13505944
  AND slot_start_date_time >= '2026-01-20'
  AND slot_start_date_time < '2026-01-21'
ORDER BY avg_duration_ms DESC
