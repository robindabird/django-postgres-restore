#!/bin/sh

psql -p 5432 -U ${POSTGRES_USER} -c "CREATE ROLE ${POSTGRES_DB}_adm_grp;"
psql -p 5432 -U ${POSTGRES_USER} -c "CREATE ROLE ${POSTGRES_DB}_usr_grp;"
psql -p 5432 -U ${POSTGRES_USER} -c "CREATE ROLE ${POSTGRES_DB}_qry_grp;"
psql -p 5432 -U ${POSTGRES_USER} -c "CREATE USER ${POSTGRES_DB}_adm PASSWORD '${POSTGRES_DB}_adm';"
psql -p 5432 -U ${POSTGRES_USER} -c "CREATE USER ${POSTGRES_DB}_usr PASSWORD '${POSTGRES_DB}_usr';"
psql -p 5432 -U ${POSTGRES_USER} -c "CREATE USER ${POSTGRES_DB}_qry PASSWORD '${POSTGRES_DB}_qry';"
psql -p 5432 -U ${POSTGRES_USER} -c "GRANT ${POSTGRES_DB}_adm_grp TO ${POSTGRES_DB}_adm;"
psql -p 5432 -U ${POSTGRES_USER} -c "GRANT ${POSTGRES_DB}_usr_grp TO ${POSTGRES_DB}_usr;"
psql -p 5432 -U ${POSTGRES_USER} -c "GRANT ${POSTGRES_DB}_qry_grp TO ${POSTGRES_DB}_qry;"
psql -p 5432 -U ${POSTGRES_USER} -c "ALTER DATABASE ${POSTGRES_DB} OWNER TO ${POSTGRES_DB}_adm_grp;"


FILE=/dumps/${POSTGRES_DB}.pgdump
echo "${FILE}"
psql -p 5432 -U ${POSTGRES_USER} -c "DROP TABLE IF EXISTS t_pg_restore;"
psql -p 5432 -U ${POSTGRES_USER} -c "CREATE TABLE t_pg_restore(id serial, name character varying(2));"
if test -f "$FILE"; then
    echo "$FILE exists."
    #psql -p 5432 -U ${POSTGRES_USER} -d  ${POSTGRES_DB} -f ${FILE}
    pg_restore -p 5432 -U ${POSTGRES_USER} -d ${POSTGRES_DB} ${FILE}
fi
psql -p 5432 -U ${POSTGRES_USER} -c "INSERT INTO t_pg_restore (name) VALUES ('OK');"
for tbl in `psql -qAt -c "select tablename from pg_tables where schemaname = 'public';" ${POSTGRES_DB}` ; do  psql -c "alter table \"$tbl\" owner to ${POSTGRES_DB}_adm_grp" ${POSTGRES_DB} ; done
for tbl in `psql -qAt -c "select sequence_name from information_schema.sequences where sequence_schema = 'public';" ${POSTGRES_DB}` ; do  psql -c "alter sequence \"$tbl\" owner to ${POSTGRES_DB}_adm_grp" ${POSTGRES_DB} ; done
for tbl in `psql -qAt -c "select table_name from information_schema.views where table_schema = 'public';" ${POSTGRES_DB}` ; do  psql -c "alter view \"$tbl\" owner to ${POSTGRES_DB}_adm_grp" ${POSTGRES_DB} ; done

psql -p 5432 -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA public TO ${POSTGRES_DB}_usr;"
psql -p 5432 -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "GRANT USAGE,SELECT ON ALL SEQUENCES IN SCHEMA public TO ${POSTGRES_DB}_usr;"
psql -p 5432 -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO ${POSTGRES_DB}_usr;"
