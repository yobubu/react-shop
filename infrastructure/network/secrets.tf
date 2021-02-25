resource "aws_ssm_parameter" "secrets" {
  count     = length(keys(var.secrets))
  name      = "/${var.project}/${element(keys(var.secrets), count.index)}"
  type      = "SecureString"
  value     = element(values(var.secrets), count.index)
  overwrite = true

  tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = true
  }
}