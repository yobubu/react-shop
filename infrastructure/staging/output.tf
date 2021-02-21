output "AWS_CodeDeploy_Application_Name" {
  value = [aws_codedeploy_app.backend_app.name]
}

output "AWS_CodeDeploy_Deployment_Group" {
  value = [aws_codedeploy_deployment_group.backend.deployment_group_name]
}

output "AWS_app_bucket_name" {
  value = aws_s3_bucket.custom_bucket.id
}
output "AWS_web_bucket_name" {
  value = aws_s3_bucket.website_bucket.id
}
output "ecr_url" {
  description = "Address of the ECR registry"
  value       = aws_ecr_repository.ecr.repository_url
}

output "docdb_endpoint" {
  value = aws_docdb_cluster.documentdb.endpoint
}