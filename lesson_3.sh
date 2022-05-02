#!/bin/sh
docker-compose build && docker-compose up -d
docker exec $(docker ps | grep "0.0.0.0:8000->3000/tcp" | awk {'print$1'}) python parse_docx.py
docker exec $(docker ps | grep "0.0.0.0:8000->3000/tcp" | awk {'print$1'}) python manage.py migrate
docker exec $(docker ps | grep "0.0.0.0:8000->3000/tcp" | awk {'print$1'}) python manage.py loaddata bbk_data
docker exec $(docker ps | grep "0.0.0.0:8000->3000/tcp" | awk {'print$1'}) sed -i 's/\"http\:\/\/localhost\:3000\"\,/\"http\:\/\/localhost\:3000\"\,\"http\:\/\/localhost\"\,\"http\:\/\/127.0.0.1\"/g' /backend/lib_catalog/settings.py
