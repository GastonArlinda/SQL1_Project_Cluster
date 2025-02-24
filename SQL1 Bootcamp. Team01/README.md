## General Rules

- Use this page as your only reference. Do not listen to rumors and speculations about how to prepare your solution.
- Make sure you are using the latest version of PostgreSQL.
- It is perfectly fine if you use the IDE to write source code (aka SQL script).
- To be evaluated, your solution must be in your GIT repository.
- Your solutions will be evaluated by your peers.
- You should not leave any files in your directory other than those explicitly specified by the exercise instructions. It is recommended that you modify your `.gitignore` to avoid accidents.
- Got a question? Ask your neighbor to the right. Otherwise, try your neighbor on the left.
- Your reference manual: mates / Internet / Google. 
- Read the examples carefully. You may need things not specified in the topic.
- And may the SQL-Force be with you!
Absolutely anything can be represented in SQL! Let's get started and have fun!

## Chapter III
## Rules of the day

- Please make sure you have your own database and access to it on your PostgreSQL cluster. 
- All tasks contain a list of Allowed and Denied sections with listed database options, database types, SQL constructions etc. Please have a look at the section before you start.
- Please download a [script](materials/rush01_model.sql) with Database Model here and apply the script to your database (you can use command line with psql or just run it through any IDE, for example DataGrip from JetBrains or pgAdmin from PostgreSQL community). 
- Please take a look at the Logical View of our Database Model. 

![schema](misc/images/schema.png)


## Chapter IV
## Exercise 00 — Classical DWH

| Exercise 00: Classical DWH|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex00                                                                                                                     |
| Files to turn-in                      | `team01_ex00.sql`                                                                           |
| **Allowed**                               |                                                                                                                          |
| Language                        |  SQL|

Let's take a look at the data sources and the first logical data layer (ODS — Operational Data Store) in the DWH.

![T01_05](misc/images/T01_05.png)

`User` table Definition (in a Green Source Database):

| Column Name | Description |
| ------ | ------ |
| ID | Primary Key |
| name | Name of User |
| lastname | Last name of User |

`Currency` table Definition (in a Red Source Database):

| Column Name | Description |
| ------ | ------ |
| ID | Primary Key |
| name | Currency Name |
| rate_to_usd | Ratio to USD currency |

`Balance` table Definition (in a Blue Source Database):

| Column Name | Description |
| ------ | ------ |
| user_id | "Virtual Foreign Key" to User table from other source |
| money | Amount of money |
| type | Type of balance (can be 0,1,...) |
| currency_id | "Virtual Foreign Key" to Currency table from other source |

Green, Red, and Blue databases are independent data sources and fit the microservice pattern. This means that there is a high risk of data anomalies (see below).
- Tables are not in data consistency. It means that there is a User, but there are no rows in the Balance table, or vice versa, there is a Balance, but there are no rows in the User table. The same situation exists between the Currency and Balance tables. (In other words, there are no explicit foreign keys between them).
- Possible NULL values for Name and Lastname in the User table.
- All tables are working under OLTP (OnLine Transactional Processing) SQL traffic. It means that there is a current state of data at a time, historical changes are not stored for each table.

These 3 listed tables are data sources for the tables with similar data models in the DWH area.

`User` table Definition (in a DWH Database):

| Column Name | Description |
| ------ | ------ |
| ID | Primary Key |
| name | Name of User |
| lastname | Last name of User |

`Currency` table Definition (in a DWH Database):

| Column Name | Description |
| ------ | ------ |
| ID | Mocked Primary Key |
| name | Currency Name |
| rate_to_usd | Ratio to USD currency |
| updated | Timestamp of event from source database |

`Mocked Primary Key` means that there are duplicates with the same ID because a new updated attribute has been added that changes our Relational Model to Temporal Relational Model. 

Please take a look at the data sample for currency "EUR" below.
This example is based on the SQL statement:

    SELECT *
    FROM Currency
    WHERE name = ‘EUR’
    ORDER BY updated DESC;

| ID | name | rate_to_usd | updated |
| ------ | ------ | ------ | ------ |
| 100 | EUR | 0.9 | 03.03.2022 13:31 |
| 100 | EUR | 0.89 | 02.03.2022 12:31 |
| 100 | EUR | 0.87 | 02.03.2022 08:00 |
| 100 | EUR | 0.9 | 01.03.2022 15:36 |
| ... | ... | ... | ... |

`Balance` table Definition (in a DWH Database):

| Column Name | Description |
| ------ | ------ |
| user_id | "Virtual Foreign Key" to User table from other source |
| money | Amount of money |
| type | Type of balance (can be 0,1,...) |
| currency_id | "Virtual Foreign Key" to Currency table from other source |
| updated | Timestamp of event from source database |

Please take a look at the data sample.
This example is based on the SQL statement:

    SELECT *
    FROM Balance
    WHERE user_id = 103
    ORDER BY type, updated DESC;

| user_id | money | type | currency_id | updated |
| ------ | ------ | ------ | ------ | ------ |
| 103 | 200 | 0 | 100 | 03.03.2022 12:31 |
| 103 | 150 | 0 | 100 | 02.03.2022 11:29 |
| 103 | 15 | 0 | 100 | 03.03.2022 08:00 |
| 103 | -100 | 1 | 102 | 01.03.2022 15:36 |
| 103 | 2000 | 1 | 102 | 12.12.2021 15:36 |
| ... | ... | ... | ... |... |

All tables in the DWH inherit all anomalies from the source tables.
- Tables are not in data consistency. 
- Possible NULL values for Name and Lastname in the User table.

Please write an SQL statement that returns the total volume (sum of all money) of transactions from the user balance aggregated by user and balance type. Note that all data should be processed, including data with anomalies. Below is a table of result columns and the corresponding calculation formula.

| Output Column | Formula (pseudocode) |
| ------ | ------ |
| name | source: user.name if user.name is NULL then return `not defined` value |
| lastname | source: user.lastname if user.lastname is NULL then return `not defined` value |
| type | source: balance.type | 
| volume | source: balance.money need to summarize all money “movements” | 
| currency_name | source: currency.name if currency.name is NULL then return `not defined` value | 
| last_rate_to_usd | source: currency.rate_to_usd. take a last currency.rate_to_usd for corresponding currency if currency.rate_to_usd is NULL then return 1 | 
| total_volume_in_usd | source: volume , last_rate_to_usd. make a multiplication between volume and last_rate_to_usd |

See a sample of the output data below. Sort the result by User Name in descending order, and then by User Lastname and Balance type in ascending order.

| name | lastname | type | volume | currency_name | last_rate_to_usd | total_volume_in_usd |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| Петр | not defined | 2 | 203 | not defined | 1 | 203 |
| Иван | Иванов | 1 | 410 | EUR | 0.9 | 369 |
| ... | ... | ... | ... | ... | ... | ... |


## Chapter V
## Exercise 01 — Detailed Query

| Exercise 01: Detailed Query|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex01                                                                                                                     |
| Files to turn-in                      | `team01_ex01.sql`                                                                             |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL|


Before diving deeper into this task, please apply the following INSERT statements.

`insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');`
`insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');`

Please write an SQL statement that returns all Users, all Balance transactions (in this task please ignore Currencies that do not have a key in the `Currency` table) with currency name and calculated value of the currency in USD for the next day.

Below is a table of result columns and the corresponding calculation formula.

| Output Column | Formula (pseudocode) |
| ------ | ------ |
| name | source: user.name if user.name is NULL then return `not defined` value |
| lastname | source: user.lastname if user.lastname is NULL then return `not defined` value |
| currency_name | source: currency.name | 
| currency_in_usd | involved sources: currency.rate_to_usd, currency.updated, balance.updated.Take a look at a graphical interpretation of the formula below.| 

![T01_06](misc/images/T01_06.png)

- You need to find a nearest rate_to_usd of currency in the past (t1).
- If t1 is empty (means no rates in the past), then find a nearest rate_to_usd of currency in the future (t2).
- Use t1 OR t2 rate to calculate a currency in USD format.

See a sample of the output below. Sort the result by User Name in descending order and then by User Lastname and Currency name in ascending order.

| name | lastname | currency_name | currency_in_usd |
| ------ | ------ | ------ | ------ |
| Иван | Иванов | EUR | 150.1 |
| Иван | Иванов | EUR | 17 |
| ... | ... | ... | ... |


