variable public_subnets { type = map }
variable private_subnets { type = map }


resource "aws_subnet" "public" {
    for_each = var.public_subnets
    vpc_id = aws_vpc.main.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.az
    tags = merge(local.tags, { Name = "${local.app_name}-public-${each.key}"})
    depends_on = [aws_vpc.main]
}

resource "aws_subnet" "private" {
    for_each = var.private_subnets
    vpc_id = aws_vpc.main.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.az
    tags = merge(local.tags, { Name = "${local.app_name}-private-${each.key}"})
    depends_on = [aws_vpc.main]
}
