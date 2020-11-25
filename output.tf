output "server_1_public_ip" {
	value = aws_instance.server_1.*.public_ip
}
output "server_1_public_dns" {
	value = aws_instance.server_1.*.public_dns
}

#output "server_1_root_device" {
	#value = aws_instance.server_1.*.root_block_device.*.device_name
#}

output "volume_1_ID"{
	value = aws_ebs_volume.volume_1.*.id
}