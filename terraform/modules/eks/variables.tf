variable "project" {
  type = string
}

variable "subnet_id_list" {
  type = list(string)
}


#worker nodes
variable "instance_types_list" {
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