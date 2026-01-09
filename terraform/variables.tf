variable "aws_region" {
    type = string
    default = "ap-south-1"
}
variable "aws_shared_config_file" {
    type = string
    default = "%USER%/.aws/config"
    description = "AWS shared config file path"
}

variable "aws_shared_credentials_file" {
    type = string
    default = "%USER%/.aws/credentials"
    description = "AWS shared credentials file path"
}

variable "aws_profile" {
    type = string
    default = "default"
    description = "Your AWS profile name"
}

variable "cidr_block" {
    type = string
    default = "10.0.0.0/24"
    description = "CIRD Block for VPC"
}

variable "app_name" {
    type = string
    default = "myapp"
    description = "Your project / app name"
}

variable "tags" {
    type = map
    default = { environment = "dev" }
}

variable "public_subnets" {
    type = map
}

variable "private_subnets" {
    type = map
}

variable "aws_key_pair_name" {
    type = string
}

variable "aws_user_script_common" {
    default = <<-EOF
    #!/bin/bash
    set -e
    export DEBIAN_FRONTEND=noninteractive
    exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1
    
    apt-get update -y
    apt-get upgrade -y
    apt-get install -y \
        git \
        curl \
        python3-pip \
        python3-venv \
    
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs

    node -v
    npm -v
    python3 --vesion

    EOF
}

variable "web_ingress_rules" {
    type = map(object({
        description = string
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
    }))
    default = {
        "http" = {
            description = "Allow HTTP"
            to_port     = 80
            from_port   = 80
            cidr_blocks = ["0.0.0.0/0"]
            protocol = "tpc"
        },
        "ssh" = {
            description = "Allow HTTP"
            to_port     = 22
            from_port   = 22
            cidr_blocks = ["0.0.0.0/0"]
            protocol = "tpc"
        },
        "backend" = {
            description = "Allow 5000 for backend"
            to_port     = 5000
            from_port   = 5000
            cidr_blocks = ["0.0.0.0/0"]
            protocol = "tpc"
        },
        "frontend" = {
            description = "Allow 9000 for frontend"
            to_port     = 9000
            from_port   = 9000
            cidr_blocks = ["0.0.0.0/0"]
            protocol = "tpc"
        }        
    }
}

variable "web_egress_rules" {
    type = map(object({
        description = string
        to_port     = number
        from_port   = number
        protocol    = string
        cidr_blocks = list(string)
    }))
    default = {
        "all_traffic" = {
            description =  "All all outbound"
            to_port     = 0
            from_port   = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}