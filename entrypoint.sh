#!/bin/sh
set -e

cd netbox
python3 manage.py migrate
python3 manage.py collectstatic --no-input

exec "$@"
