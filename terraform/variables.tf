variable region{
    type = string
}

variable "project_tag" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public1_subnet" {
  type = object({
    cidr = string
    az = string
    
  })
}

variable "public2_subnet" {
  type = object({
    cidr = string
    az = string
  })
}

variable "eks_worker_instance_types_list" {
  type = list(string)
}

variable "scaling_config" {
  type = object({
    desired_size = number
    max_size = number
    min_size = number
  })
}

variable "keypair" {
  type = string
}

variable "allow_ip" {
  type = string
}