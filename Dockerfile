FROM python:3.11-alpine
WORKDIR /app
RUN adduser -D appuser
COPY app/ /app/
RUN pip install --no-cache-dir --upgrade "pip>=24.0" "setuptools>=78.1.1" wheel jaraco.context
RUN pip install --no-cache-dir -r requirements.txt
USER appuser
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s CMD wget --spider -q http://localhost:8080/ || exit 1
CMD ["python", "app.py"]
