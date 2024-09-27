#!/bin/bash

DATA_SOURCE_USER=postgres
DATA_SOURCE_PASS=postgres
DATA_SOURCE_URI=localhost:5432/postgres?sslmode=disable

/caminho/para/o/binario/postgres_exporter --config.file /caminho/para/o/postgres_exporter.yml