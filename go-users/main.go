package main

import (
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
)

func main() {
	InitDB()
	defer DB.Close(nil)

	r := chi.NewRouter()

	r.Post("/users", CreateUserHandler)
	r.Get("/users", GetAllUsersHandler)
	r.Get("/users/{id}", GetUserByIDHandler)
	r.Put("/users/{id}", UpdateUserHandler)
	r.Delete("/users/{id}", DeleteUserHandler)

	r.Handle("/*", http.StripPrefix("/", http.FileServer(http.Dir("./frontend"))))


	log.Println("🚀 Server running on :8080")
	log.Fatal(http.ListenAndServe(":8080", r))
}
