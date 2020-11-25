resource "aws_instance" "server_1"{
  availability_zone = "us-east-1a"
  ami = "ami-030ff268bd7b4e8b5"
  instance_type = "t2.micro"
  tags = {
	Name = "IBM-DA-KUL"
  }
  security_groups = [
	aws_security_group.sg_1.name
  ]
}