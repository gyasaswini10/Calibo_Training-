











# monitor.py - Lab 6: Production Monitor + Auto-Retraining
# -------------------------------------------------------
# WHY THIS FILE IS USED
# -------------------------------------------------------
# This file continuously monitors the model after deployment.
#
# Even after successful deployment, model performance can degrade
# due to changing data (data drift or concept drift).
#
# This file ensures:
# 1. Accuracy is tracked over time
# 2. Data drift is detected
# 3. Retraining is triggered automatically if needed
# 4. System avoids too frequent retraining (circuit breaker)
#
# It acts like a "health monitoring system" for ML models.






# monitor.py - Automated Monitoring System

import numpy as np
import json
from datetime import datetime, timedelta


# -----------------------------
# CONFIGURATION
# -----------------------------
# WHY:
# Central place for all monitoring thresholds

MONITOR_CONFIG = {
    "baseline_accuracy": 0.88,          # expected accuracy
    "accuracy_drop_threshold": 0.05,   # allowed drop
    "max_retrains_per_day": 3,         # circuit breaker
    "min_hours_between_retrains": 2    # avoid frequent retrain
}

# Stores retrain timestamps
retrain_log = []


# -----------------------------
# ACCURACY CHECK
# -----------------------------
def check_accuracy(predictions, true_labels):
    """
    WHY:
    Checks if model performance dropped compared to baseline.
    """

    try:
        # Calculate accuracy
        correct = (predictions == true_labels).sum()
        accuracy = correct / len(predictions)

        # Calculate drop from baseline
        drop = MONITOR_CONFIG["baseline_accuracy"] - accuracy
        threshold = MONITOR_CONFIG["accuracy_drop_threshold"]

        # Alert condition
        alert = drop > threshold

        # Severity classification
        if drop > 2 * threshold:
            severity = "critical"
        elif alert:
            severity = "warning"
        else:
            severity = "none"

        return {
            "accuracy": accuracy,
            "drop_from_baseline": drop,
            "alert": alert,
            "severity": severity
        }

    except Exception as e:
        print("Error in accuracy check:", e)
        return None


# -----------------------------
# Z-SCORE DRIFT DETECTION
# -----------------------------
def detect_drift_zscore(ref_means, prod_means, ref_stds, feature_names):
    """
    WHY:
    Detects feature drift using Z-score method.
    """

    results = []

    try:
        for i, name in enumerate(feature_names):

            # Z-score formula
            score = abs(float(prod_means[i]) - float(ref_means[i])) / float(ref_stds[i])

            results.append({
                "feature": name,
                "drift_score": score,
                "drifted": score > 2.0   # threshold
            })

    except Exception as e:
        print("Error in drift detection:", e)

    return results


# -----------------------------
# CIRCUIT BREAKER
# -----------------------------
def can_retrain():
    """
    WHY:
    Prevents too many retraining triggers.
    """

    now = datetime.utcnow()

    # Last 24 hours retrain history
    last_24h = [t for t in retrain_log if now - t < timedelta(hours=24)]

    # Max retrain limit
    if len(last_24h) >= MONITOR_CONFIG["max_retrains_per_day"]:
        return False, "Max daily retrains reached"

    # Time gap check
    if last_24h:
        hours_since = (now - max(last_24h)).seconds / 3600

        if hours_since < MONITOR_CONFIG["min_hours_between_retrains"]:
            return False, f"Too soon: {hours_since:.1f}h since last retrain"

    return True, ""


# -----------------------------
# TRIGGER RETRAINING
# -----------------------------
def trigger_retraining(reason, severity):
    """
    WHY:
    Simulates triggering CI/CD retraining pipeline.
    """

    retrain_log.append(datetime.utcnow())

    payload = {
        "ref": "main",
        "inputs": {
            "trigger_reason": reason,
            "severity": severity
        }
    }

    print(json.dumps(payload, indent=2))

    triggered = True
    run_url = "https://github.com/myorg/ml-pipeline/actions/runs/99999"

    return triggered, run_url


# -----------------------------
# GENERATE ALERT
# -----------------------------
def generate_alert(acc_result, drift_results, retrain_allowed, retrain_triggered, retrain_url):
    """
    WHY:
    Converts monitoring results into simple output.
    """

    status = "GREEN"

    if acc_result["severity"] == "critical":
        status = "RED"
    elif acc_result["severity"] == "warning" or any(d["drifted"] for d in drift_results):
        status = "YELLOW"

    return {
        "status": status,
        "accuracy": round(acc_result["accuracy"], 4),
        "drop": round(acc_result["drop_from_baseline"], 4),
        "drift_detected": any(d["drifted"] for d in drift_results),
        "can_retrain": retrain_allowed,
        "retrain_triggered": retrain_triggered,
        "retrain_url": retrain_url if retrain_triggered else None
    }


# -----------------------------
# MAIN MONITOR FUNCTION
# -----------------------------
def monitor(predictions, true_labels, ref_means, prod_means, ref_stds, feature_names):
    """
    WHY:
    Main function that combines all monitoring checks.
    """

    print(f"MONITORING - {datetime.utcnow().isoformat()}")

    # Accuracy check
    acc_result = check_accuracy(predictions, true_labels)

    print(f"[ACCURACY] {round(acc_result['accuracy'],2)} | drop={round(acc_result['drop_from_baseline'],3)}")

    # Drift check
    drift_results = detect_drift_zscore(ref_means, prod_means, ref_stds, feature_names)

    for d in drift_results:
        print(f"[DRIFT] {d['feature']} → {round(d['drift_score'],2)}")

    # Decide reason
    reason = None
    if acc_result["severity"] == "critical":
        reason = "Accuracy drop"
    elif any(d["drifted"] for d in drift_results):
        reason = "Feature drift"

    retrain_triggered = False
    retrain_url = None
    retrain_allowed = True

    # Retraining decision
    if reason:
        allowed, msg = can_retrain()
        retrain_allowed = allowed

        if allowed:
            retrain_triggered, retrain_url = trigger_retraining(reason, acc_result["severity"])
            print("[RETRAIN] Triggered")
        else:
            print("[BLOCKED]", msg)

    # Generate alert
    alert = generate_alert(
        acc_result,
        drift_results,
        retrain_allowed,
        retrain_triggered,
        retrain_url
    )

    print("\nFINAL STATUS:", alert["status"])

    return alert


# -----------------------------
# TEST RUN
# -----------------------------
if __name__ == "__main__":
    predictions = np.array([0, 1, 2, 1, 0])
    true_labels = np.array([0, 1, 2, 2, 0])

    ref_means = [5.0, 3.5, 1.4, 0.2]
    prod_means = [5.3, 3.6, 1.6, 0.25]
    ref_stds = [0.5, 0.4, 0.3, 0.2]

    feature_names = ["sepal_length", "sepal_width", "petal_length", "petal_width"]

    monitor(predictions, true_labels, ref_means, prod_means, ref_stds, feature_names)












# -------------------------------------------------------
# REAL WORLD UNDERSTANDING
# -------------------------------------------------------
# In real companies:
# Models are NOT "train once and forget"
#
# Example:
# - Fraud detection model
# - Recommendation system
#
# Over time:
# - User behavior changes
# - Data distribution changes
#
# So we continuously monitor:
# - Accuracy drop
# - Feature drift
#
# If issues detected → automatically retrain model
#
# This file simulates a real MLOps monitoring system.







