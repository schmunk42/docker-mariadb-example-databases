FROM tutum/mariadb:10.1

# Install extra system packages
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
ADD https://launchpad.net/test-db/employees-db-1/1.0.6/+download/employees_db-full-1.0.6.tar.bz2 /sql-files/
ADD http://downloads.mysql.com/docs/world.sql.zip /sql-files/
ADD http://downloads.mysql.com/docs/world_innodb.sql.zip /sql-files/
ADD http://downloads.mysql.com/docs/sakila-db.zip /sql-files/

WORKDIR /sql-files

ADD container-files/ /
RUN chmod 700 /create_mariadb_admin_user.sh
