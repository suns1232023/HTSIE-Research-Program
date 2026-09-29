import os
import json
import logging
from datetime import datetime

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

def update_daily_markdown_report(metrics_path: str, report_path: str = "data/daily_log.md"):
    """
    更新 Markdown 每日报告文件
    """
    if not os.path.exists(metrics_path):
        raise FileNotFoundError(f"未找到指标文件: {metrics_path}")
        
    with open(metrics_path, "r", encoding="utf-8") as f:
        metrics = json.load(f)
        
    today_str = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    markdown_content = f"""
## 🔬 HTSIE Daily Automated Experiment Result ({today_str})

| Metric | Value |
| :--- | :--- |
| **Execution Time** | `{today_str}` |
| **Sample Count** | `{metrics.get('num_samples')}` |
| **Feature Space Dimension** | `{metrics.get('feature_dim')}` |
| **Effective Dimensionality ($d_{{eff}}$)** | **`{metrics.get('effective_dimensionality')}`** |
| **Knowledge Entropy ($S_{{k}}$)** | **`{metrics.get('knowledge_entropy')}`** |

---
"""
    
    os.makedirs(os.path.dirname(report_path), exist_ok=True)
    
    # 追加入日志文件中
    with open(report_path, "a", encoding="utf-8") as f:
        f.write(markdown_content)
        
    logging.info(f"报告更新成功，写回至: {report_path}")

if __name__ == "__main__":
    update_daily_markdown_report("data/metrics.json")
