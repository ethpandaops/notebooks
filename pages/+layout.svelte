<script>
	import '@evidence-dev/tailwind/fonts.css';
	import '../app.css';
	import { EvidenceDefaultLayout } from '@evidence-dev/core-components';
	import { base } from '$app/paths';
	export let data;
</script>

<EvidenceDefaultLayout
	{data}
	logo="{base}/logo.png"
	builtWithEvidence={false}
>
	<slot slot="content" />
</EvidenceDefaultLayout>

<style>
	/* Make logo bigger and add title text */
	:global(header a[href="/investigations/"] img) {
		height: 2rem !important;
	}
	:global(header a[href="/investigations/"]) {
		display: flex !important;
		align-items: center !important;
		gap: 0.5rem !important;
	}
	:global(header a[href="/investigations/"]::after) {
		content: "ethPandaOps";
		font-weight: 600;
		font-size: 1.1rem;
	}
	/* Hide SQL query UI buttons */
	:global(button[aria-label="show-sql"]),
	:global(button[aria-label="view-query"]),
	:global(.svelte-1granpn) {
		display: none !important;
	}
</style>
