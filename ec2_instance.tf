resource "aws_instance" "server_1"{
  ami = "ami-030ff268bd7b4e8b5"
  instance_type = "t2.micro"
  tags = {
	Name = "IBM-DA-KUL"
  }
}