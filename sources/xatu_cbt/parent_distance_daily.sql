-- Daily trend of truly stale parent blocks (excludes benign missed-slot cases)
-- Fixed time window: 2025-10-27 to 2026-01-27 (3 months)
WITH blocks_with_parent AS (
    SELECT
        b.slot AS proposed_slot,
        p.slot AS parent_slot,
        b.slot - p.slot AS parent_distance,
        b.status,
        b.slot_start_date_time
    FROM mainnet.fct_block b FINAL
    INNER JOIN mainnet.fct_block p FINAL
        ON b.parent_root = p.block_root
    WHERE b.slot_start_date_time >= '2025-10-27 00:00:00'
      AND b.slot_start_date_time < '2026-01-27 00:00:00'
      AND p.slot_start_date_time >= '2025-10-01 00:00:00'
),
latest_canonical AS (
    SELECT
        bp.proposed_slot,
        bp.parent_slot,
        max(c.slot) AS latest_canonical_slot
    FROM blocks_with_parent bp
    INNER JOIN mainnet.fct_block c FINAL
        ON c.slot < bp.proposed_slot
        AND c.slot >= bp.parent_slot
        AND c.status = 'canonical'
        AND c.slot_start_date_time >= '2025-10-01 00:00:00'
    WHERE bp.parent_distance > 1
    GROUP BY bp.proposed_slot, bp.parent_slot
)
SELECT
    toDate(bp.slot_start_date_time) AS day,
    count() AS total_blocks,
    countIf(bp.parent_distance > 1 AND lc.latest_canonical_slot > bp.parent_slot) AS truly_stale_blocks,
    round(
        countIf(bp.parent_distance > 1 AND lc.latest_canonical_slot > bp.parent_slot) * 100.0 / count(),
        4
    ) AS truly_stale_pct,
    countIf(bp.status = 'orphaned' AND bp.parent_distance > 1 AND lc.latest_canonical_slot > bp.parent_slot) AS orphaned_truly_stale
FROM blocks_with_parent bp
LEFT JOIN latest_canonical lc
    ON bp.proposed_slot = lc.proposed_slot AND bp.parent_slot = lc.parent_slot
GROUP BY day
ORDER BY day
