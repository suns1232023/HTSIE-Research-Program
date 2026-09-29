import sys
import os

# 将 modules 加入环境变量路径
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from modules.fetch_data import fetch_sae_activations
from modules.run_computations import run_htsie_pipeline
from modules.generate_reports import update_daily_markdown_report

def main():
    print("=== Starting HTSIE Daily Workflow ===")
    
    # 1. 抓取/准备数据
    raw_data_path = fetch_sae_activations(data_dir="data")
    
    # 2. 运行计算
    metrics_path = run_htsie_pipeline(raw_data_path=raw_data_path, output_dir="data")
    
    # 3. 生成并写回报告
    update_daily_markdown_report(metrics_path=metrics_path, report_path="data/daily_log.md")
    
    print("=== HTSIE Daily Workflow Completed Successfully ===")

if __name__ == "__main__":
    main()
