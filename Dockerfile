FROM python:3.10-slim

# Install OpenCV system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT ["python", "bottle_console_app.py"]
CMD ["models/bottle/Run8_yolo11n_512_SGD_Aug/best.pt", "tests/bottle_input.png"]
