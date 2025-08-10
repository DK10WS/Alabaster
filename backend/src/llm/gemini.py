import os

from dotenv import load_dotenv
from fastapi import APIRouter
from langchain.chat_models import init_chat_model
from langgraph.graph import END, START
from langgraph.graph.state import StateGraph

from llm.langraph_model import State
from model import gemini_request

load_dotenv()

API = os.getenv("GOOGLE_API_KEY")

if not API:
    print("Gemini API Missing, Check .env")

app = APIRouter()


model = init_chat_model("gemini-2.5-flash", model_provider="google_genai")
graph_builder = StateGraph(State)


def chatbot(state: State):
    return {"message": [model.invoke(state["message"])]}


graph_builder.add_node("chatbot", chatbot)
graph_builder.add_edge(START, "chatbot")
graph_builder.add_edge("chatbot", END)
graph = graph_builder.compile()


def stream_graph_updates(user_input: str) -> dict[str, str] | None:
    for event in graph.stream({"message": [{"role": "user", "content": user_input}]}):
        for value in event.values():
            return {"Assistant": value["message"][-1]}


@app.post("/askgemini")
def ask_gemini(input: gemini_request):
    global model
    response = stream_graph_updates(input.body)
    return response
