package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/jackc/pgx/v5"
	"github.com/joho/godotenv"
)

var DB *pgx.Conn

func InitDB() {
	_ = godotenv.Load() // optional, only for local dev

	ctx := context.Background()
	dsn := fmt.Sprintf("postgres://%s:%s@%s:%s/%s",
		os.Getenv("DB_USER"),
		os.Getenv("DB_PASSWORD"),
		os.Getenv("DB_HOST"),
		os.Getenv("DB_PORT"),
		os.Getenv("DB_NAME"),
	)

	conn, err := pgx.Connect(ctx, dsn)
	if err != nil {
		log.Fatalf("DB connection error: %v", err)
	}
	DB = conn

	_, err = DB.Exec(ctx, `
		CREATE TABLE IF NOT EXISTS users (
			id SERIAL PRIMARY KEY,
			name TEXT NOT NULL,
			age INT NOT NULL
		)
	`)
	if err != nil {
		log.Fatalf("Table creation error: %v", err)
	}
}

