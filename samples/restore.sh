#!/bin/bash
set -x

# dvdrental
psql -Upostgres -c "CREATE DATABASE dvdrental;"
pg_restore -U postgres -d dvdrental /tmp/samples/dvdrental
