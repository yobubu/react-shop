# output "website-bucket-name" {
#   description = "name of my bucket"
#   value = aws_s3_bucket.frontendbuck-website.id
# }
# output "website-bucket-arn" {
#   description = "arn of my bucket"
#   value = aws_s3_bucket.frontendbuck-website.arn
# }
output "backend_registry_id" {
  description = "The account ID of the registry holding the repository."
  value = aws_ecr_repository.backend_repo.registry_id
}
output "backend_repository_url" {
  description = "The URL of the repository."
  value = aws_ecr_repository.backend_repo.repository_url
}
output "frontend_registry_id" {
  description = "The account ID of the registry holding the repository."
  value = aws_ecr_repository.frontend_repo.registry_id
}
output "frontend_repository_url" {
  description = "The URL of the repository."
  value = aws_ecr_repository.frontend_repo.repository_url
}
output "documentdb_endpoint" {
  description = "The DNS address of the DocDB instance"
  value = aws_docdb_cluster.docdb.endpoint
}