#!/bin/bash

# Update docker images automatically

## stop the containers
docker-compose -f homeassistant-compose.yml stop
docker-compose -f signal-compose.yml stop

## update
docker-compose pull

## recreate
docker-compose -f homeassistant-compose.yml up -d
docker-compose -f signal-compose.yml up -d

## prune
docker image prune -a
