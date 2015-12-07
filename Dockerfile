FROM tutum/mariadb:10.1

# Install extra system packages
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
ADD sql-files/ /sql-files/

WORKDIR /sql-files

ADD container-files/ /
RUN chmod 700 /create_mariadb_admin_user.sh
