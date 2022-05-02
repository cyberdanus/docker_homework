#!/bin/bash
docker network create bnet
docker run --name database --network=bnet -p 5432:5432 -e POSTGRES_USER=django -e POSTGRES_PASSWORD=django -e POSTGRES_DB=django -e PGDATA=/var/lib/postgresql/data/pgdata -d -v /database:/var/lib/postgresql/data postgres:14
docker build -t backend:2nd -f ./lib_catalog/Dockerfile ./lib_catalog
docker run --name backend_2ndhomework --network=bnet -p 8000:3000 -d -it backend:2nd
docker exec $(docker ps | grep "0.0.0.0:8000->3000/tcp" | awk {'print$1'}) python parse_docx.py
docker exec $(docker ps | grep "0.0.0.0:8000->3000/tcp" | awk {'print$1'}) python manage.py migrate && python manage.py loaddata bbk_data
docker exec $(docker ps | grep "0.0.0.0:8000->3000/tcp" | awk {'print$1'}) sed -i 's/\"http\:\/\/localhost\:3000\"\,/\"http\:\/\/localhost\:3000\"\,\"http\:\/\/localhost\"\,\"http\:\/\/127.0.0.1\"/g' /backend/lib_catalog/settings.py
