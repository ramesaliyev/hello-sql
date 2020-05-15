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

### Basics

<details><summary><strong>syntax</strong></summary><br>

- SQL language is **case insensitive**. By convention, SQL keywords are used in uppercase to make the code easier to read.
- You may notice semicolons (;) at the end of the SQL queries. The semicolon is not a part of the SQL statement. It is used to signal PostgreSQL the end of an SQL statement. The semicolon is also used to separate two SQL statements.

</details>

### Querying

<details><summary><strong>SELECT</strong></summary><br>

**`SELECT`** is being used to query data from tables.

##### Clauses:
- **`DISTINCT`**
  - select distinct rows
- **`ORDER BY`**
  - sort rows
- **`WHERE`**
  - filter rows
- **`LIMIT`** or **`FETCH`**
  - select a subset of rows
- **`GROUP BY`**
  - group rows into groups
- **`HAVING`**
  - filter groups
- **`INNER JOIN`**, **`LEFT JOIN`**, **`FULL OUTER JOIN`**, **`CROSS JOIN`**
  - join with other tables
- **`UNION`**, **`INTERSECT`**, **`EXCEPT`**
  - perform set operations

##### Syntax:

    SELECT
      select_list
    FROM
      table_name;

- `select_list`
  - can be a column or comma to separated list of columns
  - can contain expressions or literal values
  - `*` = select data from all the columns
    - it is not a good practice to use the asterisk because it will effect the size of data retrieved from database and may cause slowness.
    - it is a good practice to specify the column names explicitly
    - use the asterisk (*) shorthand only for the ad-hoc queries to examine the data

##### Usages:

    SELECT first_name FROM customer;

    SELECT first_name, last_name, email FROM customer;

    SELECT * FROM customer;

column alias

    SELECT first_name as name FROM customer;

    SELECT 5 * 3 AS result;

concatenation operator

    SELECT first_name || ' ' || last_name AS email FROM customer;

</details>
<details><summary><strong>ORDER BY</strong></summary><br>

**`ORDER BY`** is being used to sort the result set returned from the `SELECT` statement

##### Syntax:

    SELECT
      column_1,
      column_2
    FROM
      table_name
    ORDER BY
      column_1 [ASC | DESC],
      column_2 [ASC | DESC];

`ASC` option is the default

##### Usages:

    SELECT first_name, last_name FROM customer ORDER BY first_name ASC;

    SELECT first_name, last_name FROM customer ORDER BY first_name ASC, last_name DESC;

 sort rows by expressions

    SELECT first_name, LENGTH(first_name) len FROM customer
    ORDER BY LENGTH(first_name) DESC;

    /* or */

    SELECT first_name, LENGTH(first_name) len FROM customer
    ORDER BY len DESC;

</details>
<details><summary><strong>DISTINCT</strong></summary><br>

**`DISTINCT`** is being used to remove duplicate rows from a result set returned by a query.

- keeps one row for each group of duplicates
- **applied to entire tuple**, not to an attribute of the result
  - which means for a table where only column `a` and `b` exist:
  - `SELECT DISTINCT * FROM table` == `SELECT DISTINCT a, b FROM table`
  - and you cannot use; `SELECT a, DISTINCT b FROM table`

##### Syntax:

    SELECT
      DISTINCT column_1
    FROM
      table_name;

multiple columns are specified, clause will evaluate the duplicate based on the **combination of values of these columns**. in another word, uniqueness of the rows determined by combination of specified columns.

    SELECT
      DISTINCT column_1, column_2
    FROM
      table_name;

##### Usages:

    SELECT DISTINCT bcolor FROM t1 ORDER BY bcolor;

    SELECT DISTINCT bcolor, fcolor FROM t1 ORDER BY bcolor, fcolor;

</details>
<details><summary><strong>DISTINCT ON</strong></summary><br>

**`DISTINCT ON`** is more similar to `GROUP BY` than it is to `DISTINCT`. Query with `DISTINCT ON` first will sorts the result set by the columns in `ORDER BY` clause, and then for each group of duplicates, it keeps the first row in the returned result set. In another word, it tells PostgreSQL to return a single row for each distinct group defined by the `ON` clause, which row in that group is returned is specified with the `ORDER BY` clause.

- is a PostgreSQL addition to the language
- it is good practice to always use the `ORDER BY` clause with the `DISTINCT ON(expression)`
- `DISTINCT ON` expression must match the `leftmost` expression in the `ORDER` BY clause

##### Syntax:

    SELECT
      DISTINCT ON (column_1) column_alias,
      column_2
    FROM
      table_name
    ORDER BY
      column_1,
      column_2;

##### Usages:

    SELECT DISTINCT ON (bcolor) bcolor, fcolor
    FROM t1 ORDER BY bcolor, fcolor;

</details>

### Filtering

<details><summary><strong>WHERE</strong></summary><br>

**`WHERE`** is being used to
- filter rows returned from the `SELECT` statement.
- filter rows will be updated in the `UPDATE` statement
- filter rows will be deleted in the `DELETE` statement

- only rows that cause the condition evaluates to true will be affected
<br>

Following comparison operators can be used;
|Operator|Description|
|---|---|
|=|Equal|
|>|Greater than|
|<|Less than|
|>=|Greater than or equal|
|<=|Less than or equal|
|<> or !=|Not equal|
|AND|Logical operator AND|
|OR|Logical operator OR|
<br>

##### Syntax:

    SELECT select_list
    FROM table_name
    WHERE condition;

- condition must evaluate to `true`, `false`, or `unknown`
- condition can be a `boolean expression` or a `combination of boolean expressions` using **`AND`** and **`OR`** operators

##### Usages:

    SELECT last_name, first_name FROM customer WHERE first_name = 'Jamie';

**`AND`**

    SELECT last_name, first_name FROM customer WHERE first_name = 'Jamie' AND last_name = 'Rice';

**`OR`**

    SELECT first_name, last_name FROM customer WHERE last_name = 'Rodriguez' OR first_name = 'Adam';

**`IN`**, match values by list (*See IN chapter.*)

    SELECT first_name, last_name FROM customer WHERE first_name IN ('Ann','Anne','Annie');

**`LIKE`**, matches string by a specified pattern (*See LIKE chapter.*)

    SELECT first_name, last_name FROM customer WHERE first_name LIKE 'Ann%'

**`BETWEEN`**, matches values which are in a specified range (*See BETWEEN chapter.*)

    SELECT first_name, LENGTH(first_name) name_length FROM customer
    WHERE first_name LIKE 'A%' AND LENGTH(first_name) BETWEEN 3 AND 5
    ORDER BY name_length;

Using with other comparison operators;

    SELECT first_name, last_name FROM customer
    WHERE first_name LIKE 'Bra%' AND  last_name <> 'Motley';

</details>
<details><summary><strong>LIMIT</strong></summary><br>

**`LIMIT`** is being used to get a subset of rows generated by a query.

##### Syntax:

    SELECT select_list
    FROM table_name
    LIMIT n;

- statement returns `n` rows generated by the query
- if `n` is `zero`, the query returns an empty set
- if `n` is `NULL`, it has no effect to query

to skip a number of rows before returning the `n` rows, `OFFSET` clause could be used as follow;

    SELECT select_list
    FROM table_name
    LIMIT n OFFSET m;

- if `m` is `zero`, it has no effect to query
- a large `OFFSET` might not be efficient

##### Usages:

    SELECT film_id, title, release_year
    FROM film ORDER BY film_id LIMIT 5;

    SELECT film_id, title, release_year
    FROM film ORDER BY film_id LIMIT 4 OFFSET 3;

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

##### Restart the stopped container:

    docker start hello_sql

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