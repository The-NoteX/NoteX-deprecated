FROM python:3.8-slim
WORKDIR /app
COPY req.txt /app/
RUN pip install --no-cache-dir -r req.txt
COPY . /app/
EXPOSE 80
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]