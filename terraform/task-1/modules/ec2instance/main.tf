data "aws_ami" "ubuntu" {
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
} 


resource "aws_instance" "ec2_server" {
    ami             =   data.aws_ami.ubuntu.id   
    instance_type   =   var.instance_type
    key_name        =   var.key_name
    subnet_id       =   var.subnet_id    
    user_data       =   var.user_data
    tags            =   var.tags          
    vpc_security_group_ids = var.security_group_ids
    associate_public_ip_address = true

    root_block_device {
        volume_size             = var.root_block_device.volume_size 
        volume_type             = var.root_block_device.volume_type
        encrypted               = var.root_block_device.encrypted
        delete_on_termination   = var.root_block_device.delete_on_termination
    } 
}