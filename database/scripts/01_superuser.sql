CREATE ROLE barman SUPERUSER PASSWORD 'barman' LOGIN;
CREATE ROLE streaming_barman WITH REPLICATION PASSWORD 'streaming_barman' LOGIN;
CREATE ROLE disquaire_adm_grp;
CREATE USER disquaire_adm PASSWORD 'disquaire_adm';
GRANT disquaire_adm_grp TO disquaire_adm;
ALTER DATABASE disquaire OWNER TO disquaire_adm_grp;
CREATE TABLE t_pg_restore (id serial, name character varying (10));
