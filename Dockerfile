FROM python:3.7-slim
# FROM ubuntu:20.04

EXPOSE 8000

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1

COPY requirements.txt .
RUN apt-get update && apt-get install --yes libpq-dev build-essential libjpeg-dev zlib1g-dev && python -m pip install -r requirements.txt

WORKDIR /app
COPY . /app

RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "craigslist_proj.wsgi"]
