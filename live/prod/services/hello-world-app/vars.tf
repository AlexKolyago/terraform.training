variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
}

variable "server_text" {
  description = "The text the web server should return"
  default     = "Hello, World!"
  type        = string
}

variable "enviroment" {
  description = "The name of the enviroment we're deploying to"
  default     = "prod"
  type        = string
}