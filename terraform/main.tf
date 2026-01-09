terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider aws {
    shared_config_files = [var.aws_shared_config_file]
    shared_credentials_files = [var.aws_shared_credentials_file]
    profile = var.aws_profile
    region  = var.aws_region
}

resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    tags = merge(var.tags, { Name = "${var.app_name}-vpc"})
}

resource "aws_subnet" "public" {
    for_each = var.public_subnets
    vpc_id = aws_vpc.main.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.az
    tags = merge(var.tags, { Name = "public-subnet-${each.key}"})
}

resource "aws_subnet" "private" {
    for_each = var.private_subnets
    vpc_id = aws_vpc.main.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.az
    tags = merge(var.tags, { Name = "private-subnet-${each.key}"})
}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
}

resource "aws_instance" "common" {
    ami = data.aws_ami.ubuntu.id
    subnet_id = aws_subnet.public["1"].id
    key_name = var.aws_key_pair_name
    instance_type = "t2.micro"
    associate_public_ip_address = true

    ebs_block_device {
        device_name = "/dev/sdb"
        volume_type = "gp3"
        volume_size = 20
        encrypted = true
        delete_on_termination = true
    }

    user_data = var.aws_user_script_common
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, {Name = "${var.app_name}-igw"})
}

resource "aws_route_table" "pub_rt"{ 
    vpc_id = aws_vpc.main.id
    tags = merge(var.tags, { Name = "${var.app_name}-pub-rt"})  
}

resource "aws_route_table_association" "pub_assoc" {
    for_each = aws_subnet.public
    route_table_id = aws_route_table.pub_rt.id
    subnet_id = each.value.id
}

resource "aws_route" "public_default" {
    route_table_id          = aws_route_table.pub_rt.id
    gateway_id              = aws_internet_gateway.igw.id
    destination_cidr_block  = "0.0.0.0/0"
}

resource "aws_security_group" "app_sg" {
    vpc_id  =   aws_vpc.main.id
    name    =   "app-sg"
    tags    =   merge(var.tags, { Name = "${var.app_name}-app-sg" })      
}

resource "aws_security_group_rule" "ingress" {
    for_each            = var.web_ingress_rules
    type                = "ingress"
    security_group_id   = aws_security_group.app_sg.id
    description         = each.value.description
    from_port           = each.value.from_port  
    to_port             = each.value.to_port
    protocol            = each.value.protocol
    cidr_blocks         = each.value.cidr_blocks
}

resource "aws_security_group_rule" "egress" {
    for_each            = var.web_egress_rules
    type                = "egress"
    security_group_id   = aws_security_group.app_sg.id
    description         = each.value.description
    from_port           = each.value.from_port
    to_port             = each.value.to_port
    protocol            = each.value.protocol
    cidr_blocks         = each.value.cidr_blocks
}

