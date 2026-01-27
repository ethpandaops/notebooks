---
title: ethPandaOps Investigations
sidebar_position: 0
queries: []
---

<script>
    import CaseGrid from '$lib/CaseGrid.svelte';
</script>

<style>
h1:first-of-type { display: none !important; }

.hero-section {
    display: flex;
    align-items: center;
    gap: 3rem;
    margin: 1rem 0 2.5rem 0;
    padding: 2.5rem 0;
}

.hero-image {
    width: 200px;
    height: auto;
    flex-shrink: 0;
    filter: drop-shadow(4px 6px 12px rgba(61, 58, 42, 0.2));
}

.hero-title {
    font-family: 'Courier New', monospace;
    font-size: 2.2rem;
    font-weight: 700;
    letter-spacing: 0.15em;
    color: #3d3a2a;
    margin-bottom: 0.5rem;
    text-shadow: 1px 1px 0 rgba(255,255,255,0.8);
}

.hero-divider {
    width: 80px;
    height: 3px;
    background: linear-gradient(90deg, #bb5a38, #d4a090);
    margin-bottom: 1.25rem;
}

.hero-description {
    font-size: 0.95rem;
    color: #5c5650;
    line-height: 1.7;
    margin: 0;
}

.hero-description a {
    color: #bb5a38;
    text-decoration: none;
    font-weight: 500;
}

.hero-powered {
    font-size: 0.9rem;
    color: #5c5650;
    line-height: 1.7;
    margin-top: 1rem;
    max-width: 420px;
}

.hero-powered a {
    color: #bb5a38;
    text-decoration: none;
    font-weight: 600;
}

.footer-section {
    border-top: 1px solid #e8e5dc;
    margin-top: 3rem;
    padding-top: 1.5rem;
    font-size: 0.8rem;
    color: #9a958d;
}

.footer-section a {
    color: #6b6560;
    text-decoration: none;
    border-bottom: 1px solid #ddd9d1;
}

@media (max-width: 640px) {
    .hero-section {
        flex-direction: column;
        gap: 1.5rem;
        align-items: center;
        text-align: center;
        padding: 1.5rem 0;
        margin: 0 0 1.5rem 0;
    }

    .hero-image {
        width: 120px;
    }

    .hero-title {
        font-size: 1.6rem;
    }

    .hero-divider {
        margin-left: auto;
        margin-right: auto;
    }

}
</style>

<div class="hero-section">
    <img src="/panda.png" alt="Investigation Panda" class="hero-image" />
    <div>
        <div class="hero-title">CASE FILES</div>
        <div class="hero-divider"></div>
        <p class="hero-description">
            When something interesting happens on the network, we investigate. These one-off analyses are part of our daily workflow at <a href="https://ethpandaops.io">ethPandaOps</a> and are archived here so the findings and learnings aren't blackholed in our Discord.
        </p>
        <p class="hero-powered">
           Powered by <a href="https://ethpandaops.io/data/xatu">Xatu</a> data.
        </p>
    </div>
</div>

<CaseGrid />

<div class="footer-section">
    Built with <a href="https://evidence.dev">Evidence</a>&nbsp;&nbsp;·&nbsp;&nbsp;Maintained by <a href="https://ethpandaops.io">ethPandaOps</a>
</div>
