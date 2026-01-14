variable aws_key_pair_name { type = string }
variable user_data { type = string }


module "ec2instance" {

    source = "./modules/ec2instance"

    for_each = local.ec2_instances
    
    key_name = var.aws_key_pair_name
    user_data = var.user_data

    subnet_id = each.value.subnet_id
    security_group_ids = [module.security_groups[each.key].id]

    tags = merge(local.tags, { Name = "${local.app_name}-${each.key}"})
}