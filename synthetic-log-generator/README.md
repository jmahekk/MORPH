# Kubernetes Logs Clustering Analysis - Complete Workflow

This repository contains a comprehensive set of Jupyter notebooks for preprocessing, feature extraction, and clustering analysis of Kubernetes logs data, followed by detailed benchmarking and performance comparison.

## 📁 Files Overview

### Main Workflow Notebooks

1. **`01_data_preprocessing.ipynb`** - Data Preprocessing and Cleaning
2. **`02_feature_extraction.ipynb`** - Feature Engineering and Extraction
3. **`03_clustering_analysis.ipynb`** - Clustering Implementation and Analysis
4. **`04_benchmarking_comparison.ipynb`** - Comprehensive Benchmarking and Performance Comparison

### Data Files
- `output/kubernetes/k8.jsonl` - Original Kubernetes logs data
- `preprocessed_kubernetes_logs.csv` - Cleaned and preprocessed data
- `features_for_clustering.csv` - Engineered features for clustering
- `features_*.csv` - Various feature sets (scaled, PCA, selected, numerical)

### Output Files (Generated)
- `clustering_comparison_results.csv` - Algorithm performance comparison
- `best_clustering_labels.csv` - Best model cluster assignments
- `detailed_benchmark_results.csv` - Comprehensive benchmark results
- `ranking_*.csv` - Performance rankings by different metrics
- `benchmark_summary.json` - Machine-readable benchmark summary

## 🚀 Quick Start Guide

### Prerequisites
```bash
pip install pandas numpy scikit-learn matplotlib seaborn jupyter
```

### Running the Workflow

#### Option 1: Sequential Execution (Recommended)
Run notebooks in order to understand the complete pipeline:

1. **Start with preprocessing:**
   ```bash
   jupyter notebook 01_data_preprocessing.ipynb
   ```

2. **Proceed to feature extraction:**
   ```bash
   jupyter notebook 02_feature_extraction.ipynb
   ```

3. **Run clustering analysis:**
   ```bash
   jupyter notebook 03_clustering_analysis.ipynb
   ```

4. **Complete with benchmarking:**
   ```bash
   jupyter notebook 04_benchmarking_comparison.ipynb
   ```

#### Option 2: Skip to Results
If you want to see the results immediately, run notebook `04_benchmarking_comparison.ipynb` which includes synthetic data generation for demonstration.

## 📊 What Each Notebook Does

### 1. Data Preprocessing (`01_data_preprocessing.ipynb`)
**Purpose:** Clean and prepare raw Kubernetes logs for analysis

**Key Features:**
- ✅ Load and parse JSONL format logs
- ✅ Data quality assessment and missing value analysis
- ✅ Log message cleaning and normalization
- ✅ Extract structured features from Kubernetes metadata
- ✅ Engineer additional features (response time, HTTP status, service type)
- ✅ Generate comprehensive data quality report

**Input:** `output/kubernetes/k8.jsonl`
**Output:** `preprocessed_kubernetes_logs.csv`, `features_for_clustering.csv`

### 2. Feature Extraction (`02_feature_extraction.ipynb`)
**Purpose:** Transform preprocessed data into feature vectors suitable for clustering

**Key Features:**
- ✅ Categorical feature encoding (label encoding)
- ✅ Text feature extraction using TF-IDF vectorization
- ✅ Numerical feature engineering and scaling
- ✅ Principal Component Analysis (PCA) for dimensionality reduction
- ✅ Feature selection based on variance
- ✅ Multiple feature set preparation for different algorithms

**Output:** Various feature sets (`features_scaled_features.csv`, `features_pca_features.csv`, etc.)

### 3. Clustering Analysis (`03_clustering_analysis.ipynb`)
**Purpose:** Implement and compare clustering algorithms

**Key Features:**
- ✅ K-means clustering with optimal k selection
- ✅ Hierarchical clustering (Ward linkage)
- ✅ DBSCAN clustering with parameter optimization
- ✅ Multiple evaluation metrics (Silhouette, Calinski-Harabasz, Davies-Bouldin)
- ✅ Best model selection and 2D visualization
- ✅ Cluster analysis and interpretation

**Output:** Cluster assignments, performance metrics, visualizations

### 4. Benchmarking & Comparison (`04_benchmarking_comparison.ipynb`)
**Purpose:** Comprehensive performance evaluation and statistical analysis

**Key Features:**
- ✅ Multi-algorithm benchmarking across all feature sets
- ✅ Statistical significance testing (t-tests, ANOVA)
- ✅ Time complexity and scalability analysis
- ✅ Comprehensive accuracy metrics comparison
- ✅ Business impact assessment and recommendations
- ✅ Complete documentation and reporting

**Output:** Detailed benchmark reports, rankings, statistical analysis

## 📈 Key Results and Insights

### Algorithm Performance Summary

| Algorithm | Best Use Case | Avg Silhouette | Speed | Consistency |
|-----------|---------------|----------------|-------|------------|
| **K-means** | Spherical clusters, known k | High | Fast | Good |
| **Hierarchical** | Nested structures | High | Medium | Excellent |
| **DBSCAN** | Variable density, noise handling | Medium | Slow | Variable |

### Feature Set Performance

| Feature Set | Best For | Advantages | Considerations |
|-------------|----------|------------|----------------|
| **Scaled Features** | General use | All information preserved | Higher dimensions |
| **PCA Features** | Visualization | Dimensionality reduction | Some info loss |
| **Selected Features** | Efficiency | Top variance features | Reduced complexity |
| **Numerical Only** | DBSCAN | Optimal for density-based | Limited text info |

## 🎯 Recommended Configurations

### For Production Use
- **Best Accuracy:** Hierarchical clustering + PCA features
- **Best Speed:** K-means + selected features
- **Best Balance:** K-means + scaled features
- **Noise Handling:** DBSCAN + numerical features

### For Different Data Sizes
- **Small Data (< 1K logs):** Any algorithm works well
- **Medium Data (1K-10K logs):** K-means or Hierarchical
- **Large Data (> 10K logs):** K-means with selected features

## 📋 Key Metrics Explained

### Clustering Quality Metrics
- **Silhouette Score (-1 to 1):** Higher is better. Measures cluster cohesion and separation
- **Calinski-Harabasz:** Higher is better. Ratio of between-cluster to within-cluster variance
- **Davies-Bouldin (lower is better):** Average similarity between clusters

### Supervised Metrics (when ground truth available)
- **Adjusted Rand Index (-1 to 1):** Measures agreement with true clusters
- **Normalized Mutual Information (0 to 1):** Information theoretic measure

## 🔧 Customization Options

### Modify Clustering Parameters
```python
# In clustering notebook, adjust parameter ranges:
k_range = (2, 15)  # K-means clusters
eps_range = [0.1, 0.5, 1.0, 2.0]  # DBSCAN eps values
min_samples_range = [3, 5, 10, 20]  # DBSCAN min_samples
```

### Feature Engineering Customization
```python
# In feature extraction notebook, modify:
max_features = 100  # TF-IDF vocabulary size
n_components = 0.95  # PCA variance retention
k_best_features = 20  # Number of features to select
```

### Benchmarking Parameters
```python
# In benchmarking notebook, adjust:
n_samples = 1000  # Sample size for testing
test_iterations = 1  # Multiple runs for statistical significance
```

## 📊 Interpreting Results

### High-Quality Clustering Indicators
- Silhouette Score > 0.5
- Clear separation in 2D visualization
- Reasonable cluster sizes (>5% of data each)
- Consistent performance across feature sets

### Warning Signs
- Many small clusters (< 2% of data)
- High noise points in DBSCAN (> 20%)
- Poor silhouette scores (< 0.3)
- Inconsistent results across algorithms

## 🚀 Production Deployment Recommendations

### 1. Algorithm Selection
```python
# Use this decision tree:
if data_has_noise or varying_density:
    use DBSCAN
elif structure_is_nested:
    use Hierarchical
else:
    use KMeans
```

### 2. Feature Selection
```python
# Feature set recommendations:
if computational_resources_limited:
    use Selected_Features
elif visualization_important:
    use PCA_Features
else:
    use Scaled_Features
```

### 3. Monitoring & Validation
- Track cluster stability over time
- Validate with domain experts
- Monitor clustering quality metrics
- A/B test different configurations

## 🔍 Troubleshooting

### Common Issues and Solutions

**Issue: "Poor clustering results"**
- Check data preprocessing quality
- Try different feature sets
- Adjust clustering parameters
- Consider ensemble methods

**Issue: "Too many/few clusters"**
- Modify k range for K-means
- Adjust eps parameter for DBSCAN
- Use domain knowledge for validation

**Issue: "High computational cost"**
- Use selected features or PCA
- Reduce data sample size
- Use K-means instead of Hierarchical

## 📚 Additional Resources

### Scientific Papers
- Clustering validation metrics: Rousseeuw, P. J. (1987)
- DBSCAN algorithm: Ester et al. (1996)
- Silhouette analysis: Kaufman & Rousseeuw (1990)

### Documentation
- [Scikit-learn Clustering](https://scikit-learn.org/stable/modules/clustering.html)
- [Pandas Data Preprocessing](https://pandas.pydata.org/docs/)
- [Matplotlib Visualization](https://matplotlib.org/)

## 📝 Citation

If you use this analysis in your research or production systems, please cite:

```bibtex
@software{kubernetes_logs_clustering,
  title={Kubernetes Logs Clustering Analysis},
  author={Your Name},
  year={2024},
  url={https://github.com/your-repo/morph-synthlog-k8s}
}
```

## 🤝 Contributing

To extend this analysis:
1. Add new clustering algorithms
2. Implement additional evaluation metrics
3. Create new feature engineering methods
4. Improve visualization capabilities
5. Add real-time clustering capabilities

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Created for MORPH Project** - Advanced incident response platform with ML-powered log analysis