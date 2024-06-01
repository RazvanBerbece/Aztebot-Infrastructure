package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"strings"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
	migrate "github.com/rubenv/sql-migrate"

	"cloud.google.com/go/cloudsqlconn"
	"cloud.google.com/go/cloudsqlconn/mysql/mysql"
)

func main() {

	// Load input arguments
	direction := os.Args[1]
	dbNames := os.Args[2]

	godotenv.Load()

	env := os.Getenv("ENVIRONMENT")

	// Local environment connection strings
	aztebotDbConnString := os.Getenv("AZTEBOT_ROOT_CONNSTRING")
	aztemarketDbConnString := os.Getenv("AZTEMARKET_ROOT_CONNSTRING")

	// Cloud environment connection strings
	aztebotCloudDbConnString := os.Getenv("AZTEBOT_ROOT_CLOUDSQL_CONNSTRING")
	aztemarketCloudDbConnString := os.Getenv("AZTEMARKET_ROOT_CLOUDSQL_CONNSTRING")

	migrationTargets := []DbMigrationTarget{
		{
			DevConnString:  aztebotDbConnString,
			ProdConnString: aztebotCloudDbConnString,
			Fms: &migrate.FileMigrationSource{
				Dir: "history/aztebot",
			},
		},
		{
			DevConnString:  aztemarketDbConnString,
			ProdConnString: aztemarketCloudDbConnString,
			Fms: &migrate.FileMigrationSource{
				Dir: "history/aztemarket",
			},
		},
	}

	if env == "stg" {

		// Running migrations locally (i.e containerised mysql instance)
		if direction == "UP" || len(os.Args) == 0 {
			for _, migrationTarget := range migrationTargets {
				srcDbName := migrationTarget.Fms.Dir[8:]
				if strings.Contains(dbNames, srcDbName) {

					db, err := sql.Open("mysql", migrationTarget.DevConnString)
					if err != nil {
						log.Fatalf("Error occured while connecting to database for migration: %s", err)
					}

					n, err := migrate.Exec(db, "mysql", migrationTarget.Fms, migrate.Up)
					if err != nil {
						log.Fatalf("Error occured while running UP migrationTargets: %s", err)
					}

					fmt.Printf("Applied %d migrations to local %s database!\n", n, srcDbName)
				}
			}
		} else if direction == "DOWN" {
			for _, migrationTarget := range migrationTargets {
				srcDbName := migrationTarget.Fms.Dir[8:]
				if strings.Contains(dbNames, srcDbName) {

					db, err := sql.Open("mysql", migrationTarget.DevConnString)
					if err != nil {
						log.Fatalf("Error occured while connecting to database for migration: %s", err)
					}

					n, err := migrate.ExecMax(db, "mysql", migrationTarget.Fms, migrate.Down, 1)
					if err != nil {
						log.Fatalf("Error occured while running DOWN migration: %s", err)
					}

					fmt.Printf("Rolled back %d migration(s) in local database %s.\n", n, srcDbName)
				}
			}
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

		if direction == "UP" || len(os.Args) == 0 {
			for _, migrationTarget := range migrationTargets {
				srcDbName := migrationTarget.Fms.Dir[8:]
				if strings.Contains(dbNames, srcDbName) {

					db, err := sql.Open(
						"cloudsql-mysql",
						migrationTarget.ProdConnString,
					)
					if err != nil {
						log.Fatalf("Error occured while connecting to Cloud SQL Instance: %s", err)
					}

					n, err := migrate.Exec(db, "mysql", migrationTarget.Fms, migrate.Up)
					if err != nil {
						log.Fatalf("Error occured while running UP migrationTargets: %s", err)
					}

					fmt.Printf("Applied %d migrations to Cloud SQL database %s!\n", n, srcDbName)
				}
			}
		} else if direction == "DOWN" {
			for _, migrationTarget := range migrationTargets {
				srcDbName := migrationTarget.Fms.Dir[8:]
				if strings.Contains(dbNames, srcDbName) {

					db, err := sql.Open(
						"cloudsql-mysql",
						migrationTarget.ProdConnString,
					)
					if err != nil {
						log.Fatalf("Error occured while connecting to Cloud SQL Instance: %s", err)
					}

					n, err := migrate.ExecMax(db, "mysql", migrationTarget.Fms, migrate.Down, 1)
					if err != nil {
						log.Fatalf("Error occured while running DOWN migration: %s", err)
					}

					fmt.Printf("Rolled back %d migration(s) in the Cloud SQL database %s.\n", n, srcDbName)
				}
			}
		} else {
			log.Fatalf("Migration direction %s not supported.", direction)
		}
	}

}
