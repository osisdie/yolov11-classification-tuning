# Ultralytics YOLO Training for Higher Accuracy

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Ultralytics](https://img.shields.io/badge/Ultralytics-YOLOv11-00FFFF.svg)](https://docs.ultralytics.com/)
[![CI](https://github.com/osisdie/ultralytics-yolo-training-for-higher-accuracy/actions/workflows/ci.yml/badge.svg)](https://github.com/osisdie/ultralytics-yolo-training-for-higher-accuracy/actions/workflows/ci.yml)
[![GitHub last commit](https://img.shields.io/github/last-commit/osisdie/ultralytics-yolo-training-for-higher-accuracy)](https://github.com/osisdie/ultralytics-yolo-training-for-higher-accuracy/commits/main)

> **Best mAP50: 0.98** | **Best cls_loss: 0.26** | **36 hyperparameter runs compared**

A systematic hyperparameter sweep study using YOLOv11 for image classification, comparing 3 model sizes, 3 optimizers, 2 image sizes, and augmentation on/off across 36 training runs.

## Objectives

1. Investigate the applicability of the MVTec AD dataset for training and predicting bottle classification.
2. Explore the use of the MVTec AD dataset for training and predicting transistor classification.
3. Develop a continuous training workflow that enables the export and import of intermediate training data, avoiding the need to restart training from the beginning.
4. Identify and optimize hyperparameters and algorithms to achieve high accuracy (95%+) while maintaining a low classification loss (10% or lower).

---

## Installation

```bash
git clone https://github.com/osisdie/ultralytics-yolo-training-for-higher-accuracy.git
cd ultralytics-yolo-training-for-higher-accuracy
pip install -r requirements.txt
```

## Quick Start

**Run inference with the best model:**

```bash
python bottle_console_app.py \
  models/bottle/Run8_yolo11n_512_SGD_Aug/best.pt \
  tests/bottle_input.png
```

**Run the training notebook:**

```bash
jupyter notebook bottle_continuous_training.ipynb
```

## Docker

```bash
docker compose build
docker compose run yolo
```

Override the default model and image:

```bash
docker compose run yolo models/bottle/Run7_yolo11n_512_SGD/best.pt tests/bottle_input.png
```

---

## Datasets

| Dataset | Classes | Source |
|---------|---------|--------|
| **MVTec AD Bottle** | 4 — good, broken_large, broken_small, contamination | [Kaggle](https://www.kaggle.com/datasets/thtuan/mvtecad-mvtec-anomaly-detection) |
| **MVTec AD Transistor** | 5 — good, bent_lead, cut_lead, damaged_case, misplaced | [Kaggle](https://www.kaggle.com/datasets/thtuan/mvtecad-mvtec-anomaly-detection) |
| **Rice Image** | 5 — Arborio, Basmati, Ipsala, Jasmine, Karacadag | [Kaggle](https://www.kaggle.com/datasets/alikhalilit98/rice-image-dataset-for-object-detection) |

---

## Pre-trained YOLO Models

| Feature | yolo11n.pt | yolo11s.pt | yolo11m.pt |
|---------|-----------|-----------|-----------|
| **Parameters** | 6.8 M | 15.7 M | 53.0 M |
| **FLOPs** | 4.5 TFLOPS | 9.9 TFLOPS | 31.9 TFLOPS |
| **Speed (RTX 3080)** | High (100+ FPS) | Medium (50-100 FPS) | Low (10-50 FPS) |
| **Target Hardware** | Mobile/Embedded | Limited-Memory GPUs | High-Performance GPUs |

---

## Hyperparameter Sweep Configuration

```python
DEFAULT_PARAMS = dict(
    model_names     = ["yolo11n.pt", "yolo11s.pt", "yolo11m.pt"],
    imgsizes        = [256, 512],
    optimizers      = ["SGD", "AdamW", "Adam"],
    learning_rates  = [0.01, 0.005, 0.001],
    batch_size      = 16,
    epochs          = 50,
    image_augments  = [False, True]
)
```

---

## Full Results: 36 Runs Sorted by mAP50

| Rank | Run | Model | ImgSz | Optimizer | Aug | mAP50 | Best cls_loss |
|------|-----|-------|-------|-----------|-----|-------|---------------|
| 1 | Run8_yolo11n_512_SGD_Aug | yolo11n.pt | 512 | SGD | Yes | **0.9805** | 0.58 |
| 2 | Run7_yolo11n_512_SGD | yolo11n.pt | 512 | SGD | No | **0.9638** | 0.26 |
| 3 | Run32_yolo11m_512_SGD_Aug | yolo11m.pt | 512 | SGD | Yes | **0.9595** | 0.40 |
| 4 | Run19_yolo11s_512_SGD | yolo11s.pt | 512 | SGD | No | 0.9493 | 0.48 |
| 5 | Run11_yolo11n_512_Adam | yolo11n.pt | 512 | Adam | No | 0.9441 | 0.58 |
| 6 | Run13_yolo11s_256_SGD | yolo11s.pt | 256 | SGD | No | 0.9405 | 0.49 |
| 7 | Run1_yolo11n_256_SGD | yolo11n.pt | 256 | SGD | No | 0.9324 | 0.41 |
| 8 | Run20_yolo11s_512_SGD_Aug | yolo11s.pt | 512 | SGD | Yes | 0.9319 | 0.44 |
| 9 | Run31_yolo11m_512_SGD | yolo11m.pt | 512 | SGD | No | 0.9248 | 0.49 |
| 10 | Run14_yolo11s_256_SGD_Aug | yolo11s.pt | 256 | SGD | Yes | 0.9124 | 0.37 |
| 11 | Run25_yolo11m_256_SGD | yolo11m.pt | 256 | SGD | No | 0.8988 | 0.62 |
| 12 | Run26_yolo11m_256_SGD_Aug | yolo11m.pt | 256 | SGD | Yes | 0.8930 | 0.53 |
| 13 | Run5_yolo11n_256_Adam | yolo11n.pt | 256 | Adam | No | 0.8734 | 0.64 |
| 14 | Run17_yolo11s_256_Adam | yolo11s.pt | 256 | Adam | No | 0.8453 | — |
| 15 | Run2_yolo11n_256_SGD_Aug | yolo11n.pt | 256 | SGD | Yes | 0.8408 | 0.81 |
| 16 | Run23_yolo11s_512_Adam | yolo11s.pt | 512 | Adam | No | 0.8108 | — |
| 17 | Run9_yolo11n_512_AdamW | yolo11n.pt | 512 | AdamW | No | 0.8059 | 0.54 |
| 18 | Run21_yolo11s_512_AdamW | yolo11s.pt | 512 | AdamW | No | 0.7502 | — |
| 19 | Run15_yolo11s_256_AdamW | yolo11s.pt | 256 | AdamW | No | 0.6283 | — |
| 20 | Run27_yolo11m_256_AdamW | yolo11m.pt | 256 | AdamW | No | 0.5995 | — |
| 21 | Run24_yolo11s_512_Adam_Aug | yolo11s.pt | 512 | Adam | Yes | 0.5131 | — |
| 22 | Run36_yolo11m_512_Adam_Aug | yolo11m.pt | 512 | Adam | Yes | 0.5096 | — |
| 23 | Run3_yolo11n_256_AdamW | yolo11n.pt | 256 | AdamW | No | 0.5010 | 1.11 |
| 24 | Run33_yolo11m_512_AdamW | yolo11m.pt | 512 | AdamW | No | 0.4951 | — |
| 25 | Run29_yolo11m_256_Adam | yolo11m.pt | 256 | Adam | No | 0.4944 | — |
| 26 | Run10_yolo11n_512_AdamW_Aug | yolo11n.pt | 512 | AdamW | Yes | 0.4771 | 1.49 |
| 27 | Run16_yolo11s_256_AdamW_Aug | yolo11s.pt | 256 | AdamW | Yes | 0.4718 | — |
| 28 | Run34_yolo11m_512_AdamW_Aug | yolo11m.pt | 512 | AdamW | Yes | 0.4698 | — |
| 29 | Run28_yolo11m_256_AdamW_Aug | yolo11m.pt | 256 | AdamW | Yes | 0.4672 | — |
| 30 | Run30_yolo11m_256_Adam_Aug | yolo11m.pt | 256 | Adam | Yes | 0.4434 | — |
| 31 | Run18_yolo11s_256_Adam_Aug | yolo11s.pt | 256 | Adam | Yes | 0.4427 | 1.66 |
| 32 | Run22_yolo11s_512_AdamW_Aug | yolo11s.pt | 512 | AdamW | Yes | 0.4376 | — |
| 33 | Run12_yolo11n_512_Adam_Aug | yolo11n.pt | 512 | Adam | Yes | 0.4347 | 1.47 |
| 34 | Run6_yolo11n_256_Adam_Aug | yolo11n.pt | 256 | Adam | Yes | 0.4325 | 1.46 |
| 35 | Run35_yolo11m_512_Adam | yolo11m.pt | 512 | Adam | No | 0.4208 | — |
| 36 | Run4_yolo11n_256_AdamW_Aug | yolo11n.pt | 256 | AdamW | Yes | 0.4066 | 1.57 |

> **"—"** indicates the training run produced unstable cls_loss values (NaN), common with Adam/AdamW on this small dataset.

---

## Key Findings

- **SGD dominates**: 9 of the top 10 runs use SGD. Adam and AdamW frequently produce unstable training (NaN losses) on this dataset.
- **512 > 256**: Image size 512 consistently outperforms 256 across all model sizes and optimizers.
- **Augmentation helps with SGD**: The top run (Run8, 0.98 mAP50) uses SGD + augmentation. However, augmentation with Adam/AdamW often causes divergence.
- **Smaller models can win**: yolo11n.pt (6.8M params) achieved the best mAP50 — larger models don't guarantee better results with limited data.
- **Best accuracy vs. best loss tradeoff**: Run8 has the highest mAP50 (0.98) but Run7 has the lowest cls_loss (0.26).

---

## Model Performance

### Bottle

**Confusion Matrix**
![](./images/bottle/bottle_confusion_matrix.png)

**Training Results**
![](./images/bottle/bottle_training_results.png)

**Prediction**
![](./images/bottle/bottle_prediction.png)

### Transistor

**Confusion Matrix**
![](./images/transistor/transistor_confusion_matrix.png)

**Training Results**
![](./images/transistor/transistor_training_results.png)

**Prediction**
![](./images/transistor/transistor_prediction.png)

### Rice

**Confusion Matrix**
![](./images/rice/rice_confusion_matrix.png)

**Training Results**
![](./images/rice/rice_training_results.png)

**Prediction**
![](./images/rice/rice_prediction.png)

---

## Cross-Model-Parameter Training Results

**metrics/mAP50**
![](./images/yolo11_metrics_mAP50_for_bottle_50_epochs_each.png)

**val/cls_loss**
![](./images/yolo11_val_cls_loss_for_bottle_50_epochs_each.png)

---

## Best Models

### Highest mAP50 Accuracy

> [Download best.pt](./models/bottle/Run8_yolo11n_512_SGD_Aug/best.pt)

```yaml
Run:        Run8_yolo11n_512_SGD_Aug
mAP50:      0.98
cls_loss:   0.58
Image Size: 512
Optimizer:  SGD
Epochs:     50/50
LR:         0.01
Augmented:  Yes
Model:      yolo11n.pt
```

### Lowest cls_loss

> [Download best.pt](./models/bottle/Run7_yolo11n_512_SGD/best.pt)

```yaml
Run:        Run7_yolo11n_512_SGD
mAP50:      0.96
cls_loss:   0.26
Image Size: 512
Optimizer:  SGD
Epochs:     50/50
LR:         0.01
Augmented:  No
Model:      yolo11n.pt
```

---

## Manual Testing

```bash
python bottle_console_app.py \
  models/bottle/Run7_yolo11n_512_SGD/best.pt \
  tests/bottle_input.png
```

**Output:**
```
Processing image: tests/bottle_input.png

image 1/1 ./tests/bottle_input.png: 512x512 1 contamination, 66.8ms
Speed: 3.0ms preprocess, 66.8ms inference, 1.0ms postprocess per image at shape (1, 3, 512, 512)
Result:
Object 1:
  Type:  3, Confidence: 0.95
  Coordinates: x_min=0.003, y_min=0.008, x_max=0.999, y_max=0.997
  Dimensions: width=0.996, height=0.989, Area=0.986

Saved predicted result to ./output/bottle_input.png
```

![](./tests/bottle_output_figure.png)

---

## Conclusion

> Experiments suggest that utilizing the `YOLOv11n` model with a `512`-pixel image size and the `SGD` learning algorithm can yield improved results. Furthermore, employing image augmentation techniques such as rotation, flipping, grayscale conversion, and brightness adjustment can further enhance accuracy.

> While the goal of achieving `95%` `mAP50` was partially met, certain parameter combinations demonstrated promising results:
> - Run8_`yolo11n_512_SGD_Aug` (`0.98` `mAP50`)
> - Run7_yolo11n_512_SGD (0.96 mAP50)
> - Run32_yolo11m_512_SGD_Aug (0.96 mAP50)

> However, the goal of minimizing the loss value was not achieved. In every run, the loss value exceeded the target threshold by at least 20%. The top 3 runs with the lowest loss values were:
> - Run7_`yolo11n_512_SGD` (`0.26` `val/cls_loss`)
> - Run14_yolo11s_256_SGD_Aug (0.37 val/cls_loss)
> - Run32_yolo11m_512_SGD_Aug (0.40 val/cls_loss)

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## References

- [Ultralytics YOLO Docs](https://docs.ultralytics.com/)
- [Ultralytics GitHub](https://github.com/ultralytics/ultralytics)
- [MVTecAD (MVTec Anomaly Detection)](https://www.kaggle.com/datasets/thtuan/mvtecad-mvtec-anomaly-detection)
- [Rice Image Dataset for Object Detection](https://www.kaggle.com/datasets/alikhalilit98/rice-image-dataset-for-object-detection)

## License

This project is licensed under the [MIT License](LICENSE).
