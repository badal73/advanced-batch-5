output "server_1_public_ip" {
	value = "Public IP is ${aws_instance.server_1.public_ip} and DNS is ${aws_instance.server_1.public_dns}" 
}

output "server_1_root_device" {
	value = aws_instance.server_1.root_block_device.*.device_name
}