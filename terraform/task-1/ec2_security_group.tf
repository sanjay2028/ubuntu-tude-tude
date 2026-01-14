variable security_group { 
    type = object({
        name = string
        description = string
    })

    default = {
        name = "Ingress"
        description = "Ingress Security Group"
    } 
}


resource "aws_security_group" "web_sg" {
    name = var.security_group.name
    description = var.security_group.description
    vpc_id = aws_vpc.main.id
    tags = merge(local.tags, { Name = "${local.app_name}-Web1-Ingress-SGP"})
}

resource "aws_security_group_rule" "ingress" {
    for_each = var.web_ingress
    type                =   "ingress"
    description         =   each.value.description
    to_port             =   each.value.to_port
    from_port           =   each.value.from_port
    protocol            =   each.value.protocol
    cidr_blocks         =   each.value.cidr_blocks
    security_group_id   = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "egress" {
    for_each            = var.web_egress
    type                = "egress"
    description         =   each.value.description
    to_port             =   each.value.to_port
    from_port           =   each.value.from_port
    protocol            =   each.value.protocol
    cidr_blocks         =   each.value.cidr_blocks
    security_group_id   =   aws_security_group.web_sg.id
}