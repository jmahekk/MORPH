# Quick Start Guide - Grafana Log Clustering

Get started with clustering analysis in under 5 minutes!

## 🚀 Quick Start (3 Steps)

### Step 1: Setup Environment
```bash
cd grafana-analysis-notebooks
./run_analysis.sh
# Select option 4 (Install requirements only)
```

### Step 2: Run Analysis
```bash
./run_analysis.sh
# Select option 1 (Run complete pipeline)
# OR select option 2 (Open JupyterLab for manual execution)
```

### Step 3: View Results
Open the generated `*_executed.ipynb` files or check the output CSV/PNG files.

---

## 📋 Prerequisites

- Python 3.8+
- 8GB+ RAM (16GB recommended)
- Grafana logs at: `../synthetic-log-generator/output/grafana/logs_2024-01-01.jsonl`

---

## 🎯 What You'll Get

After running the complete pipeline (15-30 minutes):

✅ **6 Executed Notebooks** with results
✅ **40+ Output Files** including:
   - Cluster assignments (CSV)
   - Performance metrics (JSON)
   - Visualizations (PNG)
   - Trained models (PKL)

---

## 📊 Quick Results Overview

### Clustering Comparison Results

| Algorithm | Speed | Quality | Best For |
|-----------|-------|---------|----------|
| K-Means | ⚡⚡⚡ | ⭐⭐⭐⭐ | Production monitoring |
| Hierarchical | ⚡ | ⭐⭐⭐ | Exploratory analysis |
| DBSCAN | ⚡⚡ | ⭐⭐⭐ | Anomaly detection |

---

## 📖 Notebook Execution Order

Must be executed in sequence:

1. **Preprocessing** → 2. **Feature Extraction** → 3-5. **Clustering** (any order) → 6. **Comparison**

---

## 🔍 Quick Troubleshooting

**Error: File not found**
```bash
# Check if Grafana logs exist
ls ../synthetic-log-generator/output/grafana/logs_2024-01-01.jsonl
```

**Error: Memory error**
```bash
# Reduce sample size in notebook 4
# Edit MAX_SAMPLES = 5000 (default: 10000)
```

**Error: Module not found**
```bash
# Reinstall requirements
pip install -r requirements.txt
```

---

## 💡 Tips

- **First time?** Run option 2 (JupyterLab) to execute notebooks manually and see outputs
- **Batch mode?** Run option 1 for automatic execution of all notebooks
- **Specific step?** Run option 3 to execute individual notebooks
- **Large dataset?** Consider sampling in preprocessing step

---

## 📚 Documentation

- **README.md** - Complete documentation
- **SUMMARY.md** - Detailed analysis summary
- **Notebook comments** - Inline explanations

---

## 🤝 Need Help?

1. Check notebook comments
2. Review README.md
3. Check SUMMARY.md for interpretations
4. Review error messages in executed notebooks

---

## 🎓 Example: Manual Execution

```bash
# Activate environment
cd grafana-analysis-notebooks
source venv/bin/activate

# Start JupyterLab
jupyter lab

# Execute notebooks in order:
# 1_preprocessing.ipynb
# 2_feature_extraction.ipynb
# 3_kmeans_clustering.ipynb
# 4_hierarchical_clustering.ipynb
# 5_dbscan_clustering.ipynb
# 6_clustering_comparison.ipynb
```

---

## 🔗 Next Steps After Quick Start

1. ✅ Review `clustering_comparison_report.json` for recommendations
2. ✅ Check visualizations in PNG files
3. ✅ Analyze cluster assignments in CSV files
4. ✅ Read SUMMARY.md for detailed insights
5. ✅ Integrate models into production (see README.md)

---

**Ready to start?** Run `./run_analysis.sh` now! 🚀
