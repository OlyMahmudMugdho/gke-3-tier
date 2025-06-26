resource "google_sql_database_instance" "postgres_instance" {
  name             = "my-database-instance"
  region           = "us-central1"
  database_version = "POSTGRES_17"

  
  settings {
    tier      = "db-custom-4-16384"
    edition   = "ENTERPRISE"
    disk_size = 100
    disk_type = "PD_SSD"
    deletion_protection_enabled = false
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "public-internet"
        value = "0.0.0.0/0"
      }
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = "users_db"
  instance = google_sql_database_instance.postgres_instance.name
}

resource "google_sql_user" "users" {
  name     = "mugdho"
  instance = google_sql_database_instance.postgres_instance.name
  password = "admin"
}
