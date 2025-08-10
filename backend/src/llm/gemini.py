import os
from typing import cast

from dotenv import load_dotenv
from fastapi import APIRouter
from langchain.chat_models import init_chat_model
from langchain.schema.runnable import RunnableConfig
from langgraph.checkpoint.memory import InMemorySaver
from langgraph.graph import END, START
from langgraph.graph.state import StateGraph

from llm.langraph_model import State
from model import gemini_request

# setup router
app = APIRouter()

# Load enviorment variables
load_dotenv()

API = os.getenv("GOOGLE_API_KEY")
if not API:
    print("Gemini API Missing, Check .env")

# Setup gemini as baseModel
model = init_chat_model("gemini-2.5-flash", model_provider="google_genai")
graph_builder = StateGraph(State)


def chatbot(state: State):
    """
    Helper function to return conversation between human and AI,
    Also adds conversation to the sate.
    """

    response = model.invoke(state["message"])
    return {"message": [response]}


graph_builder.add_node("chatbot", chatbot)
graph_builder.add_edge(START, "chatbot")
graph_builder.add_edge("chatbot", END)
memory = InMemorySaver()
graph = graph_builder.compile(checkpointer=memory)


def stream_graph_updates(user_input: str) -> dict[str, str] | None:
    """
    Function to fetch results from the state and configure for a specific user
    to remeber converstion
    """
    config = cast(
        RunnableConfig, {"configurable": {"thread_id": "user0"}}
    )  # Create a threadID with specif user(can be from a auth system also)
    for event in graph.stream(
        {"message": [{"role": "user", "content": user_input}]}, config
    ):
        for value in event.values():
            return {"Assistant": value["message"][-1]}


@app.post("/askgemini")  # This would later be a web socket
def ask_gemini(input: gemini_request):
    response = stream_graph_updates(input.body)
    if response != None:
        return response["Assistant"].content
