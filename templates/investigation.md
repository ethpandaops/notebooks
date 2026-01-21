---
title: __TITLE__
sidebar_position: 1
description: __DESCRIPTION__
date: __DATE__
author: __AUTHOR__
tags:
  - __TAG__
---

<script>
    import PageMeta from '$lib/PageMeta.svelte';
    import Section from '$lib/Section.svelte';
    import SqlSource from '$lib/SqlSource.svelte';
</script>

<PageMeta
    date="__DATE__"
    author="__AUTHOR__"
    tags={["__TAG__"]}
    description="__DESCRIPTION__"
    networks={["Ethereum Mainnet"]}
    startTime="__START_TIME__"
    endTime="__END_TIME__"
/>

```sql example_query
select * from xatu_cbt.__SLUG___example
```

<Section type="question">

## Question

__QUESTION__

</Section>

<Section type="background">

## Background

__BACKGROUND__

</Section>

<Section type="investigation">

## Investigation

### Section Title

__INVESTIGATION__

<SqlSource source="xatu_cbt" query="__SLUG___example" />

<LineChart
    data={example_query}
    x="x_column"
    y="y_column"
    series="series_column"
    title="Chart Title"
    yFmt="num2"
    chartAreaHeight=400
    markers=true
    markerSize=6
    lineWidth=2
    echartsOptions={{
        title: {left: 'center'},
        grid: {bottom: 50, left: 70, top: 60, right: 30},
        xAxis: {name: 'X Axis Label', nameLocation: 'center', nameGap: 35},
        yAxis: {min: 0},
        graphic: [{
            type: 'text',
            left: 15,
            top: 'center',
            rotation: Math.PI / 2,
            style: {
                text: 'Y Axis Label',
                fontSize: 12,
                fill: '#666'
            }
        }]
    }}
/>

</Section>

<Section type="takeaways">

## Takeaways

- __TAKEAWAY_1__
- __TAKEAWAY_2__

</Section>
