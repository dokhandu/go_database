postgres:
	docker run --name postgres15 -p 5431:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=postgres -d postgres:15-alpine

create_db:
	docker exec -it postgres15 createdb --username=root --owner=root simplebank

drop_db:
	docker exec -it postgres15 dropdb simplebank

migrate_up:
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5431/simplebank?sslmode=disable" -verbose up

migrate_down:
	migrate -path db/migration -database "postgresql://root:postgres@localhost:5431/simplebank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres create_db drop_db migrate_down migrate_up sqlc test