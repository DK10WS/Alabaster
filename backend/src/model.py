from pydantic import BaseModel

class gemini_request(BaseModel):
    body: str
