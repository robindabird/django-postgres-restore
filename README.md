# django-postgres-restore
These repository helps understand how a restoration on a dockerised postgresql database works.

The dumps needs to be created using the following command:
`pg_dump -F c -b -v -f "old_db.pgdump" old_db`

The django application come from https://github.com/oc-courses/decouvrez_django and learned over the course https://openclassrooms.com/fr/courses/4425076-decouvrez-le-framework-django
