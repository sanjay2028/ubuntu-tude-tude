variable name { type = string }
variable image_tag_mutability { 
    type = string 
    description = "The tag mutability setting. MUTABLE | IMMUTABLE | IMMUTABLE_WITH_EXCLUSION | MUTABLE_WITH_EXCLUSION"
    default = "MUTABLE"

    validation {
        condition     = contains(["MUTABLE", "IMMUTABLE", "IMMUTABLE_WITH_EXCLUSION", "MUTABLE_WITH_EXCLUSION"], var.image_tag_mutability)
        error_message = "Invalid Value. Must of one of : MUTABLE | IMMUTABLE | IMMUTABLE_WITH_EXCLUSION | MUTABLE_WITH_EXCLUSION."
    }
}
variable scan_on_push {
    type = bool
    default = true
}

variable tags {
    type = map
    default = {}
}
