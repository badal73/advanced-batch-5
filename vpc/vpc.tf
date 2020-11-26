provider "aws"{
    region = "us-east-1"
}

variable "tagname" {
    default = "IBM-DA-KUL-DEMO"
}
resource "aws_vpc" "kul-vpc" {
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = "true"
	enable_dns_hostnames = "true"
	tags = {
		Name = var.tagname
	}
}

resource "aws_subnet" "public_sn"{
	vpc_id = aws_vpc.kul-vpc.id
	cidr_block = "10.0.1.0/24"
	map_public_ip_on_launch = "true"
	tags = {
		Name = "Public"
	}
}

resource "aws_subnet" "private_sn"{
	vpc_id = aws_vpc.kul-vpc.id
	cidr_block = "10.0.2.0/24"
	map_public_ip_on_launch = "false"
	tags = {
		Name = "Private"
	}
}

resource "aws_internet_gateway" "kul-gateway"{
	vpc_id = aws_vpc.kul-vpc.id
	tags = {
		Name = var.tagname
	}
}

resource "aws_route_table" "kul-rt"{
	vpc_id = aws_vpc.kul-vpc.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.kul-gateway.id
	}
	tags = {
		Name = var.tagname
	}
}

resource "aws_route_table_association" "attach_public_subnet" {
	subnet_id = aws_subnet.public_sn.id
	route_table_id = aws_route_table.kul-rt.id
}