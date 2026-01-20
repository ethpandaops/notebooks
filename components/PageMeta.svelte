<script>
    import { getAuthor } from './authors.js';

    export let date = '';
    export let author = '';
    export let tags = [];

    // Get author info
    $: authorInfo = author ? getAuthor(author) : null;

    // Format date for display
    function formatDate(dateStr) {
        if (!dateStr) return '';
        try {
            const d = new Date(dateStr);
            return d.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            });
        } catch (e) {
            return dateStr;
        }
    }

    // Ensure tags is an array
    $: tagList = Array.isArray(tags) ? tags : (tags ? tags.split(',').map(t => t.trim()) : []);
</script>

{#if date || authorInfo || tagList.length > 0}
<div class="page-meta">
    <div class="meta-left">
        {#if authorInfo}
        <a href={authorInfo.github} target="_blank" rel="noopener noreferrer" class="author">
            <img
                src={authorInfo.avatar}
                alt={authorInfo.name}
                class="avatar"
                loading="lazy"
            />
            <span class="author-name">{authorInfo.name}</span>
        </a>
        {/if}

        {#if date}
        <span class="date">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                <line x1="16" y1="2" x2="16" y2="6"></line>
                <line x1="8" y1="2" x2="8" y2="6"></line>
                <line x1="3" y1="10" x2="21" y2="10"></line>
            </svg>
            {formatDate(date)}
        </span>
        {/if}
    </div>

    {#if tagList.length > 0}
    <div class="tags">
        {#each tagList as tag}
        <span class="tag">{tag}</span>
        {/each}
    </div>
    {/if}
</div>
{/if}

<style>
    .page-meta {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: space-between;
        gap: 1rem;
        padding: 0.875rem 0;
        margin-bottom: 1.25rem;
        border-bottom: 1px solid var(--grey-200, #e5e5e5);
    }

    .meta-left {
        display: flex;
        align-items: center;
        gap: 1.25rem;
    }

    .author {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        text-decoration: none;
        color: inherit;
        transition: opacity 0.15s ease;
    }

    .author:hover {
        opacity: 0.8;
    }

    .avatar {
        width: 28px;
        height: 28px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid var(--grey-200, #e5e5e5);
    }

    .author-name {
        font-weight: 500;
        font-size: 0.875rem;
        color: var(--grey-800, #333);
    }

    .date {
        display: flex;
        align-items: center;
        gap: 0.375rem;
        font-size: 0.8125rem;
        color: var(--grey-500, #888);
    }

    .date svg {
        opacity: 0.6;
    }

    .tags {
        display: flex;
        flex-wrap: wrap;
        gap: 0.375rem;
    }

    .tag {
        display: inline-block;
        padding: 0.25rem 0.625rem;
        background: var(--grey-100, #f5f5f5);
        color: var(--grey-600, #666);
        border-radius: 100px;
        font-size: 0.6875rem;
        font-weight: 500;
        text-transform: lowercase;
        letter-spacing: 0.02em;
    }

    @media (max-width: 600px) {
        .page-meta {
            flex-direction: column;
            align-items: flex-start;
        }

        .tags {
            margin-top: 0.5rem;
        }
    }
</style>
