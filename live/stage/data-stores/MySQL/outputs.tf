output "address" {
  #value       = aws_db_instance.example.address
  value       = module.mysql.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  #value       = aws_db_instance.example.port
  value       = module.mysql.port
  description = "The port the database is listening on"
}