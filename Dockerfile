FROM python:3.11-slim

WORKDIR /app

COPY services/filecache/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY services/request_authorization/client/ ./vendor/request_auth_client/
RUN pip install --no-cache-dir ./vendor/request_auth_client/

COPY services/filecache/app/ ./app/
COPY services/filecache/main.py .
COPY services/filecache/docker-config.yaml ./config.yaml

RUN mkdir -p /data/filecache /tmp/filecache

EXPOSE 8030

CMD ["python", "main.py", "--config", "config.yaml"]
