import os
import json
import logging
import numpy as np

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

def compute_effective_dimension(cov_matrix: np.ndarray) -> float:
    """
    计算有效维度 (Effective Dimensionality): (Tr(Cov))^2 / Tr(Cov^2)
    用于评估约束增加与自由度缩减关系
    """
    eigenvalues = np.linalg.eigvalsh(cov_matrix)
    eigenvalues = np.maximum(eigenvalues, 1e-12) # 避免负值或0
    trace_val = np.sum(eigenvalues)
    trace_sq_val = np.sum(eigenvalues ** 2)
    
    eff_dim = (trace_val ** 2) / trace_sq_val
    return float(eff_dim)

def compute_knowledge_entropy(cov_matrix: np.ndarray) -> float:
    """
    计算知识熵 / 结构熵 (基于归一化协方差谱的 Shannon 熵)
    """
    eigenvalues = np.linalg.eigvalsh(cov_matrix)
    eigenvalues = eigenvalues[eigenvalues > 1e-12]
    p = eigenvalues / np.sum(eigenvalues)
    entropy = -np.sum(p * np.log(p))
    return float(entropy)

def run_htsie_pipeline(raw_data_path: str, output_dir: str = "data") -> str:
    """
    执行完整的 HTSIE 计算 Pipeline 并导出指标数据
    """
    logging.info(f"开始载入数据文件: {raw_data_path}")
    data = np.load(raw_data_path)
    
    # 1. 计算协方差矩阵 (Activation Covariance)
    cov_matrix = np.cov(data, rowvar=False)
    
    # 2. 计算核心物理/计算指标
    eff_dim = compute_effective_dimension(cov_matrix)
    entropy = compute_knowledge_entropy(cov_matrix)
    
    results = {
        "num_samples": data.shape[0],
        "feature_dim": data.shape[1],
        "effective_dimensionality": round(eff_dim, 4),
        "knowledge_entropy": round(entropy, 4),
        "status": "COMPUTED"
    }
    
    metrics_path = os.path.join(output_dir, "metrics.json")
    with open(metrics_path, "w", encoding="utf-8") as f:
        json.dump(results, f, indent=2, ensure_ascii=False)
        
    logging.info(f"计算完成，结果保存至: {metrics_path}")
    return metrics_path

if __name__ == "__main__":
    run_htsie_pipeline("data/raw_activations.npy")
