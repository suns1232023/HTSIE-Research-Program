
import os
import json
import logging
from datetime import datetime, timezone
import numpy as np

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")


def compute_effective_dimension(cov_matrix: np.ndarray) -> float:
    """
    Compute Effective Dimensionality (participation ratio):

        d_eff = (Tr(Cov))² / Tr(Cov²)
              = (Σλ_i)² / Σλ_i²

    Measures how many eigenvalues contribute meaningfully to the
    covariance structure. Higher d_eff → more distributed representation.
    """
    eigenvalues = np.linalg.eigvalsh(cov_matrix)
    eigenvalues = np.maximum(eigenvalues, 1e-12)   # guard against numerical negatives
    trace_val    = np.sum(eigenvalues)
    trace_sq_val = np.sum(eigenvalues ** 2)
    return float((trace_val ** 2) / trace_sq_val)


def compute_knowledge_entropy(cov_matrix: np.ndarray) -> float:
    """
    Compute Knowledge Entropy (spectral Shannon entropy):

        S_k = -Σ p_i log(p_i),  p_i = λ_i / Σλ_j

    Measures the spread of the eigenvalue distribution.
    Higher S_k → more uniform spectral distribution.
    """
    eigenvalues = np.linalg.eigvalsh(cov_matrix)
    eigenvalues = eigenvalues[eigenvalues > 1e-12]
    p = eigenvalues / np.sum(eigenvalues)
    return float(-np.sum(p * np.log(p)))


def compute_sae_sparsity(data: np.ndarray) -> float:
    """
    Compute SAE activation sparsity: fraction of zero (or near-zero) entries.

    :param data: Activation matrix (samples × features)
    :return: Sparsity ratio in [0, 1]
    """
    return float(np.mean(np.abs(data) < 1e-8))


def run_htsie_pipeline(raw_data_path: str, output_dir: str = "data") -> str:
    """
    Execute the full HTSIE computation pipeline and export metrics.

    Outputs data/metrics.json with:
      - timestamp, date
      - num_samples, feature_dim
      - effective_dimensionality (d_eff)
      - knowledge_entropy (S_k)
      - sae_sparsity
      - status
    """
    logging.info(f"Loading data file: {raw_data_path}")
    data = np.load(raw_data_path)

    # 1. Activation covariance matrix
    cov_matrix = np.cov(data, rowvar=False)

    # 2. Core structural metrics
    eff_dim = compute_effective_dimension(cov_matrix)
    entropy = compute_knowledge_entropy(cov_matrix)
    sparsity = compute_sae_sparsity(data)

    # 3. Timestamp (UTC)
    now = datetime.now(timezone.utc)
    timestamp = now.strftime("%Y-%m-%dT%H:%M:%SZ")
    date      = now.strftime("%Y-%m-%d")

    results = {
        "timestamp":               timestamp,
        "date":                    date,
        "num_samples":             int(data.shape[0]),
        "feature_dim":             int(data.shape[1]),
        "effective_dimensionality": round(eff_dim,  4),
        "knowledge_entropy":        round(entropy,  4),
        "sae_sparsity":             round(sparsity, 4),
        "status":                  "COMPUTED",
    }

    os.makedirs(output_dir, exist_ok=True)
    metrics_path = os.path.join(output_dir, "metrics.json")
    with open(metrics_path, "w", encoding="utf-8") as f:
        json.dump(results, f, indent=2, ensure_ascii=False)
        f.write("\n")

    logging.info(
        f"Pipeline complete — d_eff={eff_dim:.4f}, "
        f"S_k={entropy:.4f}, sparsity={sparsity:.4f} → {metrics_path}"
    )
    return metrics_path


if __name__ == "__main__":
    run_htsie_pipeline("data/raw_activations.npy")
