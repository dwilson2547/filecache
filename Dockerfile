FROM python:3.11-slim

WORKDIR /app

COPY filecache/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY request_authorization/client/ ./vendor/request_auth_client/
RUN pip install --no-cache-dir ./vendor/request_auth_client/

COPY filecache/app/ ./app/
COPY filecache/main.py .
COPY filecache/docker-config.yaml ./config.yaml

RUN mkdir -p /data/filecache /tmp/filecache

EXPOSE 8030

CMD ["python", "main.py", "--config", "config.yaml"]
