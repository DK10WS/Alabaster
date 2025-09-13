from fastapi import FastAPI
from llm.gemini import app as llm
import uvicorn

app = FastAPI(root_path="/api")

app.include_router(llm, prefix="/gemini")

@app.get("/")
def test():
    return {"Hello"}

if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8000,reload=True)
