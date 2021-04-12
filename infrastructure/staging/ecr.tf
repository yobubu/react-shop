resource "aws_ecr_repository" "backend_repo" {
  name                 = "${var.project}-${var.environment}-backend-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {}
}

resource "aws_ecr_repository" "frontend_repo" {
  name                 = "${var.project}-${var.environment}-frontend-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {}
}