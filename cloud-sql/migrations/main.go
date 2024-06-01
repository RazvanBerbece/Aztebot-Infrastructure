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

	// Load input arguments
	direction := os.Args[1]

	godotenv.Load()

	dbConnString := os.Getenv("DB_ROOT_CONNSTRING")
	cloudDbConnString := os.Getenv("DB_ROOT_CLOUDSQL_CONNSTRING")
	env := os.Getenv("ENVIRONMENT")

	migrations := &migrate.FileMigrationSource{
		Dir: "history",
	}

	if env == "stg" {

		// Running migrations locally (i.e containerised mysql instance)
		db, err := sql.Open("mysql", dbConnString)
		if err != nil {
			log.Fatalf("Error occured while connecting to database for migration: %s", err)
		}

		if direction == "UP" || len(os.Args) == 0 {
			n, err := migrate.Exec(db, "mysql", migrations, migrate.Up)
			if err != nil {
				log.Fatalf("Error occured while running UP migrations: %s", err)
			}

			fmt.Printf("Applied %d migrations to local database!\n", n)
		} else if direction == "DOWN" {
			n, err := migrate.ExecMax(db, "mysql", migrations, migrate.Down, 1)
			if err != nil {
				log.Fatalf("Error occured while running DOWN migration: %s", err)
			}

			fmt.Printf("Rolled back %d migration(s).\n", n)
		} else {
			log.Fatalf("Migration direction %s not supported.", direction)
		}
	} else {

		// Running migrations in the Google Cloud SQL instance through proxy
		cleanup, err := mysql.RegisterDriver("cloudsql-mysql", cloudsqlconn.WithCredentialsFile("../../keys/sa.db.json"))
		if err != nil {
			log.Fatalf("Error occured while registering driver for GC SQL: %s", err)
		}
		defer cleanup()

		db, err := sql.Open(
			"cloudsql-mysql",
			cloudDbConnString,
		)
		if err != nil {
			log.Fatalf("Error occured while connecting to Cloud SQL Instance: %s", err)
		}

		if direction == "UP" || len(os.Args) == 0 {
			n, err := migrate.Exec(db, "mysql", migrations, migrate.Up)
			if err != nil {
				log.Fatalf("Error occured while running UP migrations: %s", err)
			}

			fmt.Printf("Applied %d migrations to Cloud SQL database!\n", n)
		} else if direction == "DOWN" {
			n, err := migrate.ExecMax(db, "mysql", migrations, migrate.Down, 1)
			if err != nil {
				log.Fatalf("Error occured while running DOWN migration: %s", err)
			}

			fmt.Printf("Rolled back %d migration(s) on the Cloud SQL database.\n", n)
		} else {
			log.Fatalf("Migration direction %s not supported.", direction)
		}
	}

}
