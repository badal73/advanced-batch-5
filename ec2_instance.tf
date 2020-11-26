resource "aws_instance" "server_1"{
  availability_zone = var.aws_az
  ami = "ami-030ff268bd7b4e8b5"
  instance_type = var.ec2_type
  tags = {
	Name = var.tagname
  }
  security_groups = [
	aws_security_group.sg_1.name
  ]
  count = var.ec2_count
  key_name = "kul-aws-sync"
}