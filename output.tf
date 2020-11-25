output "server_1_public_ip" {
	value = "Public IP is ${aws_instance.server_1.public_ip} and DNS is ${aws_instance.server_1.public_dns}" 
}