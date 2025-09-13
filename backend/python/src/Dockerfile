FROM ghcr.io/astral-sh/uv:python3.13-bookworm

WORKDIR /backend

COPY . .

RUN uv sync

EXPOSE 8000

CMD ["uv", "run", "uvicorn", "main:app", "--reload"]
