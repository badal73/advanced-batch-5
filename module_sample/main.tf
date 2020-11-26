provider "aws"{
    region = "us-east-1"
}

module "create_ec2"{
    source = "./modules/ec2"
}

output "server_ip" {
    value = module.create_ec2.server_1_public_ip
}