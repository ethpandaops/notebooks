## Creating new pages

- Do not repeat the header in the page. It's already in the layout.

## Page Frontmatter Schema

All pages should include metadata in the frontmatter. Here's the standard schema:

```yaml
---
title: Page Title
sidebar_position: 1
description: Brief description of the page
date: 2025-01-20
author: samcm
tags:
  - tag1
  - tag2
---
```

### Required Fields

- `title`: The page title (displayed in browser tab and navigation)
- `description`: Brief description for SEO and page previews

### Optional Fields

- `sidebar_position`: Order in the sidebar navigation (lower = higher)
- `date`: Publication/update date in YYYY-MM-DD format
- `author`: Author username (see supported authors below)
- `tags`: Array of relevant tags for categorization

### Supported Authors

Use these usernames for the `author` field to show profile pictures:

| Username | Name |
|----------|------|
| `samcm` | Sam Calder-Mason |
| `parithosh` | Parithosh Jayanthi |
| `pk910` | pk910 |
| `savid` | Andrew Davis |
| `skylenet` | Rafael Matias |
| `mattevans` | Matty Evans |
| `qu0b` | Stefan |
| `raxhvl` | raxhvl |
| `elasticroentgen` | ElasticRoentgen |
| `ethpandaops` | ethPandaOps (team) |

## Displaying Page Metadata

Use the `PageMeta` component to display the metadata on the page:

```svelte
<script>
    import PageMeta from '$lib/PageMeta.svelte';
</script>

<PageMeta
    date="2025-01-20"
    author="samcm"
    tags={["tag1", "tag2"]}
/>
```

## SQL Queries

**Important**: SQL code blocks must be at the top level of the markdown file, not wrapped in HTML elements like `<div>`. Evidence's preprocessor won't process queries inside HTML wrappers, causing "X is not defined" errors.

The SQL query UI buttons are hidden globally via CSS in `pages/+layout.svelte`.

## Escaping < and > Characters

Unescaped `<` and `>` in markdown content break Svelte's parser ("Failed to fetch dynamically imported module" errors). HTML entities (`&lt;`/`&gt;`) don't work because the markdown processor converts them back.

Use inline code backticks instead:

```markdown
<!-- Wrong - breaks Svelte -->
- Conservative (z < 0)
## Top suspects (z > 2)

<!-- Also wrong - markdown converts entities back -->
- Conservative (z &lt; 0)

<!-- Correct - use inline code -->
- Conservative (`z < 0`)
## Top suspects (`z > 2`)
```
