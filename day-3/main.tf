provider "aws" {
  region = "us-east-1"
}

variable "aws_details" {
	type = map
	default = {
		tagname = "IBM-DA-KUL"
		mastercount = 1
		nodecount = 1
		aws_az = "us-east-1d"
		mastertype = "t2.medium"
		nodetype = "t2.small"
	}
}

resource "aws_instance" "centos_server_master"{
    ami = "ami-030ff268bd7b4e8b5"
    instance_type = var.aws_details["mastertype"]
	count = var.aws_details["mastercount"]
    availability_zone = var.aws_details["aws_az"]
	
    tags = {
        Name = var.aws_details["tagname"]
    }

    provisioner "remote-exec" {
        connection{
            type = "ssh"
            user = "root"
            password = "thinknyx@123"
            host = self.public_ip
        }

        inline = [
            "hostnamectl set-hostname k8s-master",
            "yum install -y epel-release",
            "yum install -y ansible git",
            "mkdir /root/ansible",
            "echo [master] > /root/ansible/hosts",
			"echo ${self.public_ip} >> /root/ansible/hosts",
			"echo [node] >> /root/ansible/hosts"
        ]
    }
}

resource "aws_instance" "centos_server_node"{
    ami = "ami-030ff268bd7b4e8b5"
    instance_type = var.aws_details["nodetype"]
    count = var.aws_details["nodecount"]
    availability_zone = var.aws_details["aws_az"]
	
    tags = {
        Name = var.aws_details["tagname"]
    }

    provisioner "remote-exec" {
        connection{
            type = "ssh"
            user = "root"
            password = "thinknyx@123"
            host = self.public_ip
        }

        inline = [
            "hostnamectl set-hostname k8s-worker"
        ]
    }

    provisioner "remote-exec" {
        connection{
            type = "ssh"
            user = "root"
            password = "thinknyx@123"
            host = aws_instance.centos_server_master[0].public_ip
        }
        inline = [
			"echo ${self.public_ip} >> /root/ansible/hosts"
        ]
    }
}

output "master_public_ips" {
	value = aws_instance.centos_server_master.*.public_ip
}

output "nodes_public_ips" {
	value = aws_instance.centos_server_node.*.public_ip
}

resource "null_resource" "setup_k8s_cluster" {
  depends_on = [ aws_instance.centos_server_node ]
  provisioner "remote-exec" {
        connection{
            type = "ssh"
            user = "root"
            password = "thinknyx@123"
            host = aws_instance.centos_server_master[0].public_ip
        }
        inline = [
            "git clone https://github.com/kul-ibm/advanced-batch-5",
			"cd advanced-batch-5/day-3 && ansible-playbook kubernetes_cluster.yaml --extra-vars 'ansible_user=root ansible_password=thinknyx@123' && sleep 20 && kubectl get nodes"
        ]
    }
    triggers = {
      "always_run" = timestamp()
    }
}

resource "null_resource" "create_kubernetes_objects" {
  depends_on = [ null_resource.setup_k8s_cluster ]
  provisioner "remote-exec" {
        connection{
            type = "ssh"
            user = "root"
            password = "thinknyx@123"
            host = aws_instance.centos_server_master[0].public_ip
        }
        inline = [
            "yum install -y wget unzip",
            "wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip && unzip terraform_0.13.5_linux_amd64.zip && cp terraform /usr/bin/",
			"cd advanced-batch-5/manage_kubernetes_with_terraform && terraform init && terraform apply -auto-approve"
        ]
    }
    triggers = {
      "always_run" = timestamp()
    }
}