resource "aws_ebs_volume" "volume_1"{
	availability_zone = "us-east-1a"
	size = 10
	tags = {
		Name = "IBM-DA-KUL"
	}
}