from fastapi import FastAPI, UploadFile, File, Response
from fastapi.middleware.cors import CORSMiddleware
import cv2, numpy as np

app = FastAPI(title="object-detection-model", version=settings.APP_VERSION)

# CORS for team tools / web UIs
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], allow_credentials=True,
    allow_methods=["*"], allow_headers=["*"],
)

detector = Detector()

@app.get("/health", response_model=Health)
def health(resp: Response):
    return {"ok": True}

@app.post("/infer", response_model=InferResponse)
def infer(resp: Response):
    return {"ok": True}

