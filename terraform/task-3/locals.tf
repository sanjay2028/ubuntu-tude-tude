locals {
    app_name = join("-", [var.app_name, var.env_name])
    tags = {
        app = var.app_name
        env = var.env_name
    }
}