FROM mysql:8.0

ENV MYSQL_DATABASE=hospital_db
ENV MYSQL_ROOT_PASSWORD=root

COPY scripts/ /docker-entrypoint-initdb.d/