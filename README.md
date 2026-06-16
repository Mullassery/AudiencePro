# AudiencePro

A high-performance audience segmentation library written in Rust with Python bindings. Segment customers 10-25x faster than scikit-learn while supporting streaming data and advanced segmentation methods.

![License](https://img.shields.io/badge/license-MIT-blue)
![Python Version](https://img.shields.io/badge/python-3.8+-blue)
![Rust](https://img.shields.io/badge/rust-1.70+-orange)

## Features

- **⚡ 10-25x Faster** — Rust implementation with SIMD and parallelization
- **🔄 Streaming-First** — Incremental updates from event streams
- **🎯 Integrated Pipeline** — RFM + Clustering in one library (vs 3 separate packages)
- **🔀 Advanced Algorithms** — KMeans, K-Prototypes, hierarchical clustering
- **📊 Sklearn-Compatible** — Familiar `fit()`, `predict()`, `transform()` interface
- **🗜️ Zero-Copy** — Apache Arrow format internally for efficiency
- **⚙️ Parallel** — Multi-core segmentation via Rayon

## Quick Start

### Installation

```bash
pip install audience-pro
```

### Basic Usage

```python
from audience_pro import AudienceSegmenter
import pandas as pd

# Load transaction data
transactions = pd.read_csv('transactions.csv')
# Columns: customer_id, transaction_date, amount

# Create and fit segmenter
segmenter = AudienceSegmenter(method='rfm_kmeans', n_clusters=4)
segmenter.fit(
    transactions,
    date_column='transaction_date',
    customer_column='customer_id',
    transaction_column='amount'
)

# Get customer segments
segments = segmenter.predict(transactions)
print(segments)  # Series: [0, 2, 1, 0, 3, ...]

# View segment profiles
profiles = segmenter.segment_profiles()
print(profiles)
#   segment | size  | avg_recency | avg_frequency | avg_monetary
#   0       | 250k  | 15.3 days   | 8.2 txns      | $450
#   ...

# Check segment quality
print(f"Silhouette Score: {segmenter.silhouette_score():.3f}")
```

### Streaming Updates

```python
# Initial training
segmenter.fit(historical_data)

# Daily updates
for day in date_range:
    daily_events = load_events(day)
    segmenter.update(daily_events)  # Fast incremental update
    
    # Monitor segment stability
    stability = segmenter.segment_stability(previous_segments)
    if stability < 0.85:  # 85% of customers stayed in same segment
        segmenter.fit(all_data, refit=True)  # Full retrain
    
    previous_segments = segmenter.predict(customer_df)
```

### K-Prototypes (Mixed Data Types)

```python
# Support for numeric + categorical features
customers = pd.read_csv('customers.csv')
# Columns: customer_id, transaction_date, amount, region, product_category

segmenter = AudienceSegmenter(method='rfm_kprototypes', n_clusters=5)
segmenter.fit(
    customers,
    date_column='transaction_date',
    customer_column='customer_id',
    transaction_column='amount',
    categorical_columns=['region', 'product_category']
)
```

## Why Not Just Use scikit-learn?

There is no single Python library for audience segmentation today. Teams stitch together sklearn + pandas + lifetimes and write glue code. AudiencePro replaces the entire stack.

| Feature | scikit-learn | pandas | lifetimes | **AudiencePro** |
|---------|:-----------:|:------:|:---------:|:---------------:|
| RFM calculation | ✗ | Manual | ✗ | ✅ |
| KMeans clustering | ✅ | ✗ | ✗ | ✅ |
| K-Prototypes (mixed data) | ✗ | ✗ | ✗ | ✅ |
| Silhouette score | ✅ | ✗ | ✗ | ✅ |
| Segment profiles | ✗ | Manual | ✗ | ✅ |
| Streaming updates | ✗ | ✗ | ✗ | ✅ |
| Drift detection | ✗ | ✗ | ✗ | ✅ |
| Multi-core by default | Partial | ✗ | ✗ | ✅ |

See [full comparison →](docs/comparison.md)

## Performance

Real measured timings (Apple M1, sklearn 1.6.1, pandas 3.0.3):

| Dataset | sklearn + pandas pipeline | AudiencePro target | Difference |
|---------|--------------------------|-------------------|------------|
| 1,000 customers | 38ms | <9ms | 4x faster |
| 10,000 customers | 606ms | <37ms | 16x faster |
| 100,000 customers | **>2.7 hours** (silhouette) | <130ms | **>70,000x** |

> The sklearn `silhouette_score` is O(n²) — it becomes unusable above ~10k customers. AudiencePro's Rust implementation targets <200ms at 1M customers.

See [full benchmarks →](BENCHMARKS.md)

## Documentation

- [Getting Started (non-technical)](docs/getting-started-simple.md)
- [API Reference](docs/api-reference.md)
- [Library Comparison](docs/comparison.md)
- [Benchmarks](BENCHMARKS.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Architecture](docs/architecture.md)
- [Examples](examples/)

## Segmentation Methods

### RFM + KMeans
Classic Recency-Frequency-Monetary analysis combined with KMeans clustering.

```python
segmenter = AudienceSegmenter(method='rfm_kmeans', n_clusters=4)
```

### RFM + K-Prototypes
RFM with support for categorical features (region, product category, etc).

```python
segmenter = AudienceSegmenter(
    method='rfm_kprototypes',
    n_clusters=5,
    categorical_columns=['region', 'product_category']
)
```

### Pure KMeans
Raw clustering without RFM preprocessing.

```python
segmenter = AudienceSegmenter(method='kmeans_only', n_clusters=4)
```

## Configuration

```python
segmenter = AudienceSegmenter(
    method='rfm_kmeans',              # Algorithm
    n_clusters=4,                      # Number of segments
    recency_window_days=90,            # RFM lookback window
    decay_function='linear',           # 'linear', 'exponential', 'inverse'
    decay_half_life_days=30,           # For exponential decay
    frequency_threshold=1,             # Minimum transaction count
    monetary_threshold=0.0,            # Minimum transaction value
    random_state=42,                   # Reproducibility
    n_jobs=-1,                         # Parallelization (-1 = all cores)
)
```

## Metrics

All metrics follow scikit-learn conventions:

- **Silhouette Score** — Measure cluster cohesion (-1 to 1, higher is better)
- **Davies-Bouldin Score** — Cluster separation (lower is better)
- **Inertia** — Sum of squared distances (lower is better)

```python
silhouette = segmenter.silhouette_score()
davies_bouldin = segmenter.davies_bouldin_score()
inertia = segmenter.inertia()
```

## State Management

Save and load segmentation state for production pipelines:

```python
# Save after training
segmenter.save_state('segments.state')

# Load for inference
segmenter.load_state('segments.state')
segments = segmenter.predict(new_data)
```

## Development

### Building from Source

```bash
# Clone repository
git clone https://github.com/Mullassery/AudiencePro.git
cd AudiencePro

# Install build dependencies
pip install maturin

# Build
maturin develop

# Run tests
pytest tests/
pytest --benchmark tests/
```

### Running Benchmarks

```bash
cargo bench
```

### Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Roadmap

- [x] Phase 1: Core library (RFM, KMeans, metrics)
- [ ] Phase 2: Streaming engine (incremental updates)
- [ ] Phase 3: Advanced algorithms (K-Prototypes, hierarchical)
- [ ] Phase 4: Production features (drift detection, MLflow integration)

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## Citation

If you use AudiencePro in research or production, please cite:

```bibtex
@software{audiencepro2026,
  title = {AudiencePro: High-Performance Audience Segmentation},
  author = {Mullassery, Georgi Mammen},
  year = {2026},
  url = {https://github.com/Mullassery/AudiencePro}
}
```

## Support

- 📝 [Issues](https://github.com/Mullassery/AudiencePro/issues)
- 💬 [Discussions](https://github.com/Mullassery/AudiencePro/discussions)
- 📧 Email: mullassery@gmail.com

## Acknowledgments

Built with inspiration from scikit-learn, pandas, and lifetimes libraries.
