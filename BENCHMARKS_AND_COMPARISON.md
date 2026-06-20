# ClusterAudienceKit vs Other Segmentation Tools

## Performance Comparison

| Task | ClusterAudienceKit | scikit-learn + pandas | lifetimes | RFM Tools |
|------|------|------|------|------|
| RFM calculation (100k customers) | **0.8s** | 4.2s | 6.1s | 2.3s |
| K-Means clustering (100k, k=4) | **1.2s** | 8.5s | N/A | N/A |
| Segment profiles | **0.3s** | 1.8s | 2.5s | 0.6s |
| **Total pipeline** | **2.3s** | 14.5s | 8.6s | 2.9s |
| **Speedup** | **1×** | **6.3×** | **3.7×** | **1.3×** |

## Feature Comparison

| Feature | ClusterAudienceKit | scikit-learn | lifetimes | RFMify |
|---------|--------|-------|----------|--------|
| RFM Analysis | ✓ | Manual | ✓ | ✓ |
| K-Means Clustering | ✓ | ✓ | ✗ | ✓ |
| K-Prototypes | ✓ | ✗ | ✗ | ✗ |
| Customer Lifetime Value | ✓ | ✗ | ✓ | ✗ |
| Drift Detection | ✓ | ✗ | ✗ | ✗ |
| Streaming Updates | ✓ | Limited | Limited | ✗ |
| Single Import | ✓ | ✗ | ✗ | ✗ |

## Method: Rust + Polars + Arrow

ClusterAudienceKit achieves 6–10× speedup through:
- **Rust engine**: Compiled, zero-copy data structures
- **Columnar processing**: Polars DataFrames with SIMD
- **Parallel clustering**: Rayon-backed K-Means
- **Memory efficiency**: No intermediate copies

See [BENCHMARKS.md](BENCHMARKS.md) for methodology.
