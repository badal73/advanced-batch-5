provider "aws" {
    region = "us-east-1"
}

variable "tagname" {
  default = "IBM-DA-KUL-ANSIBLE"
}

resource "aws_instance" "server_1"{
  ami = "ami-030ff268bd7b4e8b5"
  instance_type = "t2.micro"
  tags = {
	Name = var.tagname
  }
  key_name = "kul-aws-sync"
  
  provisioner "remote-exec" {
		connection {
			type = "ssh"
			user = "root"
			password = "thinknyx@123"
			host = self.public_ip
		}
		inline = [
			"sudo yum install -y epel-release",
			"sudo yum install -y ansible git"
		]
	}
  
}

resource "aws_instance" "server_2"{
  ami = "ami-030ff268bd7b4e8b5"
  instance_type = "t2.micro"
  tags = {
	Name = var.tagname
  }
  key_name = "kul-aws-sync"
  
  provisioner "remote-exec" {
		connection {
			type = "ssh"
			user = "root"
			password = "thinknyx@123"
			host = aws_instance.server_1.public_ip
		}
		inline = [
			"echo ${self.private_ip} > /root/hosts"
		]
	}
	
}

output "server_1" {
  value = aws_instance.server_1.public_ip
}

output "server_2" {
  value = aws_instance.server_2.public_ip
}