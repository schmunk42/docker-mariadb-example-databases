MariaDB Docker container with example databases.


### Run

	docker run -e MARIADB_PASS=secretadmin -p 33066:3306 -d schmunk42/mariadb-example-databases
	

### Build

	docker build -t schmunk42/mariadb-example-databases .
