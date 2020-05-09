# Hello SQL!

Well, this is not my first *hello* to SQL, but I hope it's going to be the last one.<br>
These document contains examples that done with [PostgreSQL](https://www.postgresql.org/).

![SQL Join Diagrams](./assets/sql_joins.png)

# Topics

## PSQL Commands

<details><summary><strong>basics</strong></summary><br>

  - **`\?`** show help for psql commands
  - **`\l`** list databases
  - **`\h`** list available SQL commands
  - **`\h [NAME]`** help on syntax of SQL command

</details>

# Setup

I'm using [Docker](https://www.docker.com/) to run [PostgreSQL](https://www.postgresql.org/) in containerized environment. So make sure [Docker Engine](https://docs.docker.com/engine/install/) is up & running on your machine.

Then just use [run](./run.sh) script to login directly into container;

    bash ./run.sh

This will bring you directly to the `psql`. You can exit from here by typing `exit` or using `CTRL + D`. Remember exiting from here will not going to stop the actual docker container. To stop it use `docker stop hello_sql` command.

# Resources

## Primary Learning Sources by Order
- [ ] [PostgreSQL Tutorial (.com)](https://www.postgresqltutorial.com/)
- [ ] [Mode - Introduction to SQL](https://mode.com/sql-tutorial/introduction-to-sql/)

## Exercise Platforms
- [ ] [Hackerrank](https://www.hackerrank.com/domains/sql)
- [ ] [Codewars](https://www.codewars.com/)

## Tutorials
- [x] [Tricks for Postgres and Docker](https://martinheinz.dev/blog/3)