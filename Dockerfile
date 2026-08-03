# ── Hugging Face Spaces – Streamlit App ──────────────────────────────────────
# HF Spaces expects the container to listen on port 7860.
# All secret keys are injected as Space Secrets (env vars) at runtime;
# never hard-code them here.
# ─────────────────────────────────────────────────────────────────────────────

FROM python:3.11-slim

# Metadata (shown in the HF Space card)
LABEL maintainer="Blog Writing Agent"
LABEL description="Autonomous Multi-Agent Blog Writing System – Streamlit UI"

# ── System dependencies ───────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
    && rm -rf /var/lib/apt/lists/*

# ── Create a non-root user (HF Spaces security requirement) ──────────────────
RUN useradd -m -u 1000 appuser

# ── Set working directory ─────────────────────────────────────────────────────
WORKDIR /app

# ── Install Python dependencies first (layer-caching optimisation) ────────────
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# ── Copy application source ───────────────────────────────────────────────────
COPY app.py     .
COPY backend.py .

# Copy the images directory if it exists (non-fatal if absent at build time)
COPY images/    ./images/

# ── Streamlit configuration ───────────────────────────────────────────────────
# Disable the browser-open behaviour and set the port to 7860 (HF default).
RUN mkdir -p /app/.streamlit
RUN echo "\
[server]\n\
port = 7860\n\
address = \"0.0.0.0\"\n\
headless = true\n\
enableCORS = false\n\
enableXsrfProtection = false\n\
\n\
[browser]\n\
gatherUsageStats = false\n\
" > /app/.streamlit/config.toml

# ── Fix ownership so the non-root user can write (for generated .md / images) ─
RUN chown -R appuser:appuser /app

USER appuser

# ── Runtime environment variables (overridden by HF Space Secrets) ────────────
# These are safe placeholder defaults; real secrets are set as HF Space Secrets.
ENV OPENROUTER_API_KEY=""
ENV TAVILY_API_KEY=""
ENV GOOGLE_API_KEY=""
ENV OPENROUTER_MODEL="openai/gpt-4o-mini"

# ── Expose the port Spaces routes traffic to ─────────────────────────────────
EXPOSE 7860

# ── Health-check (optional but recommended) ───────────────────────────────────
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:7860/_stcore/health || exit 1

# ── Launch the Streamlit app ──────────────────────────────────────────────────
CMD ["streamlit", "run", "app.py", \
     "--server.port=7860", \
     "--server.address=0.0.0.0", \
     "--server.headless=true"]
