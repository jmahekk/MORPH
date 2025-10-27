#!/bin/bash

# Grafana Log Clustering Analysis - Quick Start Script
# This script helps you set up and run the complete analysis pipeline

set -e

echo "=========================================="
echo "Grafana Log Clustering Analysis Pipeline"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Error: Python 3 is not installed${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Python 3 found${NC}"

# Check if we're in the right directory
if [ ! -f "requirements.txt" ]; then
    echo -e "${RED}Error: requirements.txt not found. Please run this script from the grafana-analysis-notebooks directory${NC}"
    exit 1
fi

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo -e "${YELLOW}Creating virtual environment...${NC}"
    python3 -m venv venv
    echo -e "${GREEN}✓ Virtual environment created${NC}"
else
    echo -e "${GREEN}✓ Virtual environment already exists${NC}"
fi

# Activate virtual environment
echo -e "${YELLOW}Activating virtual environment...${NC}"
source venv/bin/activate
echo -e "${GREEN}✓ Virtual environment activated${NC}"

# Install requirements
echo -e "${YELLOW}Installing requirements...${NC}"
pip install --upgrade pip > /dev/null 2>&1
pip install -r requirements.txt > /dev/null 2>&1
echo -e "${GREEN}✓ Requirements installed${NC}"

# Check if data file exists
DATA_FILE="../synthetic-log-generator/output/grafana/logs_2024-01-01.jsonl"
if [ ! -f "$DATA_FILE" ]; then
    echo -e "${RED}Error: Grafana log file not found at $DATA_FILE${NC}"
    echo "Please ensure the synthetic-log-generator has been run and logs are available."
    exit 1
fi

echo -e "${GREEN}✓ Grafana log file found${NC}"

# Display menu
echo ""
echo "=========================================="
echo "What would you like to do?"
echo "=========================================="
echo "1. Run complete analysis pipeline (all notebooks)"
echo "2. Open JupyterLab (manual execution)"
echo "3. Run specific notebook"
echo "4. Install requirements only"
echo "5. Exit"
echo ""

read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo ""
        echo -e "${YELLOW}Running complete analysis pipeline...${NC}"
        echo -e "${YELLOW}This may take 15-30 minutes depending on data size${NC}"
        echo ""
        
        echo "Step 1/6: Preprocessing..."
        jupyter nbconvert --to notebook --execute 1_preprocessing.ipynb --output 1_preprocessing_executed.ipynb
        echo -e "${GREEN}✓ Preprocessing complete${NC}"
        
        echo "Step 2/6: Feature Extraction..."
        jupyter nbconvert --to notebook --execute 2_feature_extraction.ipynb --output 2_feature_extraction_executed.ipynb
        echo -e "${GREEN}✓ Feature extraction complete${NC}"
        
        echo "Step 3/6: K-Means Clustering..."
        jupyter nbconvert --to notebook --execute 3_kmeans_clustering.ipynb --output 3_kmeans_clustering_executed.ipynb
        echo -e "${GREEN}✓ K-Means clustering complete${NC}"
        
        echo "Step 4/6: Hierarchical Clustering..."
        jupyter nbconvert --to notebook --execute 4_hierarchical_clustering.ipynb --output 4_hierarchical_clustering_executed.ipynb
        echo -e "${GREEN}✓ Hierarchical clustering complete${NC}"
        
        echo "Step 5/6: DBSCAN Clustering..."
        jupyter nbconvert --to notebook --execute 5_dbscan_clustering.ipynb --output 5_dbscan_clustering_executed.ipynb
        echo -e "${GREEN}✓ DBSCAN clustering complete${NC}"
        
        echo "Step 6/6: Comparison and Benchmarking..."
        jupyter nbconvert --to notebook --execute 6_clustering_comparison.ipynb --output 6_clustering_comparison_executed.ipynb
        echo -e "${GREEN}✓ Comparison complete${NC}"
        
        echo ""
        echo -e "${GREEN}=========================================="
        echo "✓ Complete analysis pipeline finished!"
        echo "==========================================${NC}"
        echo ""
        echo "Results are available in:"
        echo "  - CSV files (cluster assignments, metrics)"
        echo "  - JSON files (detailed metrics)"
        echo "  - PNG files (visualizations)"
        echo "  - Executed notebooks (*_executed.ipynb)"
        echo ""
        echo "To view results, open the executed notebooks or check the output files."
        ;;
    
    2)
        echo ""
        echo -e "${YELLOW}Starting JupyterLab...${NC}"
        echo "JupyterLab will open in your default browser"
        echo "Press Ctrl+C to stop JupyterLab when done"
        echo ""
        jupyter lab
        ;;
    
    3)
        echo ""
        echo "Available notebooks:"
        echo "1. Preprocessing"
        echo "2. Feature Extraction"
        echo "3. K-Means Clustering"
        echo "4. Hierarchical Clustering"
        echo "5. DBSCAN Clustering"
        echo "6. Comparison and Benchmarking"
        echo ""
        read -p "Enter notebook number to run (1-6): " nb_choice
        
        case $nb_choice in
            1) jupyter nbconvert --to notebook --execute 1_preprocessing.ipynb --output 1_preprocessing_executed.ipynb ;;
            2) jupyter nbconvert --to notebook --execute 2_feature_extraction.ipynb --output 2_feature_extraction_executed.ipynb ;;
            3) jupyter nbconvert --to notebook --execute 3_kmeans_clustering.ipynb --output 3_kmeans_clustering_executed.ipynb ;;
            4) jupyter nbconvert --to notebook --execute 4_hierarchical_clustering.ipynb --output 4_hierarchical_clustering_executed.ipynb ;;
            5) jupyter nbconvert --to notebook --execute 5_dbscan_clustering.ipynb --output 5_dbscan_clustering_executed.ipynb ;;
            6) jupyter nbconvert --to notebook --execute 6_clustering_comparison.ipynb --output 6_clustering_comparison_executed.ipynb ;;
            *) echo -e "${RED}Invalid choice${NC}"; exit 1 ;;
        esac
        
        echo -e "${GREEN}✓ Notebook execution complete${NC}"
        ;;
    
    4)
        echo -e "${GREEN}✓ Requirements already installed${NC}"
        ;;
    
    5)
        echo "Exiting..."
        exit 0
        ;;
    
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo "Done!"
