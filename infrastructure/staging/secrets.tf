resource "aws_ssm_parameter" "secrets" {
  count     = length(keys(var.secrets))
  name      = "/${var.project}/${element(keys(var.secrets), count.index)}"
  type      = "SecureString"
  value     = element(values(var.secrets), count.index)
  overwrite = true

  tags = {
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}

resource "aws_ssm_parameter" "docdb_endpoint" {
  name      = "/${var.project}/MONGO_CONN_STRING"
  type      = "SecureString"
  value     = "${aws_docdb_cluster.documentdb.endpoint}:27017/?ssl=true&replicaSet=rs0&readPreference=secondaryPreferred"
  overwrite = true

  tags = {
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }

  depends_on = [ aws_docdb_cluster.documentdb ]
}