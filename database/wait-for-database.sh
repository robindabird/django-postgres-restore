#!/bin/sh
# wait-for-postgres.sh

set -e

host="$1"
shift
cmd="$@"

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

COUNT=$(PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" -qAt -c "SELECT COUNT(1) FROM t_pg_restore;")
until [ $COUNT -eq 1 ]
do
  echo $COUNT
  >&2 echo "Restoration is still in progress"
  sleep 1
done
