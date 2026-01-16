variable aws_config {
    type = object ({
        profile = string 
        region = string
    })
    default = {
        profile = "default"
        region = "us-east-1"
    }
}

terraform {
    required_providers {
        aws  = {
            source = "hashicorp/aws"
        }
    }
}

provider aws {
    profile = var.aws_config.profile
    region = var.aws_config.region
}