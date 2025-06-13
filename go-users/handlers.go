package main

import (
	"context"
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
)

func CreateUserHandler(w http.ResponseWriter, r *http.Request) {
	var user User
	_ = json.NewDecoder(r.Body).Decode(&user)

	err := DB.QueryRow(context.Background(),
		"INSERT INTO users (name, age) VALUES ($1, $2) RETURNING id",
		user.Name, user.Age,
	).Scan(&user.ID)
	if err != nil {
		http.Error(w, "Failed to insert user", 500)
		return
	}

	json.NewEncoder(w).Encode(user)
}

func GetAllUsersHandler(w http.ResponseWriter, r *http.Request) {
	rows, err := DB.Query(context.Background(), "SELECT id, name, age FROM users")
	if err != nil {
		http.Error(w, "Query error", 500)
		return
	}
	defer rows.Close()

	var users []User
	for rows.Next() {
		var u User
		_ = rows.Scan(&u.ID, &u.Name, &u.Age)
		users = append(users, u)
	}

	json.NewEncoder(w).Encode(users)
}

func GetUserByIDHandler(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, _ := strconv.Atoi(idStr)

	var u User
	err := DB.QueryRow(context.Background(),
		"SELECT id, name, age FROM users WHERE id=$1", id,
	).Scan(&u.ID, &u.Name, &u.Age)

	if err != nil {
		http.Error(w, "User not found", 404)
		return
	}

	json.NewEncoder(w).Encode(u)
}

func UpdateUserHandler(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, _ := strconv.Atoi(idStr)

	var user User
	_ = json.NewDecoder(r.Body).Decode(&user)

	_, err := DB.Exec(context.Background(),
		"UPDATE users SET name=$1, age=$2 WHERE id=$3",
		user.Name, user.Age, id,
	)

	if err != nil {
		http.Error(w, "Update error", 500)
		return
	}
	user.ID = id
	json.NewEncoder(w).Encode(user)
}

func DeleteUserHandler(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, _ := strconv.Atoi(idStr)

	_, err := DB.Exec(context.Background(), "DELETE FROM users WHERE id=$1", id)
	if err != nil {
		http.Error(w, "Delete error", 500)
		return
	}
	w.WriteHeader(http.StatusNoContent)
}
