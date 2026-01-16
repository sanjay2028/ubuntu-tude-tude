module "security_groups" {
    source          = "./modules/security_groups"    
    for_each        =   local.security_groups
    security_group  =   {
        name        =   each.value.name
        description =   each.value.description
        vpc_id      =   aws_vpc.main.id
    }
    rules = each.value.rules
}