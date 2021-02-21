resource "aws_docdb_cluster" "documentdb" {
  cluster_identifier      = "${var.project}-documentdb-cluster"
  engine                  = "docdb"
  master_username         = var.docdb_master_user
  master_password         = var.docdb_master_pass
  backup_retention_period = var.docdb_backup_retention
  preferred_backup_window = var.docdb_backup_window
  skip_final_snapshot     = var.docdb_skip_final_snapshot
  apply_immediately       = var.docdb_cluster_apply_immediately
  db_subnet_group_name    = aws_docdb_subnet_group.docdb_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.backend_instances_behind_alb.id]

  tags = {
    Name        = "${var.project}_documentdb-cluster"
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}

resource "aws_docdb_cluster_instance" "docdb_cluster_instances" {
  count              = var.docdb_dluster_instance_count
  identifier         = "${var.project}-docdb-cluster-${count.index}"
  cluster_identifier = aws_docdb_cluster.documentdb.id
  instance_class     = var.docdb_instance_class
  apply_immediately  = var.docdb_instance_apply_immediately
}

resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = "${var.project}-docdb-subnet-group"
  subnet_ids = flatten([data.terraform_remote_state.network_remote_state.outputs.aws_vpc_private_subnets.*])

  tags = {
    Name        = "${var.project}_documentdb-subnet-group"
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}