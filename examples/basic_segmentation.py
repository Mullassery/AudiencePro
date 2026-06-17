"""Basic segmentation example."""

import pandas as pd
from datetime import datetime, timedelta

# Example 1: Create sample data
def generate_sample_data():
    """Generate sample transaction data for demonstration."""
    base_date = datetime(2026, 1, 1)
    data = []

    for cust_id in range(1000):
        # Generate 3-10 transactions per customer
        num_transactions = (cust_id % 8) + 3
        for i in range(num_transactions):
            date = base_date - timedelta(days=i * 15 + (cust_id % 30))
            amount = (cust_id + 1) * (i + 1) * 10
            data.append({
                "customer_id": f"cust_{cust_id:04d}",
                "transaction_date": date.strftime("%Y-%m-%d"),
                "amount": float(amount),
            })

    return pd.DataFrame(data)


def main():
    """Run basic segmentation example."""
    print("ClusterAudienceKit - Basic Segmentation Example")
    print("=" * 50)

    # Generate data
    print("\n1. Generating sample transaction data...")
    transactions = generate_sample_data()
    print(f"   Generated {len(transactions)} transactions for {len(transactions.groupby('customer_id'))} customers")
    print(f"   Columns: {list(transactions.columns)}")

    # TODO: Add segmentation code once implementation is complete
    # from clusteraudiencekit import AudienceSegmenter
    #
    # print("\n2. Creating AudienceSegmenter...")
    # segmenter = AudienceSegmenter(method='rfm_kmeans', n_clusters=4)
    #
    # print("\n3. Fitting segmenter...")
    # segmenter.fit(
    #     transactions,
    #     date_column='transaction_date',
    #     customer_column='customer_id',
    #     transaction_column='amount'
    # )
    #
    # print("\n4. Getting segments...")
    # segments = segmenter.predict(transactions)
    #
    # print("\n5. Viewing segment profiles...")
    # profiles = segmenter.segment_profiles()
    # print(profiles)
    #
    # print("\n6. Checking segment quality...")
    # silhouette = segmenter.silhouette_score()
    # davies_bouldin = segmenter.davies_bouldin_score()
    # print(f"   Silhouette Score: {silhouette:.3f}")
    # print(f"   Davies-Bouldin Score: {davies_bouldin:.3f}")

    print("\n" + "=" * 50)
    print("Example complete (implementation in progress)")


if __name__ == "__main__":
    main()
