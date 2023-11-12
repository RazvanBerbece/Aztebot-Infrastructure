package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
	migrate "github.com/rubenv/sql-migrate"
)

func main() {

	godotenv.Load()
	dbConnString := os.Getenv("DB_ROOT_CONNSTRING")

	db, err := sql.Open("mysql", dbConnString)
	if err != nil {
		log.Fatalf("Error occured while connecting to database for migration: %s", err)
	}

	migrations := &migrate.FileMigrationSource{
		Dir: "history",
	}

	n, err := migrate.Exec(db, "mysql", migrations, migrate.Up)
	if err != nil {
		log.Fatalf("Error occured while running UP migrations: %s", err)
	}

	fmt.Printf("Applied %d migrations!\n", n)

}
