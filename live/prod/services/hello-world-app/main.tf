provider "aws" {
  region = "eu-central-1"
}

module "hello_world_app" {
  source = "../../../../modules/services/hello-world-app"

  server_text = var.server_text

  enviroment             = var.enviroment
  db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key    = var.db_remote_state_key

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
}