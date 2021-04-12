resource "aws_docdb_cluster" "documentdb" {
  cluster_identifier      = "${var.project}-documentdb-cluster"
  engine                  = "docdb"
  master_username         = var.docdb_master_user
  master_password         = var.docdb_master_pass
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_docdb_subnet_group.docdb_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.documentdb.id]

#   tags = {
#     Name        = "${var.project}_documentdb-cluster"
#     Project     = var.project
#     Environment = var.stage
#     Terraform   = true
#   }
}

resource "aws_docdb_cluster_instance" "docdb_cluster_instances" {
  count              = 1
  identifier         = "${var.project}-docdb-cluster-${count.index}"
  cluster_identifier = aws_docdb_cluster.documentdb.id
  instance_class     = "db.t3.medium"
}

resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = "${var.project}-docdb-subnet-group"
  subnet_ids = data.terraform_remote_state.network_remote_state.outputs.aws_vpc_private_subnets

#   tags = {
#     Name        = "${var.project}_documentdb-subnet-group"
#     Project     = var.project
#     Environment = var.stage
#     Terraform   = true
#   }
}