# syntax=docker/dockerfile:1

FROM python:3.11-slim

WORKDIR /app

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Копируем requirements.txt и устанавливаем зависимости
COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Копируем остальные файлы проекта
COPY . .

# Создаем директории для данных
RUN mkdir -p data instance uploads && chmod -R 777 data instance uploads

# Переменная окружения по умолчанию
ENV FLASK_ENV=production
ENV PYTHONUNBUFFERED=1

# Открываем порт приложения
EXPOSE 5000

# Команда запуска приложения
CMD ["python3", "app.py"]