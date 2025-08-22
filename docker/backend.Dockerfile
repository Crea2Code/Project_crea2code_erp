# docker/backend.Dockerfile
FROM python:3.11-slim

# Empêcher Python de générer des fichiers .pyc
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Installer les dépendances système (ex: psycopg2 si Postgres)
RUN apt-get update && apt-get install -y \
    build-essential libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

# Copier et installer les dépendances Python
COPY backend/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code backend
COPY backend /app/

EXPOSE 8000

CMD ["gunicorn", "backend.wsgi:application", "--bind", "0.0.0.0:8000"]
