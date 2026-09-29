import numpy as np
import logging

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

class SAEGeometryExperiment:
    """
    HTSIE-SAE 稀疏表示几何实验模块
    用于分析 SAE 激活值的协方差矩阵、特征结构及表征几何特性
    """
    def __init__(self, sample_size: int = 1000, feature_dim: int = 128):
        self.sample_size = sample_size
        self.feature_dim = feature_dim

    def generate_simulated_activations(self) -> np.ndarray:
        """模拟 SAE 激活矩阵 (样本数 x 特征维度)"""
        logging.info(f"生成 SAE 模拟激活数据: {self.sample_size} 样本 x {self.feature_dim} 维")
        # 产生带有稀疏度与非线性相关性的特征矩阵
        raw_data = np.random.exponential(scale=1.0, size=(self.sample_size, self.feature_dim))
        mask = np.random.rand(*raw_data.shape) > 0.8  # 稀疏掩码
        return raw_data * mask

    def run(self) -> dict:
        """执行 SAE 表示几何分析主流程"""
        activations = self.generate_simulated_activations()
        cov_matrix = np.cov(activations, rowvar=False)
        
        # 计算特征奇异值谱
        singular_values = np.linalg.svd(cov_matrix, compute_uv=False)
        
        return {
            "experiment_name": "HTSIE-SAE Geometry Analysis",
            "activation_sparsity": float(np.mean(activations == 0)),
            "top_singular_value": float(singular_values[0]),
            "spectrum_tail_ratio": float(np.sum(singular_values[10:]) / np.sum(singular_values))
        }

if __name__ == "__main__":
    exp = SAEGeometryExperiment()
    results = exp.run()
    logging.info(f"SAE 实验完成，结果: {results}")
