-- Parent distance distribution by entity group (all blocks with distance > 1)
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
),
flagged AS (
    SELECT
        bp.*,
        bp.parent_distance > 1 AND lc.latest_canonical_slot > bp.parent_slot AS is_truly_stale
    FROM blocks_with_parent bp
    LEFT JOIN latest_canonical lc
        ON bp.proposed_slot = lc.proposed_slot AND bp.parent_slot = lc.parent_slot
)
SELECT
    CASE
        WHEN e.entity = 'solo_stakers' THEN 'Solo Stakers'
        WHEN e.entity = 'rocketpool' THEN 'Rocket Pool'
        WHEN e.entity LIKE 'csm_operator%_lido' THEN 'Lido CSM'
        WHEN e.entity LIKE '%_lido' OR e.entity = 'lido' THEN 'Lido Professional'
        WHEN e.entity IS NULL THEN 'Unknown'
        ELSE 'Other'
    END AS entity_group,
    f.parent_distance,
    count() AS total_blocks,
    countIf(is_truly_stale) AS truly_stale_blocks,
    countIf(f.status = 'orphaned') AS orphaned_blocks
FROM flagged f
LEFT JOIN mainnet.fct_block_proposer_entity e FINAL
    ON f.proposed_slot = e.slot
WHERE f.parent_distance > 1
GROUP BY entity_group, f.parent_distance
ORDER BY entity_group, f.parent_distance
