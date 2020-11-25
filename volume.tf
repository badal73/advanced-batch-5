resource "aws_ebs_volume" "volume_1"{
	availability_zone = var.aws_az
	size = 10
	tags = {
		Name = var.tagname
	}
	count = var.ec2_count
}

resource "aws_volume_attachment" "volume_1_attachment_server_1"{
    count = var.ec2_count
	volume_id = aws_ebs_volume.volume_1[count.index].id
	instance_id = aws_instance.server_1[count.index].id
	device_name = "/dev/sdb"
	skip_destroy = "true"

	provisioner "remote-exec" {
		connection {
			type = "ssh"
			user = "root"
			password = "thinknyx@123"
			host = aws_instance.server_1[count.index].public_ip
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