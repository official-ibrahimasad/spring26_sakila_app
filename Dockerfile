# 1. Use a slim base image to drastically reduce size
FROM python:3.9-slim

# Add metadata labels
LABEL maintainer="Ibrahim Asad" \
      version="1.0" \
      description="Optimized Sakila Flask Application"

# 2. Create a non-root user for security
RUN useradd -m -r appuser && \
    mkdir /app && \
    chown -R appuser /app

WORKDIR /app

# 3. Copy requirements FIRST to leverage Docker layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy the rest of the application code
COPY . .

# 5. Switch to the non-root user
USER appuser

# Environment variables (No hardcoded secrets!)
ENV MYSQL_HOST=sakila-db-server \
    MYSQL_USER=root \
    MYSQL_DB=sakila

# 6. Expose ONLY the necessary application port
EXPOSE 5000

# 7. Add a Healthcheck to ensure the container is actually functioning
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/')" || exit 1

CMD ["python", "app.py"]