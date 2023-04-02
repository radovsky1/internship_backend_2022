FROM migrate/migrate:4

WORKDIR /app

COPY scripts/migrate.sh migrate.sh
COPY migrations /app/migrations

ENTRYPOINT ["sh", "migrate.sh"]