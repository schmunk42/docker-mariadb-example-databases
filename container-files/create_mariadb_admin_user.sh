#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MariaDB service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done


PASS=${MARIADB_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${MARIADB_PASS} ] && echo "preset" || echo "random" )

echo "Checking for databases to import from environment variables INSTALL_<DB_NAME>";

if [ -n "$INSTALL_WORLD" ]; then
    echo "=> Importing example database 'world'"
    unzip world.sql.zip
    mysql -uroot -e "CREATE DATABASE world"
    mysql -uroot world < world.sql
fi

if [ -n "$INSTALL_WORLD_INNODB" ]; then
    echo "=> Importing example database 'world_innodb'"
    unzip world_innodb.sql.zip
    mysql -uroot -e "CREATE DATABASE world_innodb"
    mysql -uroot world_innodb < world_innodb.sql
fi

if [ -n "$INSTALL_SAKILA" ]; then
    echo "=> Importing example database 'sakila'"
    unzip sakila-db.zip
    mysql -uroot -e "CREATE DATABASE sakila"
    mysql -uroot sakila < sakila-db/sakila-schema.sql
    mysql -uroot sakila < sakila-db/sakila-data.sql
fi

if [ -n "$INSTALL_EMPLOYEES" ]; then
    echo "=> Importing example database 'employees'"
    bunzip2 employees_db-full-1.0.6.tar.bz2
    tar -xf employees_db-full-1.0.6.tar
    mysql -uroot -e "CREATE DATABASE employees"
    pushd employees_db
        mysql -uroot employees < employees.sql
    popd
fi

echo "=> Creating MariaDB admin user with ${_word} password"
mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"

echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this MariaDB Server using:"
echo ""
echo "    mysql -uadmin -p$PASS -h<host> -P<port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "MariaDB user 'root' has no password but only allows local connections"
echo "========================================================================"

mysqladmin -uroot shutdown