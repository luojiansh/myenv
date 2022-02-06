#!/bin/sh

docker build --pull -t hw --build-arg UID=$UID --build-arg GID=$GID .
