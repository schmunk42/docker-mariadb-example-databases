MariaDB Docker container with example databases from MySQL
==========================================================

This is image can be used to install demo databases in a MariaDB container on startup.

### Run

	docker run -d \
	    -e INSTALL_SAKILA=1 \
	    -e MARIADB_PASS=secretadmin \
	    -p 33066:3306 \
	    schmunk42/mariadb-example-databases

### Configure

Set environment `-e ...` variable to setup database schema and data on startup

- `INSTALL_WORLD=1`
- `INSTALL_WORLD_INNODB=1`
- `INSTALL_SAKILA=1`
- `INSTALL_EMPLOYEES=1`

### Build

	docker build -t schmunk42/mariadb-example-databases .


### Links

- [GitHub source-code](https://github.com/schmunk42/docker-mariadb-example-databases)
- [Docker Hub images](https://hub.docker.com/r/schmunk42/mariadb-example-databases/)
- [Base image from tutum](https://github.com/tutumcloud/mariadb)
- [Data from MySQL](http://dev.mysql.com/doc/index-other.html)

---

*Build by [*dmstr](http://diemeisterei.de), Stuttgart*