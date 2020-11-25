resource "aws_security_group" "sg_1"{
	name = "IBM-DA-KUL"
	description = "Managed by Terraform for IBM DevOps Advanced Batch"
	egress {
	    from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress{
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
    tags = {
		Name = var.tagname
    }
}