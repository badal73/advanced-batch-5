provider "aws"{
    region = "us-east-1"
}
variable "tagname" {
    default = "IBM-DA-KUL-DEMO"
}
data "aws_vpc" "kul-vpc" {
    filter {
      name = "tag:Name"
      values = [var.tagname]
    }
}