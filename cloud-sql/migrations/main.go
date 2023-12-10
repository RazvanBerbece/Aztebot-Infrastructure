package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
	migrate "github.com/rubenv/sql-migrate"

	"cloud.google.com/go/cloudsqlconn"
	"cloud.google.com/go/cloudsqlconn/mysql/mysql"
)

func main() {

	godotenv.Load()

	dbConnString := os.Getenv("DB_ROOT_CONNSTRING")
	cloudDbConnString := os.Getenv("DB_ROOT_CLOUDSQL_CONNSTRING")
	env := os.Getenv("ENVIRONMENT")

	migrations := &migrate.FileMigrationSource{
		Dir: "history",
	}

	if env == "stg" {
		// Running migration locally (in containerised mysql instance)
		db, err := sql.Open("mysql", dbConnString)
		if err != nil {
			log.Fatalf("Error occured while connecting to database for migration: %s", err)
		}

		n, err := migrate.Exec(db, "mysql", migrations, migrate.Up)
		if err != nil {
			log.Fatalf("Error occured while running UP migrations: %s", err)
		}

		fmt.Printf("Applied %d migrations to local database!\n", n)
	} else {
		// Running migration in the Google Cloud SQL instance -- use proxy
		cleanup, err := mysql.RegisterDriver("cloudsql-mysql", cloudsqlconn.WithCredentialsFile("../../keys/sa.db.json"))
		if err != nil {
			log.Fatalf("Error occured while registering driver for GC SQL: %s", err)
		}
		// call cleanup when you're done with the database connection
		defer cleanup()

		db, err := sql.Open(
			"cloudsql-mysql",
			cloudDbConnString,
		)
		if err != nil {
			log.Fatalf("Error occured while connecting to Cloud SQL Instance: %s", err)
		}

		n, err := migrate.Exec(db, "mysql", migrations, migrate.Up)
		if err != nil {
			log.Fatalf("Error occured while running UP migrations: %s", err)
		}

		fmt.Printf("Applied %d migrations to Cloud SQL database!\n", n)
	}

}
