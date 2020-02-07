# Game Library Database
MySQL Database and Flask REST API for Game Library Manager

This repo contains the implementation for the database and server for Game Library Manager:

https://github.com/myuimu/Game-Library-Manager/

The instructions in this README are geared towards running the database and server on a single Linux machine.

## Requirements
* Python 3
* Python Packages:
  * Flask
  * Flask-HTTPAuth
  * Flask-MySQL
  * Flask-RESTful
  * Gunicorn
  * Passlib
* MariaDB/MySQL

## Configuration
* If this is the first time running MariaDB, configure the directories:
`mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql`
* Execute `proc.sql` in MySQL
* Modify `config.ini` to contain the database credentials. If running locally, set host to `localhost`

## Execution
* To run the debug server:
`python3 api.py`
* To run the deployment server:
`gunicorn api:app`

#### TODO
* Switch to token based authentication
* Allow more ways to sort data
* Implement a friends list system
