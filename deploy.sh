#!/bin/bash

set -e  # エラーで即停止

APP_DIR="/opt/system/api"

echo "====================================="
echo "デプロイ開始: $(date)"
echo "====================================="

# 1. 最新コードを取得
echo "▶ コード取得"
cd $APP_DIR
git pull origin main

# 2. イメージをビルド
echo "▶ イメージビルド"
docker compose -f docker-compose.prod.yml build

# 3. マイグレーション
echo "▶ マイグレーション"
docker compose -f docker-compose.prod.yml run --rm django \
  python manage.py migrate

# 4. 静的ファイル収集
echo "▶ 静的ファイル収集"
docker compose -f docker-compose.prod.yml run --rm django \
  python manage.py collectstatic --noinput

# 5. コンテナ再起動
echo "▶ コンテナ再起動"
docker compose -f docker-compose.prod.yml up -d

echo "====================================="
echo "✅ デプロイ完了: $(date)"
echo "====================================="
