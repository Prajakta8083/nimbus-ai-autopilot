import os
from typing import List

from dotenv import load_dotenv
from google import genai

load_dotenv()  # reads the .env file and loads variables into the environment

GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY")
if not GEMINI_API_KEY:
    raise RuntimeError(
        "GEMINI_API_KEY environment variable is not set. "
        "Get one at https://aistudio.google.com/apikey and set it in .env"
    )

client = genai.Client(api_key=GEMINI_API_KEY)
MODEL_NAME = "gemini-2.0-flash"


def _generate(prompt: str) -> str:
    response = client.models.generate_content(
        model=MODEL_NAME,
        contents=prompt,
    )
    return response.text.strip()


def summarize_text(text: str) -> str:
    prompt = f"Summarize the following text in 2-3 concise sentences:\n\n{text}"
    return _generate(prompt)


def extract_tasks(text: str) -> List[str]:
    prompt = (
        "Extract a list of clear, actionable tasks from the text below. "
        "Return ONLY the tasks, one per line, no numbering, no extra commentary.\n\n"
        f"{text}"
    )
    result = _generate(prompt)
    return [line.strip("-• ").strip() for line in result.split("\n") if line.strip()]


def plan_day(tasks: List[str]) -> str:
    task_list = "\n".join(f"- {t}" for t in tasks)
    prompt = (
        "Given the following tasks, create a realistic daily schedule with time "
        "blocks. Prioritize based on likely urgency and effort. Keep it concise.\n\n"
        f"{task_list}"
    )
    return _generate(prompt)