#!/bin/bash
set -x

# dvdrental
psql -U postgres -c "CREATE DATABASE dvdrental;"
pg_restore -U postgres -d dvdrental /tmp/samples/dvdrental

psql -U postgres -c "CREATE DATABASE pieces;"
psql -U postgres -d pieces -a -f /tmp/samples/pieces/pieces.sql
