resource "aws_instance" "server_1"{
  availability_zone = var.availability_zone
  ami = var.ami
  instance_type = var.instance_type
  tags = {
	Name = var.tagname
  }
  count = var.ec2_count
  key_name = var.key_name
}