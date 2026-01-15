# Quick Start Guide

Get started with Grafana logs clustering analysis in 5 minutes!

## 📦 Installation

```bash
cd grafana-ml-analysis
pip install -r requirements.txt
```

## 🚀 Run Analysis

### Option 1: Run All Notebooks in Sequence

```bash
jupyter notebook
```

Then open and run notebooks in order:
1. `01_data_preprocessing.ipynb`
2. `02_feature_extraction.ipynb`
3. `03_kmeans_clustering.ipynb`
4. `04_hierarchical_clustering.ipynb`
5. `05_dbscan_clustering.ipynb`
6. `06_comprehensive_comparison.ipynb`

### Option 2: Quick Test with Sample

If you want to test with a smaller sample first:

1. Open `01_data_preprocessing.ipynb`
2. In the data loading cell, add:
   ```python
   df = df.sample(n=10000, random_state=42)  # Use 10k samples for quick test
   ```
3. Run all notebooks normally

## 📊 Expected Runtime

| Notebook | Full Dataset | 10k Sample |
|----------|-------------|------------|
| 01_data_preprocessing | ~2 min | ~10 sec |
| 02_feature_extraction | ~3 min | ~15 sec |
| 03_kmeans_clustering | ~5 min | ~20 sec |
| 04_hierarchical_clustering | ~10 min | ~30 sec |
| 05_dbscan_clustering | ~8 min | ~25 sec |
| 06_comprehensive_comparison | ~1 min | ~5 sec |
| **Total** | **~29 min** | **~2 min** |

*Times are approximate on standard hardware*

## 🎯 What You'll Get

After running all notebooks, you'll have:

### Data Files
- `data/grafana_logs_preprocessed.csv` - Cleaned logs
- `data/feature_matrix.csv` - Extracted features
- `data/feature_matrix_scaled.csv` - Normalized features
- `data/metadata.csv` - Labels and metadata

### Clustering Results
- `data/kmeans_results.csv` - K-means clusters
- `data/kmeans_metrics.csv` - K-means performance
- `data/hierarchical_results.csv` - Hierarchical clusters
- `data/hierarchical_metrics.csv` - Hierarchical performance
- `data/dbscan_results.csv` - DBSCAN clusters
- `data/dbscan_metrics.csv` - DBSCAN performance

### Comparison
- `data/comprehensive_comparison.csv` - All metrics
- `data/algorithm_ranking.csv` - Performance ranking
- `data/anomaly_detection_performance.csv` - Anomaly detection results

### Visualizations
Each notebook generates multiple plots:
- Data distributions
- Temporal patterns
- Cluster visualizations (PCA)
- Performance metrics
- Silhouette analysis
- Dendrograms (hierarchical)
- k-distance graphs (DBSCAN)

## 🔍 Key Insights You'll Discover

1. **Optimal Cluster Count**
   - Best k for K-means based on Silhouette score
   - Natural groupings in your data

2. **Algorithm Performance**
   - Which algorithm works best for Grafana logs
   - Trade-offs between speed and quality

3. **Anomaly Patterns**
   - How well clusters separate anomalies
   - Which cluster contains most anomalies

4. **Feature Importance**
   - Which features matter most
   - Temporal vs. statistical features

## 🐛 Troubleshooting

### Issue: Notebook won't load data
**Solution**: Make sure you're running from the correct directory:
```bash
cd /path/to/grafana-ml-analysis
jupyter notebook
```

### Issue: Memory error
**Solution**: Use a smaller sample:
```python
df = df.sample(n=5000, random_state=42)
```

### Issue: Import errors
**Solution**: Reinstall requirements:
```bash
pip install -r requirements.txt --force-reinstall
```

### Issue: Plots don't show
**Solution**: Add to first cell:
```python
%matplotlib inline
```

## 📖 Understanding the Results

### Silhouette Score
- Range: -1 to 1
- Higher is better
- > 0.5 = Good clustering
- > 0.7 = Strong clustering

### Davies-Bouldin Index
- Range: 0 to ∞
- Lower is better
- < 1.0 = Good clustering

### Adjusted Rand Index (vs. true anomalies)
- Range: -1 to 1
- Higher is better
- 1.0 = Perfect match
- 0.0 = Random labeling

### Enrichment Factor
- How many times more likely anomalies are in the best cluster
- > 1.0 = Better than random
- > 5.0 = Very good separation

## 🎓 Next Steps

After completing the analysis:

1. **Tune Parameters**
   - Try different k values for K-means
   - Test different linkage methods for Hierarchical
   - Adjust eps and min_samples for DBSCAN

2. **Feature Engineering**
   - Add domain-specific features
   - Try different normalization techniques
   - Experiment with PCA reduction

3. **Production Deployment**
   - Export best model
   - Set up automated clustering pipeline
   - Integrate with alerting system

4. **Integration with MORPH**
   - Connect to Grafana MCP Server
   - Feed results to incident correlation engine
   - Enable automated response workflows

## 📞 Support

For issues specific to:
- **Data**: Check the synthetic-log-generator documentation
- **Notebooks**: Review cell outputs for error messages
- **Algorithms**: Consult scikit-learn documentation

## 🎉 Success Criteria

You've successfully completed the analysis when:
- ✅ All 6 notebooks run without errors
- ✅ All data files are created in `data/` directory
- ✅ You have a recommended algorithm in the final notebook
- ✅ You understand which clusters contain anomalies

Happy clustering! 🚀
