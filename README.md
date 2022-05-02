lesson 1 complete

docker network create fnet
docker build -t frontend:1st -f ./frontend/Dockerfile ./frontend
docker run --name frontend_1sthomework --network=fnet -p 80:80 -d frontend:1st

lesson 2 complete

docker network create bnet
docker run --name database --network=bnet -p 5432:5432 -e POSTGRES_USER=django -e POSTGRES_PASSWORD=django -e POSTGRES_DB=django -e PGDATA=/var/lib/postgresql/data/pgdata -d -v /database:/var/lib/postgresql/data postgres:14
docker build -t backend:2nd -f ./lib_catalog/Dockerfile ./lib_catalog
docker run --name backend_2ndhomework --network=bnet -p 8000:3000 -d -it backend:2nd
docker exec $(docker ps | grep "0.0.0.0:8000->3000/tcp" | awk {'print$1'}) python parse_docx.py
docker exec $(docker ps | grep "0.0.0.0:8000->3000/tcp" | awk {'print$1'}) python manage.py migrate && python manage.py loaddata bbk_data
docker exec $(docker ps | grep "0.0.0.0:8000->3000/tcp" | awk {'print$1'}) sed -i 's/\"http\:\/\/localhost\:3000\"\,/\"http\:\/\/localhost\:3000\"\,\"http\:\/\/localhost\"\,\"http\:\/\/127.0.0.1\"/g' /backend/lib_catalog/settings.py


# docker_homework
# 1 Лекция
Написать Dockerfile для frontend располагается в директории /frontend, собрать и запустить
# 2 Лекция
Написать Dockerfile для backend который располагается в директории /lib_catalog(для сборки контейнера необходимо использовать файл /lib_catalog/requirements.txt), для работы backend необходим postgresql, т.е. необходимо собрать 2 контейнера:
1. backend
2. postgresql

Осуществить сетевые настройки, для работы связки backend и postgresql
# 3 Лекция
Написать docker-compose.yaml, для всего проекта, собрать и запустить

# Критерий оценки финального задания
1. Dockerfile должны быть написаны согласно пройденным best practices
2. Для docker-compose необходимо использовать локальное image registry
3. В docker-compose необходимо сетевые настройки 2 разных интерфейса(bridge), 1 - для фронта, 2 - для бека с postgresql

4.* Осущиствить сборку проекта самим docker-compose команда docker-compose build(при использовании этого подхода необходимо исключить 2 пункт из критерии оценки)
