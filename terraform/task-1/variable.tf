variable app_name {
    type = string
    default = "myapp"
}

variable env_name {
    type = string
    default = "test"
}

variable web_ingress {
    type = map(object({
        description = string
        cidr_blocks = list(string)
        from_port = number
        to_port = number
        protocol = string
    }))
    default = {
        "ssh" = {
            description     = "SSH Access"
            to_port         = 22
            from_port       = 22
            protocol        = "tcp"
            cidr_blocks     = ["0.0.0.0/0"]
        }
        "backend" = {
            description     = "Backend access"
            to_port         = 5000
            from_port       = 5000
            protocol        = "tcp"
            cidr_blocks     = ["0.0.0.0/0"]
        }
        "frontend" = {
            description     = "Backend access"
            to_port         = 9000
            from_port       = 9000
            protocol        = "tcp"
            cidr_blocks     = ["0.0.0.0/0"]
        }
        "http" = {
            description     = "Backend access"
            to_port         = 80
            from_port       = 80
            protocol        = "tcp"
            cidr_blocks     = ["0.0.0.0/0"]
        }
        "https" = {
            description     = "Backend access"
            to_port         = 443
            from_port       = 443
            protocol        = "tcp"
            cidr_blocks     = ["0.0.0.0/0"]
        }
    }
}

variable web_egress {
    type = map(object({
        description = string
        cidr_blocks = list(string)
        from_port = number
        to_port = number
        protocol = number
    }))
    default = {
        "all" = {
            description = "All all outbound traffice"
            to_port = 0
            from_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}