FROM python:3.8.0-buster

# install production dependencies
COPY requirements.txt ./
RUN pip install -r requirements.txt

# add production source code
ADD /src /app

WORKDIR /app

CMD ["python", "app.py"]