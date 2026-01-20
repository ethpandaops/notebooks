<script>
    export let source = '';
    export let query = '';

    let sqlContent = '';
    let expanded = false;

    // Fetch the SQL file from the static folder
    async function loadSql() {
        try {
            const response = await fetch(`/notebooks/sql/${source}/${query}.sql`);
            if (response.ok) {
                sqlContent = await response.text();
            } else {
                sqlContent = `-- Could not load query: ${source}/${query}.sql`;
            }
        } catch (e) {
            sqlContent = `-- Error loading query: ${e.message}`;
        }
    }

    $: if (source && query) {
        loadSql();
    }
</script>

<details class="sql-source" bind:open={expanded}>
    <summary>
        <span class="toggle-icon">{expanded ? '▼' : '▶'}</span>
        View Query: {query}
    </summary>
    <pre class="sql-code"><code>{sqlContent}</code></pre>
</details>

<style>
    .sql-source {
        margin: 0.5rem 0 1rem 0;
        border: 1px solid var(--grey-300, #e0e0e0);
        border-radius: 4px;
        font-size: 0.875rem;
    }

    summary {
        padding: 0.5rem 0.75rem;
        cursor: pointer;
        background: var(--grey-100, #f5f5f5);
        font-family: monospace;
        list-style: none;
    }

    summary::-webkit-details-marker {
        display: none;
    }

    .toggle-icon {
        margin-right: 0.5rem;
        font-size: 0.75rem;
    }

    .sql-code {
        margin: 0;
        padding: 1rem;
        background: var(--grey-50, #fafafa);
        overflow-x: auto;
        font-size: 0.8125rem;
        line-height: 1.5;
    }

    code {
        font-family: 'SF Mono', Monaco, 'Cascadia Code', monospace;
    }
</style>
