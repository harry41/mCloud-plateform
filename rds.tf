resource "aws_db_instance" "db_instance" {
  identifier                = "${lower(var.project)}-${var.rds_env_name}-db"
  name                      = "${var.project}db"
  storage_type              = "${var.RDS_STORAGE_TYPE}"
  allocated_storage         = "${var.RDS_DB_ALLOCATED_STORAGE}"
  engine                    = "${var.ENGINE_DBTYPE}"
  engine_version            = "${var.ENGINE_VERSION}"
  instance_class            = "${var.DB_INSTANCE_TYPE}"
  license_model             = "general-public-license"
  apply_immediately         = true
  maintenance_window        = "sun:22:50-sun:23:30"
  username                  = "${var.rds_username}"
  password                  = "${var.rds_password}"
  final_snapshot_identifier = "${lower(var.project)}-${var.rds_env_name}-final-snapshot"
  skip_final_snapshot       = false
  copy_tags_to_snapshot     = true
  backup_retention_period   = "8"
  backup_window             = "23:40-00:10"
  publicly_accessible       = false
  port                      = "3306"
  multi_az                  = false
  db_subnet_group_name      = "${aws_db_subnet_group.default.name}"
  availability_zone         = "${var.aws_region}a"

  # storage_encrypted         = true

  vpc_security_group_ids = [
    "${aws_security_group.default.id}",
    "${aws_security_group.rds_sg.id}",
  ]
  tags = {
    Name        = "${var.project}_${var.rds_env_name}_rds_${count.index}"
    Environment = "${var.project}"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "maingroup"
  subnet_ids = ["${aws_subnet.public.id}", "${aws_subnet.private.id}"]

  tags = {
    Name = "My DB subnet group"
  }
}
