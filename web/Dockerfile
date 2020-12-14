
FROM python
ENV PYTHONUNBUFFERED=1
RUN mkdir /app
WORKDIR /app
COPY requirements.txt /app/
RUN pip install -r requirements.txt
RUN apt update && apt-get install -y postgresql-client
