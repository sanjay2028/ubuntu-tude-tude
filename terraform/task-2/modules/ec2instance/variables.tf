variable instance_type {
    type = string
    default = "t3.micro"
}

variable key_name { type = string }
variable subnet_id { type = string }
variable enbale_public_id { 
    type = bool
    default = true
}

variable tags { type = map }
variable user_data { type = string }
variable root_block_device  { 
    type = object({
        volume_size = number
        volume_type = string
        delete_on_termination = bool
        encrypted = bool
    }) 

    default = {
        volume_size = 8
        volume_type = "gp3"
        delete_on_termination = true
        encrypted = true
    }
}

variable security_group_ids {
    type = list(string)
    default = []
}