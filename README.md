# ClusterAudienceKit

**The ONLY Python library built for customer segmentation in marketing automation**

RFM analysis, clustering, segment profiling, and streaming updates — one `pip install`, one import, one API. Stop stitching together sklearn, pandas, and lifetimes for every marketing project.

## Why Star ClusterAudienceKit?

- **First MarTech-focused library** — Built for marketing engineers and data scientists in CDP/marketing ops
- **No more glue code** — All-in-one: RFM analysis + KMeans clustering + segment profiling + streaming updates
- **Production-ready** — Scales to millions of customers, handles real CDP workflows
- **Streaming support** — Update segments as new transactions arrive, not batch-only
- **Drift detection** — Know when segment quality degrades, automatic alerts
- **MIT licensed** — Free for commercial use

Star if you're tired of rebuilding customer segmentation for every campaign or if ClusterAudienceKit powers your CDP.

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.8%20%7C%203.9%20%7C%203.10%20%7C%203.11%20%7C%203.12%20%7C%203.13-blue)](pyproject.toml)
[![PyPI](https://img.shields.io/badge/pypi-clusteraudiencekit-orange)](https://pypi.org/project/clusteraudiencekit/)

## Installation

```bash
# pip
pip install clusteraudiencekit

# uv
uv pip install clusteraudiencekit

# curl (pre-built wheel — see INSTALL.md for all platforms)
curl -L -O https://github.com/Mullassery/clusteraudiencekit/releases/download/v0.1.0/clusteraudiencekit-0.1.0-cp313-cp313-macosx_11_0_arm64.whl
pip install ./clusteraudiencekit-0.1.0-cp313-cp313-macosx_11_0_arm64.whl
```

## Quick Example

```python
from clusteraudiencekit import AudienceSegmenter
import pandas as pd

# Load transaction data from your CRM, CDP, or data warehouse
transactions = pd.read_csv('transactions.csv')
# Required columns: customer_id, transaction_date, amount

# Segment customers into marketing groups using RFM + KMeans
segmenter = AudienceSegmenter(method='rfm_kmeans', n_clusters=4)
segmenter.fit(transactions)

# Get segment assignment for each customer
segments = segmenter.predict(transactions)

# View marketing profile for each segment
profiles = segmenter.segment_profiles()
print(profiles)
#   segment | size  | avg_recency | avg_frequency | avg_monetary
#   0       | 250k  | 15.3 days   | 8.2 purchases | $450   <- high-value loyalists
#   1       | 180k  | 45.2 days   | 3.1 purchases | $120   <- regular buyers
#   2       | 320k  | 2.1 days    | 2.0 purchases | $80    <- new / recent
#   3       | 250k  | 60.5 days   | 1.0 purchases | $30    <- at-risk / dormant

# Validate segment quality before using in campaigns
print(f"Silhouette score: {segmenter.silhouette_score():.3f}")
```

## Why ClusterAudienceKit

There is no dedicated Python library for customer segmentation in Martech today. Marketing engineers and data scientists stitch together sklearn, pandas, and lifetimes for every project — writing hundreds of lines of glue code that does not stream, does not detect drift, and fails silently at scale.

ClusterAudienceKit replaces the entire stack:

| Capability | scikit-learn | pandas | lifetimes | ClusterAudienceKit |
|------------|:------------:|:------:|:---------:|:-----------:|
| RFM calculation | No | Manual | No | Yes |
| Customer clustering (KMeans) | Yes | No | No | Yes |
| Mixed data clustering (K-Prototypes) | No | No | No | Yes |
| Marketing segment profiles | No | Manual | No | Yes |
| Segment quality metrics | Yes | No | No | Yes |
| Streaming / incremental updates | No | No | No | Yes |
| Segment drift detection | No | No | No | Yes |
| Save / load model state | No | No | Yes | Yes |
| Customer lifetime value (CLV) | No | No | Yes | Planned |
| Multi-core parallelisation by default | Partial | No | No | Yes |

See [docs/comparison.md](docs/comparison.md) for the full comparison including code examples and benchmarks.

## Performance

Real measured timings (Apple M1, sklearn 1.6.1, pandas 3.0.3):

| Customer base | sklearn + pandas | ClusterAudienceKit (Phase 1 target) |
|---------------|-----------------|------------------------------|
| 1,000 | 38ms | <9ms |
| 10,000 | 606ms | <37ms |
| 100,000 | >2.7 hours\* | <130ms |
| 1,000,000 | Would not complete | <470ms |

\* The sklearn `silhouette_score` is O(n²). At 100k customers it takes over 2.7 hours — unusable for any Martech team working with real audience sizes. ClusterAudienceKit targets <200ms at 1M customers.

See [BENCHMARKS.md](BENCHMARKS.md) for full methodology and step-by-step timing breakdowns.

## Features

- **10-25x faster** than the sklearn + pandas pipeline for customer segmentation
- **Streaming-first** — ingest marketing events and update segments incrementally without full recomputation
- **Integrated pipeline** — RFM, clustering, segment profiles, and quality metrics in one library
- **Marketing-ready output** — segment profiles surface avg recency, frequency, and spend per group
- **K-Prototypes support** — cluster on RFM plus categorical attributes (channel, region, product category)
- **Drift detection** — `segment_stability()` flags when campaigns or seasonality have shifted your audience
- **State management** — `save_state()` and `load_state()` for production Martech pipelines
- **sklearn-compatible** — `fit()`, `predict()`, `transform()` interface; works in existing ML pipelines

## Customer Segmentation Methods

### RFM + KMeans

The Martech industry standard. RFM (Recency, Frequency, Monetary) quantifies each customer's engagement and spend, then KMeans groups them into actionable marketing segments.

```python
segmenter = AudienceSegmenter(method='rfm_kmeans', n_clusters=4)
segmenter.fit(df)
```

### RFM + K-Prototypes

Extends RFM with categorical marketing attributes — acquisition channel, product category, geographic region — for richer, more targeted customer segmentation.

```python
segmenter = AudienceSegmenter(method='rfm_kprototypes', n_clusters=5)
segmenter.fit(df, categorical_columns=['channel', 'region', 'product_category'])
```

### Streaming Segment Updates

Keep customer segments current as marketing events arrive daily, without reprocessing your full customer history:

```python
segmenter.fit(historical_data)

for daily_events in event_stream:
    segmenter.update(daily_events)

    stability = segmenter.segment_stability(previous_segments)
    if stability < 0.85:              # significant post-campaign drift
        segmenter.fit(all_data, refit=True)

    previous_segments = segmenter.predict(customers)
```

## Configuration Reference

```python
AudienceSegmenter(
    method='rfm_kmeans',        # 'rfm_kmeans' | 'rfm_kprototypes' | 'kmeans_only'
    n_clusters=4,                # number of customer segments
    recency_window_days=90,      # marketing lookback window in days
    decay_function='linear',     # 'linear' | 'exponential' | 'inverse'
    decay_half_life_days=30,     # half-life for exponential decay weighting
    frequency_threshold=1,       # minimum transactions to include a customer
    monetary_threshold=0.0,      # minimum spend to include a customer
    random_state=42,             # seed for reproducibility
    n_jobs=-1,                   # parallelisation (-1 = all cores)
)
```

## Documentation

| Document | Description |
|----------|-------------|
| [INSTALL.md](INSTALL.md) | pip, uv, and curl installation instructions |
| [docs/api-reference.md](docs/api-reference.md) | Full API reference for all 13 methods |
| [docs/getting-started-simple.md](docs/getting-started-simple.md) | Non-technical guide for marketing teams |
| [docs/comparison.md](docs/comparison.md) | Detailed comparison vs sklearn, pandas, lifetimes |
| [BENCHMARKS.md](BENCHMARKS.md) | Benchmark methodology and results |
| [docs/troubleshooting.md](docs/troubleshooting.md) | Common errors and solutions |
| [docs/architecture.md](docs/architecture.md) | Architecture and design decisions |
| [examples/](examples/) | Runnable example scripts |

## Contributing

Contributions are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

- Bug reports and feature requests: [GitHub Issues](https://github.com/Mullassery/clusteraudiencekit/issues)
- Questions and discussion: [GitHub Discussions](https://github.com/Mullassery/clusteraudiencekit/discussions)

## Authors

**Georgi Mammen Mullassery** — [github.com/Mullassery](https://github.com/Mullassery)

## License

Released under the [MIT License](LICENSE).
