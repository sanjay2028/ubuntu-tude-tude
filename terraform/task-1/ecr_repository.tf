variable ecr_frontend {
  type        = string
  description = "ECR repository name for frontend"
}

variable ecr_backend {
  type        = string
  description = "ECR repository name for backend"
}

module "ecr_repository" {
    source = "./modules/ecr_repository"
    for_each = local.ecr_reposiories
    name = each.value.name
    tags = merge(local.tags, { Name = "${each.value.name}"})
}