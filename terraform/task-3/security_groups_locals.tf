locals {
    cidr_all            = ["0.0.0.0/0"]
    protocol_tcp        = "tcp"
    ssh_rule            =  {
        type            = "ingress"
        description     = "Rule for SSH Access"
        protocol        = local.protocol_tcp
        from_port       = 22
        to_port         = 22
        cidr_blocks     = local.cidr_all
    } 
    egress_all_rule     =   {
        type            = "egress"
        description     = "All all outgoing traffic"
        protocol        = "-1"
        from_port       = 0
        to_port         = 0 
        cidr_blocks     = local.cidr_all
    }
    bkend_lp_rule       = {
        type            = "ingress"
        description     = "Frontend Listening for 9000"
        protocol        = local.protocol_tcp
        from_port       = 5000
        to_port         = 5000
        cidr_blocks     = local.cidr_all
    }
    ftend_lp_rule       = {
        type            = "ingress"
        description     = "Backend listening port 5000"
        protocol        = local.protocol_tcp
        from_port       = 9000
        to_port         = 9000
        cidr_blocks     = local.cidr_all
    } 
    security_groups = {
        alb_sg = {
            name                =   "ALB Security Group"
            description         =   "Security Group for Application Load Balancer"
            rules               =   {
                listening_port  =   local.ftend_lp_rule            
            }
        },
        task_sg = {
            name                =   "ECS Task SG"
            description         =   "Security Group for ECS Task"
            rules               =   {
                listening_port  =   local.ftend_lp_rule
                outbound_all    =   local.egress_all_rule            
            }
        }
    }
}