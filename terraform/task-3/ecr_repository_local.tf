locals {
    ecr_reposiories = {
        repo1 = {
            name = "${var.ecr_frontend}"
        }

        repo2 = {
            name = "${var.ecr_backend}"
        }
    } 
}