MariaDB Docker container with example databases from MySQL
==========================================================

This is image can be used to install demo databases in a MariaDB container on startup.

### Configuration

Set environment variables to setup database schema with script, see `docker-compose.yml`

- `INSTALL_WORLD=1`
- `INSTALL_WORLD_INNODB=1`
- `INSTALL_SAKILA=1`
- `INSTALL_EMPLOYEES=1`

### Usage

	docker-compose up -d
	docker-compose exec mariadb /init-example-databases.sh


### Build

	docker build -t schmunk42/mariadb-example-databases .


### Links

- [GitHub source-code](https://github.com/schmunk42/docker-mariadb-example-databases)
- [Docker Hub images](https://hub.docker.com/r/schmunk42/mariadb-example-databases/)
- [Base image from tutum](https://github.com/tutumcloud/mariadb)
- [Data from MySQL](http://dev.mysql.com/doc/index-other.html)

---

*Built by [*dmstr](http://diemeisterei.de)*
