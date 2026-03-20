# mlops-model-pipeline

This project shows a simple end-to-end MLOps pipeline where a machine learning model is trained, validated, deployed, monitored, and retrained.

## Project Flow

Train → Validate → CI Pipeline → Deploy → Monitor → Retrain

## Project Structure

mlops-model-pipeline/
│
├── train.py
├── validate.py
├── drift_detect.py
├── monitor.py
├── requirements.txt
│
└── .github/
└── workflows/
├── ci_pipeline.yml
└── cd_deploy.yml

## How to Run

Install dependencies:
pip install -r requirements.txt

Run training:
python train.py

Run validation:
python validate.py

Run drift detection:
python drift_detect.py

Run monitoring:
python monitor.py

## About

This project helps understand how ML models are used in real systems. Instead of training once, the model is checked, deployed carefully, monitored, and retrained when needed.
