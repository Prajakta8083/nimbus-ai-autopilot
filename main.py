import os
from typing import List

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

from ai_service import summarize_text, extract_tasks, plan_day

app = FastAPI(title="Nimbus AI AutoPilot", version="1.0.0")

# ---- In-memory task store (Lite Version - no external DB) ----
task_store: List[str] = []


class TextRequest(BaseModel):
    text: str


class TasksRequest(BaseModel):
    tasks: List[str]


class TaskItem(BaseModel):
    task: str


@app.get("/")
def health_check():
    """Basic backend status check."""
    return {"status": "ok", "service": "nimbus-ai-autopilot"}


@app.get("/test-db")
def test_db():
    """Lite version: no real DB connection, always reports connected."""
    return {"db_status": "connected", "mode": "in-memory"}


@app.post("/ai/summarize")
def summarize(request: TextRequest):
    if not request.text.strip():
        raise HTTPException(status_code=400, detail="Text cannot be empty")
    try:
        summary = summarize_text(request.text)
    except Exception as e:
        raise HTTPException(status_code=502, detail=f"Gemini API error: {e}")
    return {"summary": summary}


@app.post("/ai/extract-tasks")
def extract(request: TextRequest):
    if not request.text.strip():
        raise HTTPException(status_code=400, detail="Text cannot be empty")
    try:
        tasks = extract_tasks(request.text)
    except Exception as e:
        raise HTTPException(status_code=502, detail=f"Gemini API error: {e}")
    return {"tasks": tasks}


@app.post("/ai/plan-day")
def plan(request: TasksRequest):
    if not request.tasks:
        raise HTTPException(status_code=400, detail="Tasks list cannot be empty")
    try:
        result = plan_day(request.tasks)
    except Exception as e:
        raise HTTPException(status_code=502, detail=f"Gemini API error: {e}")
    return {"plan": result}


@app.post("/add-task")
def add_task(item: TaskItem):
    task_store.append(item.task)
    return {"message": "Task added", "total_tasks": len(task_store)}


@app.get("/get-tasks")
def get_tasks():
    return {"tasks": task_store}
