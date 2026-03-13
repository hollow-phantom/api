from .base import *

DEBUG = True

# 開発時は全ホストからのアクセスを許可
ALLOWED_HOSTS = ["*"]

# 開発用ツール
INSTALLED_APPS += [
    "debug_toolbar",
]

MIDDLEWARE += [
    "debug_toolbar.middleware.DebugToolbarMiddleware",
]

CORS_ALLOW_ALL_ORIGINS = True

INTERNAL_IPS = ["127.0.0.1"]

# 開発時はコンソールにメール出力
EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend"

# SQLをコンソールに出力（クエリ確認用）
LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
        },
    },
    "loggers": {
        "django.db.backends": {
            "handlers": ["console"],
            "level": "DEBUG",
        },
    },
}
