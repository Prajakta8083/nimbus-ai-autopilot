# nimbus-ai-autopilot
Nimbus AI is a cloud-native autonomous personal assistant designed to enhance productivity by automating task management. It proactively monitors Gmail, schedules, events, tasks, and reminders, using n8n and Gemini for intelligent automation and summarization to reduce information overload.

# Nimbus AI AutoPilot – Gmail to Smart Daily Planner (Lite Version)

Nimbus AI AutoPilot is a cloud-native FastAPI backend that uses **Google Gemini** to:
- Summarize text (e.g., long emails or notes)
- Extract actionable tasks from text
- Generate a smart daily plan from a list of tasks

This repo contains the **backend API** that you can deploy to **Google Cloud Run**.  
For simplicity, this version uses an **in-memory task list instead of Cloud SQL**, so you can run and demo it without complex database setup.

---

## ✨ Features

- **FastAPI backend** running on Cloud Run
- **Gemini 2.0 Flash** used for:
  - `/ai/summarize` – generate short summaries
  - `/ai/extract-tasks` – pull out tasks/deadlines
  - `/ai/plan-day` – create a daily plan
- Simple in-memory “task store”:
  - `/add-task` – add a task string
  - `/get-tasks` – fetch all tasks
- Health checks:
  - `/` – backend status
  - `/test-db` – fake DB connectivity (always returns `connected` in this lite version)

---

## 🏗 Architecture (Lite Version)

1. **Client** (Curl / Postman / n8n / frontend)  
2. **Cloud Run Service** (FastAPI app)
3. **Gemini API** (via `google-generativeai` SDK)
4. **In-memory Task Store** (Python list – no external DB)

```mermaid
flowchart LR
    A[Client: curl / Postman / n8n] --> B[Cloud Run - FastAPI Backend]
    B --> C[Gemini 2.0 Flash API]
    B --> D[In-memory Tasks List]
