variable "project_tag" {
    type = string
}

#VPC
variable "vpc_cidr" {
    type= string
}

#Subnets
variable "public_subnet" {
  type=object({
        cidr = string
        az = string
  })
}

#route table
variable "rt_public_cidr" {
    type= string
}