"""Basic integration tests for ClusterAudienceKit."""

import pytest
import pandas as pd
from datetime import datetime, timedelta


@pytest.fixture
def sample_transactions():
    """Generate sample transaction data."""
    base_date = datetime(2026, 1, 1)
    data = []

    for cust_id in range(100):
        for i in range(5):
            date = base_date - timedelta(days=i * 20)
            amount = (cust_id + 1) * (i + 1) * 10
            data.append({
                "customer_id": f"cust_{cust_id:03d}",
                "transaction_date": date.strftime("%Y-%m-%d"),
                "amount": float(amount),
            })

    return pd.DataFrame(data)


def test_import():
    """Test that ClusterAudienceKit can be imported."""
    from clusteraudiencekit import AudienceSegmenter
    assert AudienceSegmenter is not None


def test_segmenter_creation():
    """Test creating a segmenter instance."""
    from clusteraudiencekit import AudienceSegmenter

    segmenter = AudienceSegmenter(method="rfm_kmeans", n_clusters=4)
    assert segmenter is not None


def test_fit_predict(sample_transactions):
    """Test fit and predict workflow."""
    pytest.skip("Implementation in progress")

    from clusteraudiencekit import AudienceSegmenter

    segmenter = AudienceSegmenter(method="rfm_kmeans", n_clusters=4)
    segmenter.fit(sample_transactions)
    segments = segmenter.predict(sample_transactions)

    assert len(segments) == len(sample_transactions)
    assert segments.min() >= 0
    assert segments.max() < 4
