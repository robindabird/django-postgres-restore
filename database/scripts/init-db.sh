#!/bin/sh
FILE=/dumps/${POSTGRES_DB}.pgdump
echo "${FILE}"
psql -p 5432 -U ${POSTGRES_USER} -c "DROP TABLE IF EXISTS t_pg_restore;"
psql -p 5432 -U ${POSTGRES_USER} -c "CREATE TABLE t_pg_restore(id serial, name character varying(2));"
if test -f "$FILE"; then
    echo "$FILE exists."
    pg_restore -p 5432 -U ${POSTGRES_USER} -d ${POSTGRES_DB} ${FILE}
fi
psql -p 5432 -U ${POSTGRES_USER} -c "INSERT INTO t_pg_restore (name) VALUES ('OK');"
exit
