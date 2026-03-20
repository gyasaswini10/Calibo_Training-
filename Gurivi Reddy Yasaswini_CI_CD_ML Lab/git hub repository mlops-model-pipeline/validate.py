









# validate.py - Lab 2: Model Validation Gates

# -------------------------------------------------------
# WHY THIS FILE IS USED
# -------------------------------------------------------
# This file is responsible for validating the trained model
# before it is deployed to production.
#
# Even if a model trains successfully, it should not be used
# directly unless it passes certain quality checks.
#
# This file ensures:
# 1. Model meets performance requirements
# 2. No regression compared to previous model
# 3. Data format is correct (schema validation)
# 4. Model treats all classes fairly
#
# It acts like a "quality gate" in the ML pipeline.





import numpy as np
from sklearn.metrics import accuracy_score, f1_score, recall_score
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split


# -----------------------------
# THRESHOLDS (QUALITY RULES)
# -----------------------------
# WHY:
# Defines minimum acceptable performance
# Acts like "rules" model must satisfy

THRESHOLDS = {
# WHY THESE VALUES:
# Accuracy 0.85 → ensures model is reasonably good (not random)
# F1 score 0.80 → balances precision and recall
# Regression tolerance → small drop allowed due to data variation
# Per-class recall → ensures fairness across all classes

    "min_accuracy": 0.85,              # minimum acceptable accuracy
    "min_f1": 0.80,                   # minimum acceptable F1 score
    "regression_tolerance": 0.02,     # allowed drop from previous model
    "min_per_class_recall": 0.70,     # fairness threshold
    "expected_feature_count": 4,      # schema validation

}

# Baseline (previous production model)
PROD_BASELINE = {"accuracy": 0.88, "f1": 0.87}


# -----------------------------
# LOAD TEST DATA
# -----------------------------
def load_test_data():
    """
    WHY:
    Provides consistent test dataset for validation.
    """
    iris = load_iris()
    X, y = iris.data, iris.target

    _, X_test, _, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    return X_test, y_test


# -----------------------------
# GATE 1: SCHEMA VALIDATION
# -----------------------------
def gate_schema_validation(X_test):
    """
    WHY:
    Ensures input data structure is correct.
    Prevents runtime errors in production.
    """

    # Check number of features
    if X_test.shape[1] != THRESHOLDS["expected_feature_count"]:
        return False, "Feature count mismatch"

    # Check missing values
    if np.isnan(X_test).any():
        return False, "NaN values found"

    return True, "Schema valid"


# -----------------------------
# GATE 2: PERFORMANCE CHECK
# -----------------------------
def gate_performance(model, X_test, y_test):
    """
    WHY:
    Ensures model meets minimum performance requirements.
    """

    preds = model.predict(X_test)

    accuracy = accuracy_score(y_test, preds)
    f1 = f1_score(y_test, preds, average='weighted')

    metrics = {"accuracy": accuracy, "f1": f1}

    # Fail if below threshold
    if accuracy < THRESHOLDS["min_accuracy"] or f1 < THRESHOLDS["min_f1"]:
        return False, metrics, "Performance below threshold"

    return True, metrics, "Performance acceptable"


# -----------------------------
# GATE 3: REGRESSION CHECK
# -----------------------------
def gate_regression(new_metrics):
    """
    WHY:
    Prevents deploying worse model than current production model.
    """

    if new_metrics["accuracy"] < PROD_BASELINE["accuracy"] - THRESHOLDS["regression_tolerance"]:
        return False, "Accuracy regression detected"

    return True, "No regression detected"


# -----------------------------
# GATE 4: FAIRNESS CHECK
# -----------------------------
def gate_fairness(model, X_test, y_test):
    """
    WHY:
    Ensures model performs well across all classes (no bias).
    """

    preds = model.predict(X_test)

    # Recall per class
    per_class = recall_score(y_test, preds, average=None)

    for r in per_class:
        if r < THRESHOLDS["min_per_class_recall"]:
            return False, per_class, "Fairness check failed"

    return True, per_class, "Fairness acceptable"


# -----------------------------
# MAIN VALIDATION PIPELINE
# -----------------------------
def run_all_gates(model=None):
    """
    WHY:
    Runs all validation gates sequentially.
    Stops immediately if any gate fails.
    """

    print("========== VALIDATION PIPELINE ==========")

    from sklearn.ensemble import RandomForestClassifier

    X_test, y_test = load_test_data()

    # If model not provided, create one
    if model is None:
        iris = load_iris()
        X_tr, _, y_tr, _ = train_test_split(
            iris.data, iris.target, test_size=0.2, random_state=42
        )

        model = RandomForestClassifier(n_estimators=100, random_state=42)
        model.fit(X_tr, y_tr)

    # Gate 1
    passed, msg = gate_schema_validation(X_test)
    print("[GATE 1] Schema:", "PASS" if passed else "FAIL", "-", msg)
    if not passed:
        return {"status": "FAIL", "failed_gate": "Schema", "reason": msg}

    # Gate 2
    passed, metrics, msg = gate_performance(model, X_test, y_test)
    print("[GATE 2] Performance:", "PASS" if passed else "FAIL", "-", msg)
    if not passed:
        return {"status": "FAIL", "failed_gate": "Performance", "reason": msg}

    # Gate 3
    passed, msg = gate_regression(metrics)
    print("[GATE 3] Regression:", "PASS" if passed else "FAIL", "-", msg)
    if not passed:
        return {"status": "FAIL", "failed_gate": "Regression", "reason": msg}

    # Gate 4
    passed, _, msg = gate_fairness(model, X_test, y_test)
    print("[GATE 4] Fairness:", "PASS" if passed else "FAIL", "-", msg)
    if not passed:
        return {"status": "FAIL", "failed_gate": "Fairness", "reason": msg}

    return {
        "status": "PASS",
        "failed_gate": None,
        "reason": "All gates passed",
        "metrics": metrics
    }


# -----------------------------
# ENTRY POINT
# -----------------------------
if __name__ == '__main__':
    result = run_all_gates()
    print("\nFINAL:", result["status"])






# -------------------------------------------------------
# REAL WORLD UNDERSTANDING
# -------------------------------------------------------
# In real companies, models are never deployed directly after training.
#
# Example:
# A fraud detection model:
# - If accuracy drops → financial loss
# - If fairness fails → biased decisions
#
# So companies add validation gates like:
# - Performance check
# - Regression check
# - Fairness check
#
# Only if all checks pass → model is deployed
# Otherwise → model is rejected
