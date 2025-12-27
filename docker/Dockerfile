FROM python:3.10.2-slim as builder

WORKDIR /app

COPY pyproject.toml ./

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir .

COPY src/ ./src/

RUN find /opt/venv/ -type f -name '*.pyc' -delete && \
    find /opt/venv/ -type d -name '__pycahce__' -exec rm -rf {} + && \
    find /opt/venv -name "*.dist-info" -type d -exec rm -rf {} + 2>/dev/null || true && \
    find /opt/venv -name "*.egg-info" -type d -exec rm -rf {} + 2>/dev/null || true && \
    find /opt/venv -name "README" -delete && \
    find /opt/venv -name "*.txt" -delete && \
    find /opt/venv -name "*.md" -delete

FROM python:3.10.2-slim

WORKDIR /app

COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY --from=builder /app/src ./src

RUN groupadd -r appgroup && useradd -r -g appgroup appuser
USER appuser

ENV PORT=8029
EXPOSE ${PORT}

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:${PORT}/health')"

ENTRYPOINT ["sh", "-c"]

CMD ["uvicorn src.main:app --host 0.0.0.0 --port ${PORT}"]
