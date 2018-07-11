#!/bin/sh
set -e

python3 manage.py migrate
python3 manage.py collectstatic --no-input

exec "$@"
