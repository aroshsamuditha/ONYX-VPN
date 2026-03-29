FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PORT=5000

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py auth.py admin.py models.py ./
COPY templates ./templates
COPY static ./static

RUN mkdir -p uploads

EXPOSE 5000

CMD exec gunicorn --bind "0.0.0.0:${PORT}" --workers 2 app:app
