package main

import migrate "github.com/rubenv/sql-migrate"

type DbMigrationTarget struct {
	ConnString string
	Fms        *migrate.FileMigrationSource
}

func StringInSlice(target string, slice []string) bool {
	for _, str := range slice {
		if str == target {
			return true
		}
	}
	return false
}
