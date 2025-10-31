# Project Summary: Grafana Logs ML Analysis

## Overview

This project provides a complete machine learning pipeline for analyzing Grafana logs from the MORPH incident response platform. It includes preprocessing, feature extraction, and three clustering algorithms (K-means, Hierarchical, DBSCAN) with comprehensive benchmarking and comparison.

## Deliverables

### ✅ Completed Tasks

1. **Data Preprocessing Notebook** (`01_data_preprocessing.ipynb`)
   - ✓ Loads 150,000 Grafana logs from JSONL format
   - ✓ Handles missing values appropriately
   - ✓ Extracts temporal features (hour, day_of_week, is_weekend, etc.)
   - ✓ Normalizes values per unit type (critical for Grafana logs with mixed units)
   - ✓ Creates rolling statistics (mean, std, min, max)
   - ✓ Visualizes data distributions and temporal patterns
   - ✓ Saves preprocessed data for next stages

2. **Feature Extraction Notebook** (`02_feature_extraction.ipynb`)
   - ✓ Label encodes categorical variables (dashboard, panel, service, etc.)
   - ✓ Extracts query pattern features from Prometheus queries
   - ✓ Creates interaction features (service_panel, dashboard_panel)
   - ✓ Calculates aggregated statistics (service-level, panel-level, dashboard-level)
   - ✓ Creates deviation features (z-scores, deviations from means)
   - ✓ Performs PCA analysis for dimensionality understanding
   - ✓ Analyzes feature importance using Random Forest
   - ✓ Saves feature matrix and metadata

3. **K-means Clustering Notebook** (`03_kmeans_clustering.ipynb`)
   - ✓ Determines optimal k using Elbow method
   - ✓ Evaluates multiple k values with Silhouette score
   - ✓ Tests Davies-Bouldin and Calinski-Harabasz metrics
   - ✓ Applies K-means with optimal parameters
   - ✓ Evaluates internal validation metrics
   - ✓ Compares against true anomaly labels (external validation)
   - ✓ Creates silhouette plots
   - ✓ Visualizes clusters using PCA
   - ✓ Analyzes cluster characteristics
   - ✓ Benchmarks training time
   - ✓ Saves results and metrics

4. **Hierarchical Clustering Notebook** (`04_hierarchical_clustering.ipynb`)
   - ✓ Creates dendrograms for different linkage methods
   - ✓ Tests ward, complete, average, and single linkage
   - ✓ Determines optimal number of clusters
   - ✓ Applies Agglomerative clustering
   - ✓ Evaluates all validation metrics
   - ✓ Creates silhouette plots
   - ✓ Visualizes clusters using PCA
   - ✓ Compares linkage methods
   - ✓ Analyzes cluster characteristics
   - ✓ Benchmarks training time
   - ✓ Saves results and metrics

5. **DBSCAN Clustering Notebook** (`05_dbscan_clustering.ipynb`)
   - ✓ Uses k-distance graph to determine optimal eps
   - ✓ Performs parameter grid search (eps and min_samples)
   - ✓ Visualizes parameter search results with heatmaps
   - ✓ Applies DBSCAN with optimal parameters
   - ✓ Identifies noise points (potential outliers/anomalies)
   - ✓ Evaluates metrics (excluding noise for fair comparison)
   - ✓ Analyzes noise points as anomaly indicators
   - ✓ Visualizes clusters with noise highlighted
   - ✓ Benchmarks training time
   - ✓ Saves results and metrics

6. **Comprehensive Comparison Notebook** (`06_comprehensive_comparison.ipynb`)
   - ✓ Loads results from all three algorithms
   - ✓ Creates combined metrics comparison table
   - ✓ Visualizes performance across all metrics
   - ✓ Compares internal validation metrics (bar charts)
   - ✓ Compares external validation metrics (bar charts)
   - ✓ Analyzes cluster size distributions
   - ✓ Creates side-by-side PCA visualizations
   - ✓ Analyzes anomaly detection performance
   - ✓ Calculates enrichment factors
   - ✓ Ranks algorithms by overall performance
   - ✓ Provides clear recommendations
   - ✓ Saves comprehensive comparison results

### 📊 Metrics Implemented

#### Internal Validation
- ✓ Silhouette Score
- ✓ Davies-Bouldin Index
- ✓ Calinski-Harabasz Score
- ✓ Inertia (K-means)

#### External Validation
- ✓ Adjusted Rand Index (ARI)
- ✓ Normalized Mutual Information (NMI)
- ✓ Homogeneity Score
- ✓ Completeness Score
- ✓ V-measure Score

#### Performance Benchmarking
- ✓ Training time measurement
- ✓ Scalability analysis
- ✓ Memory efficiency considerations

#### Anomaly Detection Metrics
- ✓ Enrichment factor (cluster vs. random)
- ✓ Anomaly rate per cluster
- ✓ Noise point analysis (DBSCAN)

### 📁 Documentation

1. **README.md**
   - ✓ Project overview and structure
   - ✓ Grafana-specific issues and solutions
   - ✓ Usage instructions
   - ✓ Evaluation metrics explanation
   - ✓ Feature descriptions
   - ✓ Algorithm comparison
   - ✓ Integration with MORPH

2. **QUICKSTART.md**
   - ✓ Quick installation guide
   - ✓ Step-by-step execution instructions
   - ✓ Expected runtime estimates
   - ✓ Output file descriptions
   - ✓ Troubleshooting section
   - ✓ Success criteria

3. **requirements.txt**
   - ✓ All necessary dependencies
   - ✓ Version specifications

4. **.gitignore**
   - ✓ Python artifacts
   - ✓ Jupyter checkpoints
   - ✓ Data files (excluded from version control)
   - ✓ IDE and OS files

## Key Features

### Grafana-Specific Preprocessing
1. **Mixed Units Handling**: Normalizes within each unit type separately
2. **Temporal Feature Extraction**: Hour, day_of_week, business hours, weekend flags
3. **Rolling Statistics**: Window-based mean, std, min, max for time-series context
4. **Service/Panel Aggregations**: Group-level statistics for context
5. **Query Pattern Recognition**: Extracts features from Prometheus queries

### Comprehensive Feature Engineering
- 40+ features extracted
- Temporal, statistical, categorical, and interaction features
- PCA analysis for dimensionality understanding
- Feature importance analysis with Random Forest

### Multiple Clustering Algorithms
1. **K-means**: Fast, scalable, good for spherical clusters
2. **Hierarchical**: Creates hierarchy, flexible linkage methods
3. **DBSCAN**: Finds arbitrary shapes, identifies outliers, no k needed

### Thorough Evaluation
- Multiple internal validation metrics
- External validation against true anomaly labels
- Performance benchmarking
- Anomaly detection effectiveness analysis
- Visual comparisons with PCA projections

### Actionable Insights
- Clear algorithm ranking
- Recommendations based on use case
- Enrichment factors for anomaly detection
- Comprehensive comparison tables

## Technical Specifications

### Data
- **Source**: `synthetic-log-generator/output/grafana/ml_training_data.jsonl`
- **Size**: 150,000 log entries
- **Format**: JSONL (one JSON object per line)
- **Fields**: timestamp, dashboard, panel, service, value, unit, environment, cluster, datasource, is_anomaly, anomaly_type, query, metadata

### Feature Matrix
- **Dimensions**: 150,000 rows × 40+ columns
- **Feature Types**: Numeric (continuous, temporal, statistical), Categorical (encoded)
- **Normalization**: StandardScaler per unit type, then global scaling for clustering

### Algorithms
- **K-means**: scikit-learn KMeans with optimal k selection
- **Hierarchical**: scikit-learn AgglomerativeClustering with linkage comparison
- **DBSCAN**: scikit-learn DBSCAN with parameter grid search

### Visualization
- **Dimensionality Reduction**: PCA (2 components for visualization)
- **Plot Types**: Histograms, bar charts, line plots, scatter plots, heatmaps, dendrograms, silhouette plots
- **Libraries**: matplotlib, seaborn

## Performance Expectations

### Full Dataset (150,000 records)
- Preprocessing: ~2 minutes
- Feature Extraction: ~3 minutes
- K-means: ~5 minutes
- Hierarchical: ~10 minutes
- DBSCAN: ~8 minutes
- Comparison: ~1 minute
- **Total**: ~29 minutes

### Sample Dataset (10,000 records)
- **Total**: ~2 minutes

## Use Cases

1. **Incident Response**: Identify clusters of related log patterns for faster root cause analysis
2. **Anomaly Detection**: Detect unusual patterns that may indicate incidents
3. **Capacity Planning**: Understand normal operation patterns vs. peak usage
4. **Alert Tuning**: Reduce false positives by understanding natural log groupings
5. **Performance Optimization**: Identify services/panels with unusual behavior

## Integration with MORPH

This analysis pipeline integrates with the MORPH platform:

- **Input**: Grafana MCP Server logs
- **Processing**: ML-based clustering and anomaly detection
- **Output**: Cluster assignments, anomaly scores, feature importance
- **Correlation**: Results feed into cross-source correlation engine
- **Action**: Automated incident detection and LLM-assisted remediation

## Future Enhancements

Potential improvements:
1. **Real-time Clustering**: Stream processing for live logs
2. **Incremental Learning**: Update clusters without full retraining
3. **Additional Algorithms**: Try HDBSCAN, Gaussian Mixture Models, Spectral Clustering
4. **Feature Selection**: Automated feature importance-based selection
5. **Hyperparameter Tuning**: Grid/random search for all algorithms
6. **Ensemble Methods**: Combine multiple clustering results
7. **Temporal Clustering**: Account for time-series nature explicitly
8. **Cross-Source Features**: Incorporate Kubernetes, Sentry, CloudWatch data

## Validation

All notebooks have been tested for:
- ✓ Correct data loading and preprocessing
- ✓ Proper feature engineering
- ✓ Algorithm execution without errors
- ✓ Metric calculation accuracy
- ✓ Visualization generation
- ✓ Results persistence

## Success Metrics

The project successfully:
- ✓ Processes 150,000 Grafana logs
- ✓ Extracts 40+ meaningful features
- ✓ Applies 3 different clustering algorithms
- ✓ Evaluates with 10+ metrics
- ✓ Provides comprehensive comparison
- ✓ Generates actionable recommendations
- ✓ Includes complete documentation
- ✓ Ready for production deployment

## Conclusion

This project delivers a complete, production-ready ML analysis pipeline for Grafana logs. It addresses Grafana-specific challenges, implements best practices in feature engineering and clustering, provides comprehensive evaluation, and includes extensive documentation for easy adoption.

The modular notebook structure allows for:
- Easy customization and extension
- Clear understanding of each processing step
- Reproducible results
- Integration with existing systems

All deliverables are complete, tested, and ready for use in the MORPH incident response platform.
