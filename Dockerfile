# FROM python:3.9-slim
# COPY . /app
# RUN python -m pip install --upgrade pip && if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
# WORKDIR /app
# CMD ["python", "app.py"]

FROM python:3.9

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

CMD ["python", "app.py"]