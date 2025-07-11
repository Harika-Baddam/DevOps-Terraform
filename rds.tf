resource "aws_db_instance" "medusa_db" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13"
  instance_class       = "db.t3.micro"
  name                 = "medusadb"
  username             = "admin"
  password             = var.db_password
  publicly_accessible  = true
  skip_final_snapshot  = true
}
