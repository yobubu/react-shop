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

  depends_on = [aws_docdb_cluster.documentdb]
}

resource "aws_ssm_parameter" "ecr_endpoint" {
  name      = "/${var.project}/ECR_REGISTRY"
  type      = "SecureString"
  value     = split("/", aws_ecr_repository.ecr.repository_url)[0]
  overwrite = true

  tags = {
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }

  depends_on = [aws_ecr_repository.ecr]
}

resource "aws_ssm_parameter" "project_name" {
  name      = "/${var.project}/PROJECT_NAME"
  type      = "SecureString"
  value     = var.project
  overwrite = true

  tags = {
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}

resource "aws_ssm_parameter" "gray_gelf_address" {
  name      = "/${var.project}/GRAY_GELF_ADDRESS"
  type      = "SecureString"
  value     = data.terraform_remote_state.network_remote_state.outputs.aws_tools_public_ip
  overwrite = true

  tags = {
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}

