FROM python:3.6

COPY requeriments.txt /tmp/requeriments.txt
RUN apt update && apt install -y postgresql-client && \
    pip install -r /tmp/requeriments.txt

EXPOSE 8000
WORKDIR /app/
