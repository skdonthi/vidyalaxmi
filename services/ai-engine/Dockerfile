FROM python:3.12-slim

WORKDIR /app

# Install uv via pip to bypass ghcr.io proxy blocks
RUN pip install uv

# Install deps via uv (no venv — system install)
COPY requirements.txt .
RUN uv pip install --system --no-cache -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
