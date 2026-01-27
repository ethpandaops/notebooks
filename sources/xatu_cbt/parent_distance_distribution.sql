-- Distribution of parent distances for ALL proposed blocks (canonical + orphaned)
-- Separates "missed slots" (benign) from "truly stale" (proposer was behind)
-- Fixed time window: 2025-10-27 to 2026-01-27 (3 months)
WITH blocks_with_parent AS (
    SELECT
        b.slot AS proposed_slot,
        p.slot AS parent_slot,
        b.slot - p.slot AS parent_distance,
        b.status
    FROM mainnet.fct_block b FINAL
    INNER JOIN mainnet.fct_block p FINAL
        ON b.parent_root = p.block_root
    WHERE b.slot_start_date_time >= '2025-10-27 00:00:00'
      AND b.slot_start_date_time < '2026-01-27 00:00:00'
      AND p.slot_start_date_time >= '2025-10-01 00:00:00'
),
-- For blocks with distance > 1, find the latest canonical block before proposed_slot
-- If it's newer than parent_slot, the proposer missed real blocks (truly stale)
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
    bp.parent_distance,
    count() AS block_count,
    countIf(bp.status = 'canonical') AS canonical,
    countIf(bp.status = 'orphaned') AS orphaned,
    round(countIf(bp.status = 'orphaned') * 100.0 / count(), 2) AS orphan_rate_pct,
    countIf(bp.parent_distance = 1 OR lc.latest_canonical_slot > bp.parent_slot) AS truly_stale_or_normal,
    countIf(bp.parent_distance > 1 AND (lc.latest_canonical_slot IS NULL OR lc.latest_canonical_slot = bp.parent_slot)) AS missed_slots_only,
    round(count() * 100.0 / sum(count()) OVER (), 4) AS pct
FROM blocks_with_parent bp
LEFT JOIN latest_canonical lc
    ON bp.proposed_slot = lc.proposed_slot AND bp.parent_slot = lc.parent_slot
GROUP BY bp.parent_distance
ORDER BY bp.parent_distance
