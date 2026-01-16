variable vpc_cidr {
    type = string
    default = "11.0.0.0/16"
}

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = merge(local.tags, { Name = "${local.app_name}-vpc"})    
}