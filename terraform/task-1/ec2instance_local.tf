locals {
    ec2_instances = {
        common_server = {
            name = "common_server" 
            subnet_id = aws_subnet.public["a"].id
        }

        frontend_svr = {
            name = "frontend_svr"
            subnet_id = aws_subnet.public["b"].id
        }

        backend_svr = {
            name = "backend_svr"
            subnet_id = aws_subnet.public["b"].id
        }
    }
}