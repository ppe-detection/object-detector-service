# syntax=docker/dockerfile:1

# --- CPU build (default) ---
FROM python:3.11-slim

# --- GPU build (optional) ---
# Swap the line above with this if you want CUDA-enabled PyTorch inside the image:
# FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# System deps for OpenCV & SSL
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 libglib2.0-0 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install Python deps first (better layer caching)
COPY requirements.txt .
RUN python -m pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY app/ ./app/

# Default envs (override at runtime with -e KEY=val)
ENV MODEL_NAME=mock-v1 \
    APP_VERSION=dev \
    MOCK_MODE=1 \
    CONF_THRESH=0.25 \
    IMG_SIZE=640

EXPOSE 9000

# Start API
CMD ["uvicorn", "app.api:app", "--host", "0.0.0.0", "--port", "9000"]
