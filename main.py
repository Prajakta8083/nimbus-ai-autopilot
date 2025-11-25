from fastapi import FastAPI
from pydantic import BaseModel
import os
import google.generativeai as genai
from sqlalchemy import create_engine, text

app = FastAPI()

# ------------------ DB CONNECTION ------------------
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")
DB_PORT = os.getenv("DB_PORT", "5432")

DATABASE_URL = f"postgresql+pg8000://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
engine = create_engine(DATABASE_URL)

# ------------------ GEMINI ------------------
genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))
model = genai.GenerativeModel("gemini-2.0-flash")

class TextIn(BaseModel):
    text: str

@app.get("/")
def home():
    return {"status": "Nimbus AI Mini Backend Running"}

@app.get("/test-db")
def test_db():
    try:
        with engine.connect() as conn:
            result = conn.execute(text("SELECT 1"))
            return {"db_status": "connected", "result": result.scalar()}
    except Exception as e:
        return {"db_status": "error", "detail": str(e)}

@app.post("/summarize")
def summarize(payload: TextIn):
    result = model.generate_content(f"Summarize this:\n\n{payload.text}")
    return {"summary": result.text}
