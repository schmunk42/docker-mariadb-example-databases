#!/bin/bash

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MariaDB service startup"
    sleep 5
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "status" > /dev/null 2>&1
    RET=$?
done

echo "Checking for databases to import from environment variables INSTALL_<DB_NAME>";

if [ -n "$INSTALL_WORLD" ]; then
    echo "=> Importing example database 'world'"
    unzip world.sql.zip
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE world"
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} world < world.sql
fi

if [ -n "$INSTALL_WORLD_INNODB" ]; then
    echo "=> Importing example database 'world_innodb'"
    unzip world_innodb.sql.zip
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE world_innodb"
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} world_innodb < world_innodb.sql
fi

if [ -n "$INSTALL_SAKILA" ]; then
    echo "=> Importing example database 'sakila'"
    unzip sakila-db.zip
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE sakila"
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} sakila < sakila-db/sakila-schema.sql
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} sakila < sakila-db/sakila-data.sql
fi

if [ -n "$INSTALL_EMPLOYEES" ]; then
    echo "=> Importing example database 'employees'"
    bunzip2 employees_db-full-1.0.6.tar.bz2
    tar -xf employees_db-full-1.0.6.tar
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE employees"
    pushd employees_db
        mysql -uroot -p${MYSQL_ROOT_PASSWORD} employees < employees.sql
    popd
fi

echo "=> Granting access to all databases for '${MYSQL_USER}'"
#mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '{$MYSQL_PASSWORD}'"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION"

echo "=> Done!"
