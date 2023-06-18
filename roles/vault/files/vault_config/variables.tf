variable "postgresql_host" {
  type      = string
  sensitive = true
  default   = "localhost"
}

variable "postgresql_port" {
  type      = number
  sensitive = true
  default   = 5432
}

variable "postgresql_username" {
  type      = string
  sensitive = true
  default   = "postgres"
}

variable "postgresql_password" {
  type      = string
  sensitive = true
  default   = "password"
}

variable "app_name" {
  type = string
}
