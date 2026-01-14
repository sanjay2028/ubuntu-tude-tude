variable aws_key_pair_name { type = string }
variable user_data { type = string }


module "ec2instance" {
    source = "./modules/ec2instance"
    key_name = var.aws_key_pair_name
    subnet_id = aws_subnet.public["a"].id
    tags = merge(local.tags, { Name = "${local.app_name}-web-svr-common"})
    user_data = var.user_data
    security_group_ids = [aws_security_group.web_sg.id]
}