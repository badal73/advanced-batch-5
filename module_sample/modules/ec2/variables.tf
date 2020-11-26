variable "availability_zone"{
    default = "us-east-1a"
}
variable "ami" {
    default = "ami-04bf6dcdc9ab498ca"
}
variable "instance_type"{
    default = "t2.micro"
}
variable "tagname" {
    default = "ec2_module"
}
variable "ec2_count"{
    default = "1"
}
variable "key_name"{
    default = "kul-aws-sync"
}