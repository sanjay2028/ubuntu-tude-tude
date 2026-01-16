resource "aws_security_group" "main_sg_group" {
    name                =   var.security_group.name
    description         =   var.security_group.description
    vpc_id              =   var.security_group.vpc_id
    tags                =   {Name = "${var.security_group.name}"}
}

resource "aws_security_group_rule" "main_sg_group_rule" {
    for_each            =   var.rules
    
    type                =   each.value.type
    description         =   each.value.description
    from_port           =   each.value.from_port
    to_port             =   each.value.to_port
    cidr_blocks         =   each.value.cidr_blocks
    protocol            =   each.value.protocol
    security_group_id   =   aws_security_group.main_sg_group.id
}