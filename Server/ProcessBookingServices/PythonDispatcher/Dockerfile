FROM python:3-alpine3.10
WORKDIR /server/process-booking-services/python-dispatcher
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir
COPY . .
ENTRYPOINT ["python3", "dispatcher.py"]