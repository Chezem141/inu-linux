FROM python:3.10.2-slim as builder

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml .

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir .

COPY src/ ./src/
COPY tests/ ./tests/

FROM python:3.10.2-slim

WORKDIR /app

COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY --from=builder /app/src ./src
COPY --from=builder /app/pyproject.toml .

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENV PORT=8029
EXPOSE ${PORT}

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:${PORT}/health')"

CMD ["uvicorn", "src.main:app", "--host 0.0.0.0", "--port" "${PORT}"]