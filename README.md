# django-postgres-restore
These repository helps understand how a restoration on a dockerised postgresql database works.

The dumps needs to be created using the following command:
`pg_dump -F c -b -v -f "old_db.pgdump" old_db`
