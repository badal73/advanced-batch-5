output "server_1_public_ip" {
	value = aws_instance.server_1.*.public_ip
}
output "server_1_public_dns" {
	value = aws_instance.server_1.*.public_dns
}
