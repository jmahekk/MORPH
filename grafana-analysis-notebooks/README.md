# Grafana Logs Clustering Analysis Notebooks

Comprehensive analysis pipeline for preprocessing, feature extraction, and clustering of Grafana logs using three different clustering algorithms: K-Means, Hierarchical, and DBSCAN.

## 📚 Notebooks Overview

### 1. Preprocessing (`1_preprocessing.ipynb`)
**Purpose**: Handle Grafana log-specific preprocessing challenges

**Key Features**:
- Flatten nested JSON structure (panel, target, datapoints, tags, meta)
- Extract and parse timestamps from milliseconds format
- Handle variable-length datapoint arrays
- Parse Prometheus query expressions
- Detect and remove outliers using IQR method per panel type
- Clean and normalize text fields

**Grafana-Specific Issues Addressed**:
- **Nested structures**: Multiple levels of nested dictionaries flattened into tabular format
- **Mixed data types**: Numeric values, strings, and complex objects normalized
- **Prometheus queries**: Complex query expressions parsed for semantic features
- **Multiple panel types**: Different visualization types (gauge, graph, stat, heatmap) handled
- **Timestamp formats**: Milliseconds timestamps converted to datetime objects

**Output**: `preprocessed_grafana_logs.csv`, `preprocessed_grafana_logs.pkl`

---

### 2. Feature Extraction (`2_feature_extraction.ipynb`)
**Purpose**: Extract comprehensive features for robust clustering

**Feature Categories**:
1. **Numerical Features**: Metric values, temporal attributes, query complexity
2. **Statistical Features**: Rolling mean, std, min, max (windows: 10, 50, 100)
3. **Temporal Features**: Hour, day of week, business hours, weekend flags
4. **Anomaly Features**: Z-score, IQR-based anomaly flags
5. **Categorical Features**: Label-encoded and one-hot encoded dashboards, panels, services
6. **Text Features**: TF-IDF from panel titles and Prometheus queries (50 features)
7. **Query Features**: Boolean flags for metric types, aggregation functions, time windows

**Transformations**:
- StandardScaler for distance-based clustering
- PCA for dimensionality reduction and visualization
- Feature correlation analysis

**Output**: `features_scaled.csv`, `features_pca.csv`, `metadata.csv`, `preprocessing_objects.pkl`

**Total Features**: ~100+ features extracted

---

### 3. K-Means Clustering (`3_kmeans_clustering.ipynb`)
**Purpose**: Partitioning-based clustering with optimal k selection

**Algorithm**: K-Means
- **Type**: Centroid-based partitioning
- **Time Complexity**: O(n × k × i × d) where n=samples, k=clusters, i=iterations, d=dimensions
- **Advantages**: Fast, scalable, works well with spherical clusters
- **Disadvantages**: Requires predefined k, sensitive to initialization

**Process**:
1. Elbow method for optimal k (tests k=2 to 20)
2. Silhouette analysis
3. Davies-Bouldin index optimization
4. Calinski-Harabasz score evaluation
5. Final clustering with optimal k
6. Cluster visualization (2D and 3D PCA)
7. Cluster characteristics analysis

**Evaluation Metrics**:
- Silhouette Score (higher is better, range: [-1, 1])
- Davies-Bouldin Index (lower is better)
- Calinski-Harabasz Score (higher is better)
- Inertia (within-cluster sum of squares)

**Output**: `kmeans_cluster_assignments.csv`, `kmeans_metrics.json`, `kmeans_model.pkl`

---

### 4. Hierarchical Clustering (`4_hierarchical_clustering.ipynb`)
**Purpose**: Hierarchical agglomerative clustering with dendrogram analysis

**Algorithm**: Agglomerative Hierarchical Clustering
- **Type**: Bottom-up hierarchical
- **Time Complexity**: O(n³) time, O(n²) space
- **Advantages**: No need to predefine k, produces dendrogram, captures hierarchy
- **Disadvantages**: Computationally expensive, sensitive to noise

**Linkage Methods Tested**:
- **Ward**: Minimizes within-cluster variance
- **Average**: Average distance between all pairs
- **Complete**: Maximum distance between clusters

**Process**:
1. Compute linkage matrices for all methods
2. Generate dendrograms
3. Test k=2 to 20 for each linkage method
4. Select best linkage method and k
5. Final clustering with optimal parameters
6. Cluster visualization and analysis

**Special Handling**:
- Automatic sampling for large datasets (>10,000 samples) due to O(n²) memory complexity
- Dendrogram truncation for visualization

**Output**: `hierarchical_cluster_assignments.csv`, `hierarchical_metrics.json`, `hierarchical_model.pkl`, `hierarchical_linkage_matrix.pkl`

---

### 5. DBSCAN Clustering (`5_dbscan_clustering.ipynb`)
**Purpose**: Density-based clustering with automatic noise detection

**Algorithm**: DBSCAN (Density-Based Spatial Clustering of Applications with Noise)
- **Type**: Density-based
- **Time Complexity**: O(n log n) with spatial indexing
- **Advantages**: Finds arbitrary-shaped clusters, identifies outliers, no predefined k
- **Disadvantages**: Sensitive to eps and min_samples parameters

**Key Parameters**:
- **eps**: Maximum distance between two samples to be neighbors
- **min_samples**: Minimum samples in neighborhood for core point

**Process**:
1. k-distance graph to determine optimal eps
2. Parameter grid search (eps × min_samples)
3. Evaluation with multiple metrics
4. Heatmap visualization of parameter performance
5. Final clustering with optimal parameters
6. Noise point analysis
7. Cluster and outlier visualization

**Special Features**:
- Works on PCA-reduced features (better for high dimensions)
- Explicit noise point detection and analysis
- Parameter sensitivity analysis

**Output**: `dbscan_cluster_assignments.csv`, `dbscan_metrics.json`, `dbscan_model.pkl`, `dbscan_parameter_tuning_results.csv`

---

### 6. Clustering Comparison (`6_clustering_comparison.ipynb`)
**Purpose**: Comprehensive benchmarking and comparison of all three algorithms

**Comparison Dimensions**:

1. **Quality Metrics**:
   - Silhouette Score comparison
   - Davies-Bouldin Index comparison
   - Calinski-Harabasz Score comparison

2. **Performance Metrics**:
   - Execution time benchmarking
   - Memory efficiency
   - Scalability analysis

3. **Practical Metrics**:
   - Number of clusters found
   - Cluster size distribution
   - Cluster balance (coefficient of variation)
   - Cluster purity (panel and service homogeneity)

4. **Visualizations**:
   - Bar charts for each metric
   - Radar chart (normalized comparison)
   - Cluster distribution comparison
   - Comprehensive comparison table

**Output**: `clustering_comparison_summary.csv`, `clustering_comparison_report.json`

**Recommendations Generated**:
- Overall winner based on weighted quality metrics
- Use-case specific recommendations
- Production deployment guidance

---

## 🚀 Quick Start

### Prerequisites
```bash
pip install -r requirements.txt
```

### Running the Notebooks

**Sequential Execution** (Recommended):
```bash
# 1. Preprocessing
jupyter notebook 1_preprocessing.ipynb

# 2. Feature Extraction
jupyter notebook 2_feature_extraction.ipynb

# 3. Clustering Algorithms (can be run in parallel)
jupyter notebook 3_kmeans_clustering.ipynb
jupyter notebook 4_hierarchical_clustering.ipynb
jupyter notebook 5_dbscan_clustering.ipynb

# 4. Comparison (requires all previous notebooks completed)
jupyter notebook 6_clustering_comparison.ipynb
```

**Or run all at once with JupyterLab**:
```bash
jupyter lab
```

---

## 📊 Expected Results

### Typical Metrics (140k+ Grafana logs):

| Algorithm | Silhouette | Davies-Bouldin | Calinski-Harabasz | Time | Clusters |
|-----------|------------|----------------|-------------------|------|----------|
| K-Means | 0.35-0.45 | 1.2-1.8 | 1000-3000 | 5-15s | Predefined |
| Hierarchical | 0.30-0.40 | 1.3-2.0 | 900-2500 | 30-120s | Optimized |
| DBSCAN | 0.25-0.40 | 1.5-2.5 | 800-2000 | 10-30s | Auto-detected |

*Note: Actual metrics depend on data characteristics and optimal parameters*

---

## 📁 Output Files

After running all notebooks, you'll have:

**Preprocessing**:
- `preprocessed_grafana_logs.csv` - Cleaned and flattened data
- `preprocessed_grafana_logs.pkl` - Pickle format for fast loading

**Feature Extraction**:
- `features_scaled.csv` - Standardized features
- `features_pca.csv` - PCA-transformed features
- `features_unscaled.csv` - Original features
- `metadata.csv` - Original metadata for analysis
- `feature_names.txt` - Feature name reference
- `preprocessing_objects.pkl` - Scaler, PCA, encoders

**Clustering Results**:
- `kmeans_cluster_assignments.csv`
- `kmeans_metrics.json`
- `kmeans_model.pkl`
- `hierarchical_cluster_assignments.csv`
- `hierarchical_metrics.json`
- `hierarchical_model.pkl`
- `hierarchical_linkage_matrix.pkl`
- `dbscan_cluster_assignments.csv`
- `dbscan_metrics.json`
- `dbscan_model.pkl`
- `dbscan_parameter_tuning_results.csv`

**Comparison**:
- `clustering_comparison_summary.csv`
- `clustering_comparison_report.json`

**Visualizations** (PNG files):
- `kmeans_optimal_k.png`
- `kmeans_clusters_pca.png`
- `kmeans_clusters_3d.png`
- `kmeans_cluster_characteristics.png`
- `hierarchical_dendrograms.png`
- `hierarchical_optimal_k.png`
- `hierarchical_clusters_pca.png`
- `hierarchical_clusters_3d.png`
- `hierarchical_cluster_characteristics.png`
- `dbscan_k_distance_graph.png`
- `dbscan_parameter_tuning.png`
- `dbscan_clusters_pca.png`
- `dbscan_clusters_3d.png`
- `dbscan_cluster_characteristics.png`
- `clustering_comparison_metrics.png`
- `clustering_comparison_radar.png`
- `clustering_comparison_distribution.png`
- `clustering_comparison_table.png`

---

## 🎯 Use Case Recommendations

Based on benchmarking results:

### **K-Means** - Best for:
- ✅ Production monitoring with known patterns
- ✅ Large-scale datasets (>100k samples)
- ✅ Real-time clustering requirements
- ✅ Balanced cluster sizes needed
- ✅ Spherical cluster shapes

### **Hierarchical** - Best for:
- ✅ Exploratory data analysis
- ✅ Understanding data hierarchy
- ✅ Small to medium datasets (<10k samples)
- ✅ Dendrogram visualization needed
- ✅ Flexible cluster number selection

### **DBSCAN** - Best for:
- ✅ Anomaly and outlier detection
- ✅ Arbitrary cluster shapes
- ✅ Unknown number of clusters
- ✅ Noise point identification
- ✅ Varying cluster densities

---

## 🔧 Customization

### Adjusting Parameters

**K-Means**:
```python
# In notebook 3
K_range = range(2, 21)  # Test different ranges
kmeans = KMeans(n_clusters=optimal_k, n_init=20, max_iter=500)
```

**Hierarchical**:
```python
# In notebook 4
linkage_methods = ['ward', 'average', 'complete', 'single']  # Add more
MAX_SAMPLES = 10000  # Adjust for your memory capacity
```

**DBSCAN**:
```python
# In notebook 5
n_components = 30  # Number of PCA components
k = 4  # k-nearest neighbors for eps calculation
min_samples_values = [3, 5, 10, 15, 20]  # Test range
```

### Feature Selection

Modify `2_feature_extraction.ipynb` to add/remove features:
```python
# Add custom features
df['custom_feature'] = df['value'] / df['rolling_mean_50']

# Adjust TF-IDF parameters
tfidf_panel = TfidfVectorizer(max_features=30, ngram_range=(1, 3))
```

---

## 📈 Performance Optimization

### For Large Datasets (>100k samples):

1. **Use sampling for Hierarchical**:
   - Already implemented with MAX_SAMPLES threshold

2. **Use Mini-Batch K-Means**:
   ```python
   from sklearn.cluster import MiniBatchKMeans
   kmeans = MiniBatchKMeans(n_clusters=k, batch_size=1000)
   ```

3. **Reduce feature dimensions**:
   ```python
   # Use fewer PCA components
   pca = PCA(n_components=20)
   ```

4. **Parallel processing**:
   ```python
   # Already enabled in DBSCAN
   dbscan = DBSCAN(n_jobs=-1)
   ```

---

## 🐛 Troubleshooting

### Common Issues:

**1. Memory Error in Hierarchical Clustering**:
- Reduce `MAX_SAMPLES` in notebook 4
- Use PCA features instead of full features

**2. DBSCAN finds all noise**:
- Increase `eps` value
- Decrease `min_samples` value
- Check k-distance graph for proper elbow

**3. Poor clustering quality**:
- Add more features in notebook 2
- Try different feature normalization
- Adjust outlier removal threshold

**4. Long execution time**:
- Use sampling for large datasets
- Reduce number of features
- Use Mini-Batch variants

---

## 📚 References

**Algorithms**:
- MacQueen, J. (1967). K-Means Clustering
- Ward, J. H. (1963). Hierarchical Clustering
- Ester, M., et al. (1996). DBSCAN Algorithm

**Metrics**:
- Rousseeuw, P. J. (1987). Silhouette Score
- Davies, D. L., & Bouldin, D. W. (1979). Davies-Bouldin Index
- Caliński, T., & Harabasz, J. (1974). Variance Ratio Criterion

**Libraries**:
- scikit-learn: https://scikit-learn.org/
- pandas: https://pandas.pydata.org/
- matplotlib: https://matplotlib.org/
- seaborn: https://seaborn.pydata.org/

---

## 🤝 Contributing

To extend this analysis:

1. Add new clustering algorithms (e.g., HDBSCAN, OPTICS, Spectral)
2. Implement additional evaluation metrics
3. Add time-series specific features
4. Integrate with MORPH platform for real-time clustering

---

## 📝 Notes

- All notebooks include comprehensive comments and markdown explanations
- Visualizations are automatically saved as high-resolution PNG files
- Intermediate results are saved for debugging and analysis
- Notebooks can be run independently after preprocessing and feature extraction

---

## ⚡ Performance Tips

- Run notebooks 3, 4, and 5 in parallel using different kernels
- Use GPU acceleration for large-scale PCA if available
- Cache feature matrices to avoid recomputation
- Use `%%time` magic in cells to profile execution

---

**Last Updated**: 2024
**Version**: 1.0.0
**Maintained by**: MORPH Development Team
