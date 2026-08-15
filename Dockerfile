FROM python:3.11-alpine
WORKDIR /app
RUN adduser -D appuser

# Desinstalar versiones vulnerables preinstaladas en la base Alpine
RUN pip uninstall -y setuptools msgpack || true

# Reinstalar dependencias corregidas sin cache
RUN pip install --no-cache-dir "pip>=24.0" "setuptools>=78.1.1" "msgpack>=1.2.1" wheel

COPY app/ /app/
RUN pip install --no-cache-dir -r requirements.txt

USER appuser
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s CMD wget --spider -q http://localhost:8080/ || exit 1
CMD ["python", "app.py"]
