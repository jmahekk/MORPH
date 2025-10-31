# Grafana Logs ML Analysis

Comprehensive machine learning analysis pipeline for Grafana logs including preprocessing, feature extraction, and clustering algorithms with benchmarking.

## 📁 Project Structure

```
grafana-ml-analysis/
├── notebooks/
│   ├── 01_data_preprocessing.ipynb         # Data loading, cleaning, and preprocessing
│   ├── 02_feature_extraction.ipynb         # Feature engineering and extraction
│   ├── 03_kmeans_clustering.ipynb          # K-means clustering with evaluation
│   ├── 04_hierarchical_clustering.ipynb    # Hierarchical clustering with evaluation
│   ├── 05_dbscan_clustering.ipynb          # DBSCAN clustering with evaluation
│   └── 06_comprehensive_comparison.ipynb   # Complete comparison and benchmarking
├── data/                                    # Generated data and results
└── README.md                                # This file
```

## 🎯 Purpose

This project analyzes Grafana logs from the MORPH incident response platform to:
1. **Preprocess** log data handling Grafana-specific issues
2. **Extract features** for machine learning algorithms
3. **Apply clustering algorithms** (K-means, Hierarchical, DBSCAN)
4. **Benchmark performance** across multiple metrics
5. **Compare algorithms** to find the best approach for anomaly detection

## 📊 Grafana Logs Issues Addressed

The preprocessing pipeline specifically handles these Grafana log challenges:

### 1. **Mixed Units**
   - Different panels use different units (percent, seconds, milliseconds, count, bytes)
   - Solution: Normalize values within each unit type separately

### 2. **Different Value Ranges**
   - Metrics have vastly different scales (0-100% vs. 0-10000ms)
   - Solution: StandardScaler normalization per unit group

### 3. **Time-Series Nature**
   - Temporal patterns are critical for incident detection
   - Solution: Extract temporal features (hour, day_of_week, business hours)
   - Solution: Calculate rolling statistics (mean, std, min, max)

### 4. **Categorical Variables**
   - High cardinality in dashboard, panel, service names
   - Solution: Label encoding for categorical variables
   - Solution: Create interaction features (service_panel, dashboard_panel)

### 5. **Missing Values**
   - Some fields like anomaly_type are null for normal operations
   - Solution: Fill with 'normal' category
   - Solution: Extract metadata fields properly

### 6. **Class Imbalance**
   - Typically more normal logs than anomalies
   - Solution: Evaluate with appropriate metrics (Silhouette, Davies-Bouldin, ARI)
   - Solution: DBSCAN can identify outliers as noise points

## 🚀 Getting Started

### Prerequisites

```bash
pip install pandas numpy matplotlib seaborn scikit-learn scipy jupyter
```

### Usage

Run the notebooks in sequence:

1. **Preprocessing** (`01_data_preprocessing.ipynb`)
   - Loads Grafana logs from JSONL format
   - Handles missing values
   - Extracts temporal features
   - Normalizes values per unit type
   - Creates rolling statistics
   - Saves preprocessed data

2. **Feature Extraction** (`02_feature_extraction.ipynb`)
   - Label encodes categorical variables
   - Extracts query pattern features
   - Creates interaction features
   - Calculates aggregated statistics
   - Performs PCA analysis
   - Saves feature matrix

3. **K-means Clustering** (`03_kmeans_clustering.ipynb`)
   - Determines optimal k using Elbow method and Silhouette score
   - Applies K-means clustering
   - Evaluates with multiple metrics
   - Visualizes clusters with PCA
   - Benchmarks performance

4. **Hierarchical Clustering** (`04_hierarchical_clustering.ipynb`)
   - Creates dendrograms for different linkage methods
   - Determines optimal number of clusters
   - Applies Agglomerative clustering
   - Compares linkage methods (ward, complete, average, single)
   - Benchmarks performance

5. **DBSCAN Clustering** (`05_dbscan_clustering.ipynb`)
   - Uses k-distance graph to determine optimal eps
   - Grid search for eps and min_samples parameters
   - Applies DBSCAN (identifies noise/outliers)
   - Analyzes noise points as potential anomalies
   - Benchmarks performance

6. **Comprehensive Comparison** (`06_comprehensive_comparison.ipynb`)
   - Compares all algorithms side-by-side
   - Visualizes results with multiple plots
   - Ranks algorithms by overall performance
   - Analyzes anomaly detection effectiveness
   - Provides recommendations

## 📈 Evaluation Metrics

### Internal Validation (Cluster Quality)
- **Silhouette Score**: Measures cluster cohesion and separation (-1 to 1, higher is better)
- **Davies-Bouldin Index**: Average similarity between clusters (lower is better)
- **Calinski-Harabasz Score**: Ratio of between-cluster to within-cluster variance (higher is better)

### External Validation (vs. True Anomaly Labels)
- **Adjusted Rand Index (ARI)**: Similarity to true labels (-1 to 1, higher is better)
- **Normalized Mutual Information (NMI)**: Shared information with true labels (0 to 1, higher is better)
- **Homogeneity**: All clusters contain only same-class members (0 to 1, higher is better)
- **Completeness**: All same-class members in same cluster (0 to 1, higher is better)
- **V-measure**: Harmonic mean of homogeneity and completeness (0 to 1, higher is better)

### Performance Metrics
- **Training Time**: Computational efficiency
- **Scalability**: Performance with large datasets

### Anomaly Detection Metrics
- **Enrichment Factor**: How much better than random at separating anomalies
- **Noise Point Analysis**: For DBSCAN, percentage of anomalies in noise

## 🔍 Key Features Extracted

### Temporal Features
- Hour of day, day of week, day of month
- Is weekend, is business hours
- Hours since start

### Statistical Features
- Rolling mean, std, min, max (window=10)
- Deviation from rolling mean
- Service-level aggregates (mean, std, median, min, max)
- Panel-level aggregates
- Dashboard-level aggregates

### Encoded Features
- Dashboard, panel, service, unit, environment, cluster, datasource
- Panel type, visualization type
- Interaction features (service_panel, dashboard_panel, service_dashboard)

### Query Pattern Features
- Has rate(), sum(), avg(), max(), min(), count()
- Has by clause, has time range
- Query length

### Deviation Features
- Deviation from service mean
- Deviation from panel mean
- Z-score within service
- Z-score within panel

## 📊 Example Results

After running all notebooks, you'll find:

- `data/grafana_logs_preprocessed.csv` - Cleaned and preprocessed logs
- `data/feature_matrix.csv` - Extracted features
- `data/feature_matrix_scaled.csv` - Normalized features
- `data/metadata.csv` - Labels and metadata
- `data/kmeans_results.csv` - K-means cluster assignments
- `data/hierarchical_results.csv` - Hierarchical cluster assignments
- `data/dbscan_results.csv` - DBSCAN cluster assignments
- `data/comprehensive_comparison.csv` - All metrics combined
- `data/algorithm_ranking.csv` - Algorithm performance ranking
- `data/anomaly_detection_performance.csv` - Anomaly detection results

## 🏆 Algorithm Comparison

Each algorithm has strengths:

### K-means
- ✅ Fast and scalable
- ✅ Good for spherical clusters
- ✅ Easy to interpret
- ❌ Requires specifying k
- ❌ Assumes spherical clusters

### Hierarchical
- ✅ Creates dendrogram (visual hierarchy)
- ✅ No need to specify k initially
- ✅ Can use different linkage methods
- ❌ Slower (O(n³) for some methods)
- ❌ Less scalable to large datasets

### DBSCAN
- ✅ Finds arbitrary-shaped clusters
- ✅ Identifies outliers/noise automatically
- ✅ No need to specify cluster count
- ✅ Good for anomaly detection
- ❌ Sensitive to parameter selection
- ❌ Struggles with varying densities

## 📝 Notes

- Dataset: 150,000 Grafana log entries from `synthetic-log-generator/output/grafana/ml_training_data.jsonl`
- Time range: Full day of synthetic logs with realistic patterns
- Anomaly rate: Varies based on synthetic data generation
- Feature count: 40+ features after extraction

## 🤝 Integration with MORPH

This analysis pipeline is designed for the MORPH (MCP-based Orchestrated Response Platform for Holistic incident management) project:

- Supports **Grafana MCP Server** log analysis
- Complements other analyzers for **Kubernetes**, **Sentry**, and **CloudWatch**
- Enables **cross-source correlation** for incident detection
- Provides ML-based **anomaly clustering** for automated alerting
- Feeds into **LLM-assisted remediation** workflows

## 📖 References

- Scikit-learn Documentation: https://scikit-learn.org/
- DBSCAN: "A Density-Based Algorithm for Discovering Clusters" (Ester et al., 1996)
- Silhouette Score: "Silhouettes: A graphical aid to the interpretation" (Rousseeuw, 1987)

---

**Created for MORPH Project** - Multi-Source Orchestrated Response Platform for Holistic incident management
