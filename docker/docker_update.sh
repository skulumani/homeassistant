#!/bin/bash

# Update docker images automatically

## stop the containers
# docker-compose -f homeassistant-compose.yml stop
# docker-compose -f signal-compose.yml stop

## update
docker-compose pull
docker-compose down

## recreate
# docker-compose -f homeassistant-compose.yml up -d
# docker-compose -f signal-compose.yml up -d
docker-compose up -d

## prune
docker image prune -fa
docker volume prune -f
