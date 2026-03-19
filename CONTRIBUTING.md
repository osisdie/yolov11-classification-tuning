# Contributing

Thanks for your interest in contributing! Here's how to get started.

## Development Setup

```bash
git clone https://github.com/osisdie/ultralytics-yolo-training-for-higher-accuracy.git
cd ultralytics-yolo-training-for-higher-accuracy
pip install -r requirements.txt
pip install pre-commit
pre-commit install
```

## Workflow

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-change`
3. Make your changes
4. Run lint checks: `flake8 --max-line-length=120 *.py`
5. Commit (pre-commit hooks will run automatically)
6. Push and open a Pull Request

## Adding New Datasets

1. Prepare your dataset in YOLO format
2. Add the class map to the README
3. Create a training notebook following the pattern in `bottle_continuous_training.ipynb`
4. Add results to `data/combined_train_list.json`

## Adding New Training Runs

1. Run your training with the desired hyperparameters
2. Export results and append to `data/combined_train_list.json`
3. Update the results table in `README.md`

## Code Style

- Max line length: 120 characters
- Imports sorted with `isort`
- Linted with `flake8`
- See `.pre-commit-config.yaml` for the full hook configuration
