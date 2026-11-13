FROM python:3.12-slim
ENV PYTHONUNBUFFERED=1 TZ=Europe/London
WORKDIR /app
# COPY requirements.txt . && RUN pip install --no-cache-dir -r requirements.txt   (only if needed)
COPY app.py .
CMD ["python", "app.py"]
