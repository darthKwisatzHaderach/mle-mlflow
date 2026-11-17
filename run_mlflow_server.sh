#!/bin/bash

# Загружаем переменные из .env в окружение скрипта
set -a
. ./.env
set +a

export MLFLOW_SQLALCHEMYSTORE_POOL_SIZE=1
export MLFLOW_SQLALCHEMYSTORE_MAX_OVERFLOW=1

mlflow server \
    --backend-store-uri postgresql://$DB_DESTINATION_USER:$DB_DESTINATION_PASSWORD@$DB_DESTINATION_HOST:$DB_DESTINATION_PORT/$DB_DESTINATION_NAME \
    --registry-store-uri postgresql://$DB_DESTINATION_USER:$DB_DESTINATION_PASSWORD@$DB_DESTINATION_HOST:$DB_DESTINATION_PORT/$DB_DESTINATION_NAME \
    --default-artifact-root s3://$S3_BUCKET_NAME \
    --no-serve-artifacts \
    --workers 1
