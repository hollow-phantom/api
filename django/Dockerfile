FROM python:3.12-slim

WORKDIR /app

# 依存パッケージのインストール
RUN rm -rf /var/lib/apt/lists/* && apt-get clean
RUN apt-get update --fix-missing
RUN apt-get install -y --no-install-recommends curl gnupg2
RUN apt-get install -y --no-install-recommends gcc g++ build-essential
RUN apt-get install -y --no-install-recommends unixodbc-dev unixodbc

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Pythonパッケージのインストール
COPY requirements/ requirements/
RUN pip install --no-cache-dir -r requirements/development.txt
