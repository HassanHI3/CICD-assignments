# FROM  python:3.9-slim
# COPY . /app
# RUN python -m pip install --upgrade pip && if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
# WORKDIR /app
# CMD ["python", "app.py"]

FROM python:3.9

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]