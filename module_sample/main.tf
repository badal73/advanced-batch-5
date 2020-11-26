provider "aws"{
    region = "us-east-1"
}

variable "tagname" {
    default = "somevalue"
}

module "create_ec2"{
    source = "./modules/ec2"
    tagname = var.tagname
}

output "server_ip" {
    value = module.create_ec2.server_1_public_ip
}