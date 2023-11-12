#!/bin/sh

here="$(cd "$(dirname "$0")" && pwd)"
set -x

cd "${here}"/src

set -e
poetry install

PATH=$PATH:$HOME/.local/bin
export SECRET_KEY=placeholder # the app will overwrite this if dotenv can find the file

poetry run python3 manage.py makemigrations
poetry run python3 manage.py migrate
DJANGO_SUPERUSER_PASSWORD=admin poetry run python3 manage.py createsuperuser --noinput --username admin --email=admin@admin.admin || true
poetry run python3 manage.py runserver
