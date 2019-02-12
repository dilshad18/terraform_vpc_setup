resource "random_string" "password" {
  count                      = "${length(var.rds_name)}"
  length                     = 16
  special                    = false
  override_special           = "/@\" "
}

resource "aws_db_instance" "default" {
  identifier                 = "${element(var.rds_name, count.index)}"
  count                      = "${length(var.rds_name)}"
  allocated_storage          = 50
  storage_type               = "gp2"
  engine                     = "postgres"
  engine_version             = "9.5"
  instance_class             = "db.m4.large"
  name                       = "${element(var.db_name, count.index)}"
  username                   = "${element(var.user_name, count.index)}"
  parameter_group_name       = "default.postgres9.5"
  multi_az                   = "True"
  publicly_accessible        = "False"
  auto_minor_version_upgrade = "True"
  vpc_security_group_ids     = ["sg-020"]
  db_subnet_group_name       = "pre-qa-db"
  password                   = "${element(random_string.password.*.result,count.index)}"
  apply_immediately          = "True"
  deletion_protection        = "True"
  storage_encrypted          = "True"
  backup_retention_period    = 7
}


output "rds_endpoint" {
      value                  = "${aws_db_instance.default.*.endpoint}"
}
output "password" {
      value                  = "${random_string.password.*.result}"
}
