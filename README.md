# object-detection-model
Responsible for performing object detection on incoming image data and serves as the core AI inference layer of the PPE Detection system.

## This service:

* Receives image frames (from the stream-ingest-service) via REST API.

* Uses OpenCV to preprocess images.

* Uses YOLO / PyTorch to detect PPE items (helmets, vests, gloves, etc.).

* Returns detection results as structured JSON.
