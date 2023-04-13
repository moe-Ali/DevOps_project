variable "project_tag" {
    type = string
}

#VPC
variable "vpc_cidr" {
    type= string
}

#Subnets
#Subnet
variable network_subnets{
    type=map(object({
        cidr = string
        az = string
        map_ip = bool
        route_table = string
    }))
}

#route table
variable network_route_table{
    type=map(object({
        cidr = string
        gateway_id = string
    }))
}