postgres:
	docker run --name postgres13 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:13-alpine

createdb:
	docker exec -it postgres13 createdb --username=root --owner=root micro_bank

dropdb:	
	docker exec -it postgres13 dropdb micro_bank

migrateup:
	migrate -path db/migration-seq -database "postgresql://root:secret@localhost:5432/micro_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration-seq -database "postgresql://root:secret@localhost:5432/micro_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc