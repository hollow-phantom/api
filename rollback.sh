#!/bin/bash

set -e

APP_DIR="/opt/system/api"

if [ -z "$1" ]; then
  echo "使い方: bash rollback.sh <commit hash>"
  echo "コミット履歴: git log --oneline"
  exit 1
fi

COMMIT=$1

echo "====================================="
echo "ロールバック開始: $COMMIT"
echo "====================================="

cd $APP_DIR

# 1. 指定コミットに戻す
echo "▶ コード巻き戻し"
git checkout $COMMIT

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
echo "✅ ロールバック完了: $(date)"
echo "====================================="
