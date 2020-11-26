provider "aws"{
    region = "us-east-1"
}
variable "tagname" {
    default = "IBM-DA-KUL-DEMO"
}
data "aws_vpc" "kul-vpc" {
    filter {
      name = "tag:Name"
      values = [var.tagname]
    }
}
data "aws_subnet" "public" {
  vpc_id = data.aws_vpc.kul-vpc.id

  tags = {
    Name = "Public"
  }
}
resource "aws_instance" "server_1"{
  ami = "ami-04bf6dcdc9ab498ca"
  instance_type = "t2.micro"
  tags = {
	Name = var.tagname
  }
  subnet_id = data.aws_subnet.public.id
  key_name = "kul-aws-sync"
}