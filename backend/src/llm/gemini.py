import os

from dotenv import load_dotenv
from fastapi import APIRouter
from langchain.chat_models import init_chat_model

from model import gemini_request

load_dotenv()

API = os.getenv("GOOGLE_API_KEY")

if not API:
    print("Gemini API Missing, Check .env")

app = APIRouter()


@app.post("/askgemini")
def ask_gemini(body: gemini_request):
    model = init_chat_model("gemini-2.5-flash", model_provider="google_genai")
    response = model.invoke(body.body)
    return {"body": response.content}
