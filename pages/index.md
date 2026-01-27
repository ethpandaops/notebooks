---
title: ethPandaOps Investigations
sidebar_position: 0
queries: []
---

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

.case-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1.25rem;
}

.case-card {
    display: block;
    padding: 1.5rem 1.75rem;
    text-decoration: none;
    transition: all 0.15s ease-out;
}

.case-card-latest {
    background: linear-gradient(135deg, rgba(248,247,243,0.9) 0%, rgba(244,242,235,1) 100%);
    border-left: 4px solid #bb5a38;
    box-shadow: 0 2px 8px -2px rgba(61,58,42,0.08);
}

.case-card-secondary {
    background: rgba(248,247,243,0.7);
    border-left: 4px solid #d4a090;
}

.case-card-tertiary {
    background: rgba(248,247,243,0.5);
    border-left: 4px solid #ddd9d1;
}

.case-card-date {
    font-family: ui-monospace, monospace;
    font-size: 0.6rem;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    margin-bottom: 0.5rem;
}

.case-card-date-latest {
    color: #bb5a38;
    font-weight: 600;
}

.case-card-date-default {
    color: #9a958d;
}

.case-card-title {
    color: #3d3a2a;
    font-weight: 700;
    font-size: 1.1rem;
    margin-bottom: 0.4rem;
}

.case-card-desc {
    font-size: 0.85rem;
    color: #6b6560;
    line-height: 1.5;
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

    .case-grid {
        grid-template-columns: 1fr;
    }

    .case-card {
        padding: 1.25rem 1.25rem;
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

<div class="case-grid">
    <a href="/2026-01/timing-games" class="case-card case-card-latest">
        <div class="case-card-date case-card-date-latest">Latest Case</div>
        <div class="case-card-title">Timing Games</div>
        <div class="case-card-desc">Which entities delay their blocks to extract more MEV?</div>
    </a>
    <a href="/2026-01/private-blob-submitters" class="case-card case-card-secondary">
        <div class="case-card-date case-card-date-default">Jan 21</div>
        <div class="case-card-title">Private Blob Submitters</div>
        <div class="case-card-desc">Who posts blobs that bypass the public mempool?</div>
    </a>
    <a href="/2026-01/head-accuracy-by-entity" class="case-card case-card-tertiary">
        <div class="case-card-date case-card-date-default">Jan 20</div>
        <div class="case-card-title">Head Vote Accuracy</div>
        <div class="case-card-desc">How often do validators correctly vote for the chain head?</div>
    </a>
    <a href="/2026-01/snooper-overhead" class="case-card case-card-tertiary">
        <div class="case-card-date case-card-date-default">Jan 16</div>
        <div class="case-card-title">RPC Snooper Overhead</div>
        <div class="case-card-desc">Measuring latency impact of rpc-snooper on Engine API.</div>
    </a>
</div>

<div class="footer-section">
    Built with <a href="https://evidence.dev">Evidence</a>&nbsp;&nbsp;·&nbsp;&nbsp;Maintained by <a href="https://ethpandaops.io">ethPandaOps</a>
</div>
