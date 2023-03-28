variable "project_tag" {
  type = string
}
variable "vpc_id" {
  type = string
}

#EC2
variable "ec2_name" {
  type = string
}
variable "ec2_instance_type" {
  type = string
}
variable "ec2_instance_keypair" {
  type = string
}
variable "associate_public_ip_address" {
  type = bool
}
variable "ec2_subnet_id" {
  type = string
}

#EC2 ami
variable "ec2_ami" {
  type = object({
    owners = list(string)
    name_values = list(string)
  })
}

#Security Group
variable "sg_name" {
  type = string
}

variable "sg_rules" {
  type = map(object({
    type = string
    port = number
    protocol = string
    cidr_blocks = list(string)
}))
}