








# drift_detect.py - Lab 3: Statistical Drift Detection

import numpy as np
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split


# -----------------------------
# DRIFT THRESHOLDS
# -----------------------------
# WHY:
# Defines how much change is acceptable

PSI_SLIGHT = 0.1   # small drift → monitor
PSI_SEVERE = 0.2   # large drift → retrain


# < 0.1 → No drift (stable system)
# 0.1 - 0.2 → Slight drift (monitor)
# > 0.2 → Significant drift (retrain required)


# -----------------------------
# REFERENCE DATA (TRAINING DATA)
# -----------------------------
def get_reference_data():
    """
    WHY:
    This is the baseline (training data).
    All comparisons are done against this.
    """
    iris = load_iris()

    X_train, _, y_train, _ = train_test_split(
        iris.data,
        iris.target,
        test_size=0.2,
        random_state=42
    )

    return X_train, y_train


# -----------------------------
# PRODUCTION DATA (SIMULATED)
# -----------------------------
def get_production_data(drift_magnitude=0.8):
    """
    WHY:
    Simulates real production data with drift.
    """

    np.random.seed(99)

    iris = load_iris()
    X = iris.data.copy()

    # Introduce drift in features
    X[:, 0] += drift_magnitude * 1.5
    X[:, 2] += drift_magnitude * 0.8

    # Add noise
    X += np.random.normal(0, drift_magnitude * 0.3, X.shape)

    return X[:100], iris.target[:100]


# -----------------------------
# PSI CALCULATION
# -----------------------------
def compute_psi(reference, production, n_bins=10):
    """
    WHY:
    PSI (Population Stability Index) measures distribution change.
    """

    bins = np.linspace(reference.min(), reference.max(), n_bins + 1)

    ref_counts, _ = np.histogram(reference, bins=bins)
    prod_counts, _ = np.histogram(production, bins=bins)

    ref_pct = np.clip(ref_counts / len(reference), 1e-6, None)
    prod_pct = np.clip(prod_counts / len(production), 1e-6, None)

    psi = np.sum((prod_pct - ref_pct) * np.log(prod_pct / ref_pct))

    return psi


# -----------------------------
# KL DIVERGENCE
# -----------------------------
def compute_kl_divergence(reference, production, n_bins=10):
    """
    WHY:
    KL divergence gives another way to measure drift.
    Used for validation of PSI results.
    """

    bins = np.linspace(reference.min(), reference.max(), n_bins + 1)

    ref_counts, _ = np.histogram(reference, bins=bins)
    prod_counts, _ = np.histogram(production, bins=bins)

    ref_pct = np.clip(ref_counts / len(reference), 1e-6, None)
    prod_pct = np.clip(prod_counts / len(production), 1e-6, None)

    kl = np.sum(prod_pct * np.log(prod_pct / ref_pct))

    return kl


# -----------------------------
# FEATURE-LEVEL DRIFT
# -----------------------------
def detect_feature_drift(X_ref, X_prod, feature_names):
    """
    WHY:
    Drift may not happen in all features.
    So we check each feature separately.
    """

    results = []

    for i, name in enumerate(feature_names):

        psi = compute_psi(X_ref[:, i], X_prod[:, i])
        kl = compute_kl_divergence(X_ref[:, i], X_prod[:, i])

        # Classify drift severity
        if psi > PSI_SEVERE:
            severity = "severe"
        elif psi > PSI_SLIGHT:
            severity = "slight"
        else:
            severity = "none"

        results.append({
            "feature": name,
            "psi": psi,
            "kl_div": kl,
            "severity": severity,
            "alert": severity != "none"
        })

    return results


# -----------------------------
# PREDICTION DRIFT
# -----------------------------
def check_prediction_drift(model, X_ref, X_prod):
    """
    WHY:
    Checks if model predictions distribution changed.
    """

    ref_preds = model.predict(X_ref)
    prod_preds = model.predict(X_prod)

    ref_dist = np.bincount(ref_preds) / len(ref_preds)
    prod_dist = np.bincount(prod_preds) / len(prod_preds)

    drift = False
    changes = {}

    for i in range(len(ref_dist)):
        change = abs(prod_dist[i] - ref_dist[i])
        changes[i] = change

        if change > 0.15:
            drift = True

    return drift, changes


# -----------------------------
# FINAL DRIFT REPORT
# -----------------------------
def generate_drift_report(feature_results, pred_drift, pred_changes):
    """
    WHY:
    Converts technical metrics into simple decision.
    """

    severe = [r["feature"] for r in feature_results if r["severity"] == "severe"]
    slight = [r["feature"] for r in feature_results if r["severity"] == "slight"]

    if severe or pred_drift:
        status = "RED"
        recommendation = "Immediate retraining required"
    elif slight:
        status = "YELLOW"
        recommendation = "Monitor closely"
    else:
        status = "GREEN"
        recommendation = "System stable"

    return {
        "overall_status": status,
        "drifted_features": severe,
        "recommendation": recommendation
    }


# -----------------------------
# MAIN FUNCTION
# -----------------------------
def run_drift_detection():
    print("========== DRIFT DETECTION ==========")

    X_ref, y_ref = get_reference_data()
    X_prod, y_prod = get_production_data()

    feature_names = ["sepal_length", "sepal_width", "petal_length", "petal_width"]

    results = detect_feature_drift(X_ref, X_prod, feature_names)

    # Print results
    for r in results:
        print(f"{r['feature']} → PSI={round(r['psi'],4)} | KL={round(r['kl_div'],4)} | {r['severity']}")

    # Train simple model for prediction drift
    from sklearn.ensemble import RandomForestClassifier

    model = RandomForestClassifier(n_estimators=50, random_state=42)
    model.fit(X_ref, y_ref)

    pred_drift, pred_changes = check_prediction_drift(model, X_ref, X_prod)

    report = generate_drift_report(results, pred_drift, pred_changes)

    print("\nOVERALL STATUS:", report["overall_status"])
    print("RECOMMENDATION:", report["recommendation"])


# -----------------------------
# ENTRY POINT
# -----------------------------
if __name__ == "__main__":
    run_drift_detection()
















# -------------------------------------------------------
# REAL WORLD UNDERSTANDING
# -------------------------------------------------------
# In real-world systems, data keeps changing over time.
#
# Example:
# - User behavior changes in apps
# - Market trends change in finance
# - Sensor data changes in IoT systems
#
# If we don’t detect drift:
# - Model accuracy drops
# - Wrong predictions happen
#
# So companies continuously monitor data drift
# and retrain models when needed.




