This repository contains documentation on how to set up a Postgresql server either local or in a docker image and (Postgis/Postgresql) SQL-scripts to load Austria's authoritative address data into a Postgis-enabled Postgresql data base.

Read LICENSE for license information.

Copyright Johann Höchtl 2016 https://github.com/the42/bevaddress-dataload

# Pre-requisites

* Postgresql 9.4 or upwards (Tested: 9.4, 9.5) with Postgis extension enabled.

Information on how to install Postgres and create a database providing the Postgis extension on an Ubuntu (-derivate) is included in the files `install.local` for local installation or `install.docker` for set up in a Docker environment. Both files contain links to documentation and inline comments. You have to configure database passwords in there though, so go through these files carefully.

In case you intend to connect to an already up and running Postgres server, you still require the Postgres command line tools, especially `psql`. Install them using `apt-get install postgresql-client`. The database you create on your running Postgres-server requires the Postgis extension enabled. Once connected to the database, you can install this extension by issuing `CREATE EXTENSION postgis;` You may also check if the Postgis-extension is installed properly by running the query `SELECT PostGIS_full_version();`.

# Installation
Once the Postgres database is up and running, you need the database server IP and port address, the database name which will hold the address data as well as username and password with the sufficient rights to create tables, alter tables, create indices and load data from CSV files.

1. Download the latest Address data from http://www.bev.gv.at/portal/page?_pageid=713,2601271&_dad=portal&_schema=PORTAL and unzip. Files named `Adresse_Relationale_Tabellen-Stichtagsdaten_15072015.zip` and `Adresse_Relationale_Tabellen-Stichtagsdaten.zip` are known to work. You should now have a couple of CSV files like ADRESSE.CSV and the like as well as a German PDF explaining the content and structure of the various CSV files.
2. Open a terminal and cd into the directory containing the just unzipped files.
3. Use the psql command line tool to load the data into the server:  
`psql -h HOST -p PORT -U username -W password -f create.sql`

Replace HOST, PORT, USERNAME, and PASSWORD with the correct values for your database server IP address and port, the database to connect to and the database superuser username and password. The parameter `-f create.sql` is the name of the SQL-script, which creates the data tables, performs data transformations for easier queries, and creates indices for faster lookups and full text queries. As you are running `psql` from within the directory you have the address data files unzipped to, you have to specify the path to the file `create.sql` where you cloned this repository into.

`create.sql` contains some nifty transformations like converting geo-coordinates from datum Austria to the more widespread WGS-coordinate system used by OpenStreetMap or Google Maps. Read the comments in there for more information.
