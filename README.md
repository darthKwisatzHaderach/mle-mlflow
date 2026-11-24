# Улучшение baseline-модели

Проект по улучшению baseline-модели предсказания целевого события клиентов (оттока).

Задача бинарной классификации: по данным о клиентах спрогнозировать колонку `target`.
Основная метрика — F1, дополнительная — ROC-AUC.

Цель проекта — сделать процесс воспроизводимым и улучшить метрики базовой модели:
- развернуть MLflow (Tracking Server и Model Registry) на PostgreSQL и S3;
- провести EDA и залогировать его в MLflow;
- сгенерировать признаки (sklearn, autofeat), обучить новую версию модели;
- отобрать признаки (mlxtend), обучить новую версию модели;
- подобрать гиперпараметры (Optuna, GridSearchCV), обучить финальную версию модели.

Стек: Python 3.10, pandas, scikit-learn, CatBoost, autofeat, mlxtend, Optuna, MLflow, Jupyter.

Все запуски ведутся в одном эксперименте `project_model_improvement` (id 18),
модели регистрируются в реестре под именем `project_churn_model`.

## Установка и запуск

1. Клонировать репозиторий:

   git clone https://github.com/darthKwisatzHaderach/mle-mlflow.git
   cd mle-mlflow

2. Создать виртуальное окружение и установить зависимости:

   python3.10 -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt

3. Создать в корне проекта файл `.env` с кредами к базам данных и S3
   (шаблон — в `.env_template`):
   - `DB_DESTINATION_*` — личная база данных PostgreSQL;
   - `S3_BUCKET_NAME`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` — хранилище артефактов.

## Руководство по проекту

### Этап 1. Разворачивание MLflow и регистрация модели

1. Поднять MLflow Tracking Server и Model Registry (запускать из корня проекта):

   bash mlflow_server/run_mlflow_server.sh

   Скрипт читает `.env`, поднимает сервер на PostgreSQL (backend- и registry-store)
   и использует S3 как хранилище артефактов. После запуска трекинг-сервер
   доступен на http://127.0.0.1:5000.

2. Зарегистрировать baseline-модель: открыть и выполнить ноутбук
   `mlflow_server/register_baseline.ipynb`.

   Ноутбук загружает модель и данные из проекта предыдущего спринта (mle-dvc),
   оценивает её на тестовой выборке, логирует в MLflow параметры, метрики
   и артефакты и регистрирует модель в реестре.

Ссылки:
- Shell-скрипт: `mlflow_server/run_mlflow_server.sh`
- Эксперимент: `project_model_improvement` (id 18)
- Модель в реестре: `project_churn_model`, версия 1
- Бакет S3: `mle-20261116-6e3c0fa5fe18`
