# Hello SQL!

Well, this is not my first *hello* to SQL, but I hope it's going to be the last one.<br>
These document contains examples that done with [PostgreSQL](https://www.postgresql.org/).

![SQL Join Diagrams](./assets/sql_joins.png)

# Topics

## About PostgreSQL

<details><summary><strong>features</strong></summary><br>

- User-defined types
- Table inheritance
- Sophisticated locking mechanism
- Foreign key referential integrity
- Views, rules, subquery
- Nested transactions (savepoints)
- Multi-version concurrency control (MVCC)
- Asynchronous replication
- Tablespaces
- Point-in-time recovery

</details>

## SQL

### Querying

<details><summary><strong>select</strong></summary><br>

</details>

## Misc

### PSQL Commands

<details><summary><strong>basics</strong></summary><br>

  - **`\?`** show help for psql commands
  - **`\l`** list databases
  - **`\h`** list available SQL commands
  - **`\h [NAME]`** help on syntax of SQL command

</details>

### Utilities

<details><summary><strong>pg_restore</strong></summary><br>

`pg_restore` restores a PostgreSQL database from an archive created by pg_dump.

To restore from a `.tar.gz` file, copy your file under the `/tmp` folder, and then;

    # extract the tar.gz
    tar xvzf hello.tar.gz

    # remember to create database
    CREATE DATABASE hello;

    # restore the database
    pg_restore -cv -U postgres -d hello /tmp/hello

</details>

# Dockerized Setup

I'm using [Docker](https://www.docker.com/) to run [PostgreSQL](https://www.postgresql.org/) in containerized environment. So make sure [Docker Engine](https://docs.docker.com/engine/install/) is up & running on your machine.

## Bootup

Just use [boot](./scripts/boot.sh) script to create and login directly into container;

    bash ./scripts/boot.sh

This will bring you directly to the `psql`. You can exit from here by typing `exit` or using `CTRL + D`. Remember exiting from here will not going to stop the actual docker container. To stop it use `docker stop hello_sql` command.

**Note that:**
- each time you run the `boot` script, it'll recreate the container from scratch, hence your data will lost. To keep your data, use commands I listed below to connect to already running database container.
- sometimes boot process will crash, dont know why, just rerun the script.

To connect PostgreSQL via an app, such as [Postico](https://eggerapps.at/postico/), use following settings; `host=localhost`, `port=7654`, `user=postgres` with no password.

## Exec

To exec some command within the container do `docker exec -it hello_sql <command>`, see example commands below.

##### Logging into bash:

    docker exec -it hello_sql bash

##### Logging into psql:

    docker exec -it hello_sql psql -Upostgres

##### Copying file to container:

    docker cp /Users/ramesaliyev/Downloads/hello.tar.gz hello_sql:/tmp

## Sample Databases

All databases you would see under the [samples](./samples/) folder will be ready to use for you. All of them first going to be copied under `/tmp/samples` folder and restored automatically into the Postgres. Just use `\l` psql command or your favorite app to list databases to see.

# Resources

## Primary Learning Sources by Order
- [ ] [PostgreSQL Tutorial (.com)](https://www.postgresqltutorial.com/)
- [ ] [Mode - Introduction to SQL](https://mode.com/sql-tutorial/introduction-to-sql/)

## Exercise Platforms
- [ ] [Hackerrank](https://www.hackerrank.com/domains/sql)
- [ ] [Codewars](https://www.codewars.com/)

## Tutorials
- [x] [Tricks for Postgres and Docker](https://martinheinz.dev/blog/3)