import logging
from experiments.sae_geometry import SAEGeometryExperiment
from experiments.cross_system import CrossSystemExperiment

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

def run_all_experiments() -> dict:
    """
    统一调度所有 HTSIE 实验子模块，汇总实验结果
    """
    logging.info("=== 启动 HTSIE 实验流水线 ===")
    
    # 1. 运行 SAE 几何实验
    sae_exp = SAEGeometryExperiment()
    sae_results = sae_exp.run()
    
    # 2. 运行跨系统对比实验
    cross_exp = CrossSystemExperiment()
    cross_results = cross_exp.run_spectral_dimension_flow()
    
    combined_results = {
        "sae_experiment": sae_results,
        "cross_system_experiment": cross_results
    }
    
    logging.info("=== 所有实验模块执行结束 ===")
    return combined_results

if __name__ == "__main__":
    run_all_experiments()
