variable security_group {
    type = object({
        name        =   string
        description =   string
        vpc_id      =   string
    })
}

variable rules {
    type = map(object({
        type            =   string
        description     =   string
        from_port       =   number
        to_port         =   number
        cidr_blocks     =   list(string)
        protocol        =   string
    }))   
}