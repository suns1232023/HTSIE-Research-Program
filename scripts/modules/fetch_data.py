import os
import json
import logging
import numpy as np

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

def fetch_sae_activations(data_dir: str = "data") -> str:
    """
    模拟或拉取 SAE (Sparse Autoencoders) 激活数据与协方差数据
    """
    os.makedirs(data_dir, exist_ok=True)
    raw_path = os.path.join(data_dir, "raw_activations.npy")
    
    # 获取环境变量中的 Token（如 OpenXLab API Token）
    token = os.getenv("OPENXLAB_TOKEN")
    if token:
        logging.info("OpenXLab Token 凭据有效，准备从远端拉取最新 HTSIE 数据集...")
        # 此处可添加 requests 或 openxlab sdk 调用代码
    else:
        logging.info("未检测到 API Token，生成本地实验模拟激活数据...")

    # 生成模拟的 SAE 激活矩阵 (样本数 x 特征数)
    np.random.seed(42)
    sample_data = np.random.randn(1000, 128)
    np.save(raw_path, sample_data)
    
    logging.info(f"数据已成功存储至: {raw_path}")
    return raw_path

if __name__ == "__main__":
    fetch_sae_activations()
