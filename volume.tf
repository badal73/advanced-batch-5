resource "aws_ebs_volume" "volume_1"{
	availability_zone = "us-east-1a"
	size = 10
	tags = {
		Name = "IBM-DA-KUL"
	}
}

resource "aws_volume_attachment" "volume_1_attachment_server_1"{
	volume_id = aws_ebs_volume.volume_1.id
	instance_id = aws_instance.server_1.id
	device_name = "/dev/sdb"
	skip_destroy = "true"

	provisioner "remote-exec" {
		connection {
			type = "ssh"
			user = "root"
			password = "thinknyx@123"
			host = aws_instance.server_1.public_ip
		}
		inline = [
			"yum install -y git",
			"mkdir /data",
			"mkfs -t ext4 /dev/xvdb",
			"mount /dev/xvdb /data",
			"git clone https://github.com/kul-unisys/sample-java-app.git /data/demo"
		]
	}
	
}