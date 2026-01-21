<script>
    import { getAuthor } from './authors.js';

    export let date = '';
    export let author = '';
    export let authors = [];
    export let tags = [];
    export let description = '';
    export let networks = [];
    export let startTime = '';
    export let endTime = '';

    // Support both single author and multiple authors
    $: authorList = authors.length > 0
        ? authors
        : (author ? [author] : []);

    $: authorInfoList = authorList
        .map(a => getAuthor(a))
        .filter(a => a !== null);

    function formatDate(dateStr) {
        if (!dateStr) return '';
        try {
            const d = new Date(dateStr);
            return d.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
        } catch (e) {
            return dateStr;
        }
    }

    $: tagList = Array.isArray(tags) ? tags : (tags ? tags.split(',').map(t => t.trim()) : []);
    $: networkList = Array.isArray(networks) ? networks : (networks ? networks.split(',').map(n => n.trim()) : []);

    const tagColors = [
        'bg-primary/15 text-primary',
        'bg-info/15 text-info',
        'bg-positive/15 text-positive',
        'bg-warning/15 text-warning',
        'bg-accent/15 text-accent',
    ];

    function getTagColor(tag) {
        const hash = tag.split('').reduce((acc, char) => acc + char.charCodeAt(0), 0);
        return tagColors[hash % tagColors.length];
    }
</script>

{#if date || authorInfoList.length > 0 || tagList.length > 0 || description || networkList.length > 0 || startTime || endTime}
<div class="relative -mx-4 px-4 pt-6 pb-8 mb-8 bg-base-200/50 border-y border-base-300">
    <div class="grid grid-cols-12 gap-8">
        <!-- Left column: 9 cols -->
        <div class="col-span-12 lg:col-span-9">
            {#if description}
            <p class="text-lg/7 text-base-content/80 max-w-2xl mb-5">
                {description}
            </p>
            {/if}

            {#if networkList.length > 0 || startTime || endTime}
            <div class="flex flex-wrap items-center gap-6 mb-5 text-sm">
                {#if networkList.length > 0}
                <div class="flex items-center gap-2">
                    <span class="text-base-content-muted">Networks:</span>
                    <div class="flex flex-wrap gap-1.5">
                        {#each networkList as network}
                        <span class="inline-flex px-2 py-0.5 bg-base-100 border border-base-300 rounded text-xs font-medium text-base-content">
                            {network}
                        </span>
                        {/each}
                    </div>
                </div>
                {/if}
                {#if startTime || endTime}
                <div class="flex items-center gap-4">
                    <span class="text-base-content-muted">Time range:</span>
                    {#if startTime}
                    <div class="flex items-center gap-1.5">
                        <span class="text-xs text-base-content-muted">Start</span>
                        <span class="inline-flex px-2 py-0.5 bg-base-100 border border-base-300 rounded text-xs font-mono text-base-content">
                            {startTime}
                        </span>
                    </div>
                    {/if}
                    {#if endTime}
                    <div class="flex items-center gap-1.5">
                        <span class="text-xs text-base-content-muted">End</span>
                        <span class="inline-flex px-2 py-0.5 bg-base-100 border border-base-300 rounded text-xs font-mono text-base-content">
                            {endTime}
                        </span>
                    </div>
                    {/if}
                </div>
                {/if}
            </div>
            {/if}

            {#if tagList.length > 0}
            <div class="flex flex-wrap gap-2">
                {#each tagList as tag}
                <span class="inline-flex px-3 py-1.5 rounded-md text-sm/5 font-semibold {getTagColor(tag)}">
                    {tag}
                </span>
                {/each}
            </div>
            {/if}
        </div>

        <!-- Right column: 3 cols -->
        <div class="col-span-12 lg:col-span-3 flex flex-col gap-4">
            {#if authorInfoList.length > 0}
            <div class="flex flex-col gap-2 p-4 rounded-lg bg-base-100 border border-base-300">
                <span class="text-xs/4 font-medium text-base-content-muted uppercase tracking-wider">
                    {authorInfoList.length > 1 ? 'Authors' : 'Author'}
                </span>
                <div class="flex flex-col gap-3">
                    {#each authorInfoList as authorInfo}
                    <a
                        href={authorInfo.github}
                        target="_blank"
                        rel="noopener noreferrer"
                        class="flex items-center gap-3 group"
                    >
                        <img
                            src={authorInfo.avatar}
                            alt={authorInfo.name}
                            class="size-10 rounded-full object-cover ring-2 ring-base-200 group-hover:ring-primary/50 transition-all"
                            loading="lazy"
                        />
                        <span class="text-sm/5 font-semibold text-base-content group-hover:text-primary transition-colors">
                            {authorInfo.name}
                        </span>
                    </a>
                    {/each}
                </div>
            </div>
            {/if}

            {#if date}
            <div class="flex flex-col gap-2 p-4 rounded-lg bg-base-100 border border-base-300">
                <span class="text-xs/4 font-medium text-base-content-muted uppercase tracking-wider">Published</span>
                <span class="text-sm/5 font-semibold text-base-content">
                    {formatDate(date)}
                </span>
            </div>
            {/if}
        </div>
    </div>
</div>
{/if}
