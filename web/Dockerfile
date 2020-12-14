
FROM python
ENV PYTHONUNBUFFERED=1
RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
RUN apt update && apt-get install -y postgresql-client
COPY ./disquaire/disquaire_project /code/
