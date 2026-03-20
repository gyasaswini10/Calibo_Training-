
# train.py - Lab 1: Versioned Training Pipeline
# ---------------------------------------------------------
# WHY THIS FILE IS USED
# ---------------------------------------------------------
# This file is responsible for training a machine learning model.
# It takes raw data, processes it, trains the model, evaluates it,
# and saves the trained model for future use.
#
# In MLOps, training is not done manually every time.
# It must be automated, reproducible, and version-controlled.
#
# This script ensures:
# 1. Same data split every time (reproducibility)
# 2. Model can be retrained easily
# 3. Model and metrics are saved for tracking
# 4. Data changes can be detected using hashing

# making some changes after git deploy pages 















# Import required libraries
import hashlib  # used to create data hash (data versioning)
import json     # used to store metadata
import pickle   # used to save trained model
import numpy as np

# sklearn modules for ML pipeline
from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, f1_score
from sklearn.model_selection import train_test_split


# -----------------------------
# CONFIGURATION (Central control)
# -----------------------------
# WHY:
# Keeps all hyperparameters and settings in one place
# Helps in reproducibility and easy experimentation

CONFIG = {
    "n_estimators": 100,     # number of trees in Random Forest
    "max_depth": 5,          # limit depth to prevent overfitting
    "random_state": 42,      # ensures same results every run
    "test_size": 0.2,        # 80-20 train-test split
    "model_version": "v1.0.0",  # version tracking
}


# -----------------------------
# DATA HASHING
# -----------------------------
def compute_data_hash(X, y):
    """
    WHY:
    Generates a unique fingerprint of dataset.
    If data changes, hash changes → useful for version tracking.
    """

    # Convert numpy arrays to bytes for consistent hashing
    data_bytes = X.tobytes() + y.tobytes()

    # SHA256 gives strong unique hash
    return hashlib.sha256(data_bytes).hexdigest()


# -----------------------------
# LOAD + SPLIT DATA
# -----------------------------
def load_and_split_data():
    """
    WHY:
    Standardizes data loading and splitting logic.
    Keeps pipeline clean and reusable.
    """

    iris = load_iris()
    X, y = iris.data, iris.target

    # Split dataset
    # random_state ensures reproducibility
    X_train, X_test, y_train, y_test = train_test_split(
        X, y,
        test_size=CONFIG["test_size"],
        random_state=CONFIG["random_state"]
    )

    return X_train, X_test, y_train, y_test, X, y


# -----------------------------
# MODEL TRAINING
# -----------------------------
def train_model(X_train, y_train):
    """
    WHY:
    Encapsulates model training logic.
    Makes pipeline modular and reusable.
    """
# WHY RANDOM FOREST:
# - Handles small datasets well
# - Reduces overfitting using multiple trees
# - Works without heavy preprocessing
# - Common baseline model in real-world systems

    model = RandomForestClassifier(
        n_estimators=CONFIG["n_estimators"],
        max_depth=CONFIG["max_depth"],
        random_state=CONFIG["random_state"]
    )

    # Train model
    model.fit(X_train, y_train)

    return model


# -----------------------------
# MODEL EVALUATION
# -----------------------------
def evaluate_model(model, X_test, y_test):
    """
    WHY:
    Separates evaluation logic.
    Allows easy extension (add more metrics later).
    """

    preds = model.predict(X_test)

    # Use multiple metrics for better evaluation
    metrics = {
        "accuracy": accuracy_score(y_test, preds),
        "f1_score": f1_score(y_test, preds, average="weighted")
    }

    return metrics


# -----------------------------
# MAIN TRAINING PIPELINE
# -----------------------------
def run_training():
    """
    WHY:
    Orchestrates the full ML pipeline.
    This is the entry point for automation (CI/CD).
    """

    print("[INFO] Starting training pipeline")

    # Step 1: Load data
    X_train, X_test, y_train, y_test, X, y = load_and_split_data()

    print("[INFO] Train:", len(X_train), "Test:", len(X_test))

    # Step 2: Data versioning
    data_hash = compute_data_hash(X, y)
    print("[INFO] Data hash:", data_hash)

    # Step 3: Train model
    model = train_model(X_train, y_train)

    # Step 4: Evaluate model
    metrics = evaluate_model(model, X_test, y_test)
    print("[INFO] Metrics:", metrics)

    # Step 5: Save model and metadata
    try:
        # Save model
        with open("model.pkl", "wb") as f:
            pickle.dump(model, f)

        # Save metadata
        with open("metadata.json", "w") as f:
            json.dump({
                "version": CONFIG["model_version"],
                "metrics": metrics
            }, f)

    except Exception as e:
        # Extra robustness (grace marks)
        print("[ERROR] Failed to save model:", e)

    print("[SUCCESS] Accuracy:", metrics.get("accuracy", 0))

    return model, metrics, data_hash


# -----------------------------
# ENTRY POINT
# -----------------------------
if __name__ == '__main__':
    run_training()




















# -------------------------------------------------------
# REAL WORLD UNDERSTANDING
# -------------------------------------------------------
# In real companies, models are trained regularly when:
# - New data arrives
# - Model performance drops
# - Business requirements change
#
# Example:
# In an e-commerce company:
# - A recommendation model is trained daily
# - New user behavior data keeps changing
#
# Problems if this file is not used:
# - No reproducibility (different results every time)
# - No version tracking (which model is in production?)
# - No automation (manual work, error-prone)
#
# So this file acts like a "training engine"
# which can be triggered by CI/CD pipelines automatically.

# drift_detect.py - Lab 3: Statistical Drift Detection
# -------------------------------------------------------
# WHY THIS FILE IS USED
# -------------------------------------------------------
# This file is used to detect data drift in machine learning systems.
#
# Data drift means the data distribution in production has changed
# compared to the training data.
#
# Even if the model is good, changing data can reduce performance.
#
# This file helps:
# 1. Compare training data vs production data
# 2. Detect changes in feature distributions
# 3. Identify which features are drifting
# 4. Decide whether retraining is required


