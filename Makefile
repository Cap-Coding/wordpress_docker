up:
	docker-compose up -d

down:
	docker-compose down

rebuild:
	docker-compose down -v --remove-orphans
	docker-compose rm -vsf
	docker-compose up -d --build

prod_up:
	docker-compose -f docker-compose_prod.yml up -d

prod_down:
	docker-compose -f docker-compose_prod.yml down -v

prod_build:
	docker-compose -f docker-compose_prod.yml build

prod_rebuild:
	docker-compose -f docker-compose_prod.yml down -v --remove-orphans
	docker-compose -f docker-compose_prod.yml rm -vsf
	docker-compose -f docker-compose_prod.yml up -d --build

db_backup:
	// FIXME
	docker-compose -f docker-compose_prod.yml exec db sh -c 'exec mysqldump -u root -p"$${MYSQL_ROOT_PASSWORD}" $${MYSQL_DATABASE}' > ./db-backups/db_backup_$$(date + '%Y_%m_%d')_prod.sql
	git add ./db-backups
	git commit -m"db backup" ./db-backups

#cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root -p"$MYSQL_ROOT_PASSWORD" smm_db
