---
title: Timing Games
sidebar_position: 1
---

<script>
    import SqlSource from '$lib/SqlSource.svelte';
</script>

```sql block_arrival_percentiles
select * from xatu_cbt.timing_games_block_arrival_percentiles
```

```sql arrival_by_consensus_client
select * from xatu_cbt.timing_games_arrival_by_consensus_client
```

```sql recent_late_blocks
select * from xatu_cbt.timing_games_recent_late_blocks
```

```sql timing_distribution
select * from xatu_cbt.timing_games_timing_distribution
```

```sql late_blocks_by_entity
select * from xatu_cbt.timing_games_late_blocks_by_entity
```

## Block arrival stats (last hour)

<BigValue
    data={block_arrival_percentiles}
    value="p5_seconds"
    title="P5"
    fmt="num2"
    suffix="s"
/>

<BigValue
    data={block_arrival_percentiles}
    value="p50_seconds"
    title="P50 (median)"
    fmt="num2"
    suffix="s"
/>

<BigValue
    data={block_arrival_percentiles}
    value="p95_seconds"
    title="P95"
    fmt="num2"
    suffix="s"
/>

<BigValue
    data={block_arrival_percentiles}
    value="total_blocks"
    title="Blocks"
    fmt="num0"
/>

## Median arrival by consensus client

<BarChart
    data={arrival_by_consensus_client}
    x="consensus_client"
    y="median_arrival_seconds"
    yAxisTitle="seconds"
/>

## Arrival time distribution (last hour)

<BarChart
    data={timing_distribution}
    x="timing_bucket"
    y="block_count"
    xAxisTitle="Time after slot start"
    yAxisTitle="Blocks"
/>

## Late blocks by entity (last 6 hours)

Blocks arriving >2s after slot start.

<BarChart
    data={late_blocks_by_entity}
    x="entity"
    y="late_block_count"
    yAxisTitle="Late blocks"
/>

## Recent late blocks

<DataTable
    data={recent_late_blocks}
    rows=20
>
    <Column id="slot" title="Slot" />
    <Column id="slot_start_date_time" title="Time" />
    <Column id="entity" title="Entity" />
    <Column id="arrival_seconds" title="Arrival (s)" fmt="num2" />
</DataTable>

## Queries

<SqlSource source="xatu_cbt" query="timing_games_block_arrival_percentiles" />
<SqlSource source="xatu_cbt" query="timing_games_arrival_by_consensus_client" />
<SqlSource source="xatu_cbt" query="timing_games_timing_distribution" />
<SqlSource source="xatu_cbt" query="timing_games_late_blocks_by_entity" />
<SqlSource source="xatu_cbt" query="timing_games_recent_late_blocks" />
