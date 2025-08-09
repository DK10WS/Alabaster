from fastapi import FastAPI
from llm.gemini import app as llm

app = FastAPI()

app.include_router(llm, prefix="/gemini")
@app.get("/")
def test():
    return {"Hello"}
