#!/bin/bash
docker network create fnet
docker build -t frontend:1st -f ./frontend/Dockerfile ./frontend
docker run --name frontend_1sthomework --network=fnet -p 80:80 -d frontend:1st
