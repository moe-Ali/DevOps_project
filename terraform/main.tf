module "network" {
        source= "./modules/network"
        project_tag= var.project_tag

        vpc_cidr = var.vpc_id
        network_subnets= {
          "public1" = {
              cidr = var.public1_subnet["cidr"]
              az = var.public1_subnet["az"]
              route_table = "public_route"
              map_ip = true
          }
          "public2" = {
              cidr = var.public2_subnet["cidr"]
              az = var.public2_subnet["az"]
              route_table = "public_route"
              map_ip = true
          }
        }

        network_route_table ={
          "public_route" ={
              cidr = "0.0.0.0/0"
              gateway_id = module.network.igw_main_id
          }
        }
  }

module "jenkins_server" {
        source = "./modules/ec2"
        project_tag = var.project_tag
        vpc_id = module.network.vpc_main_id

        #EC2
        ec2_name = "jenkins_server"
        ec2_ami = {
          name_values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
          owners = ["amazon"]
        }
        ec2_instance_type = "t2.medium"
        ebs_volume = 8
        ec2_instance_keypair = var.keypair
        associate_public_ip_address = true
        ec2_subnet_id = module.network.subnet_id["public1"] 

        #Security Group
        sg_name = "jenkins_server_securitygroup"
        sg_rules = {
          "port 22" = { type ="ingress",port ="22",protocol ="tcp",cidr_blocks =["154.181.24.109/32"]}
          "port 8080" = { type ="ingress",port ="8080",protocol ="tcp",cidr_blocks =[var.allow_ip]}
          "port 5000" = { type ="ingress",port ="5000",protocol ="tcp",cidr_blocks =[var.vpc_id]}
          "port 9292" = { type ="ingress",port ="9292",protocol ="tcp",cidr_blocks =["0.0.0.0/0"]}
          "egress all" = { type ="egress",port ="0",protocol ="-1",cidr_blocks =["0.0.0.0/0"]}
        }
}
module "nexus_server" {
        source = "./modules/ec2"
        project_tag = var.project_tag
        vpc_id = module.network.vpc_main_id

        #EC2
        ec2_name = "nexus_server"
        ec2_ami = {
          name_values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
          owners = ["amazon"]
        }
        ec2_instance_type = "t2.medium"
        ebs_volume = 14
        ec2_instance_keypair = var.keypair
        associate_public_ip_address = true
        ec2_subnet_id = module.network.subnet_id["public1"] 

        #Security Group
        sg_name = "nexus_server_securitygroup"
        sg_rules = {
          "port 22" = { type ="ingress",port ="22",protocol ="tcp",cidr_blocks =["154.181.24.109/32"]}
          "port 80" = { type ="ingress",port ="80",protocol ="tcp",cidr_blocks =["0.0.0.0/0"]}
          "port 443" = { type ="ingress",port ="443",protocol ="tcp",cidr_blocks =["0.0.0.0/0"]}
          "port 8081" = { type ="ingress",port ="8081",protocol ="tcp",cidr_blocks =[var.allow_ip]}
          "port 5000" = { type ="ingress",port ="5000",protocol ="tcp",cidr_blocks =["0.0.0.0/0"]}
          "egress all" = { type ="egress",port ="0",protocol ="-1",cidr_blocks =["0.0.0.0/0"]}
        }
}
module "sonarqube_server" {
        source = "./modules/ec2"
        project_tag = var.project_tag
        vpc_id = module.network.vpc_main_id

        #EC2
        ec2_name = "sonarqube_server"
        ec2_ami = {
          name_values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
          owners = ["amazon"]
        }
        ec2_instance_type = "t2.medium"
        ebs_volume = 8
        ec2_instance_keypair = var.keypair
        associate_public_ip_address = true
        ec2_subnet_id = module.network.subnet_id["public1"] 

        #Security Group
        sg_name = "sonarqube_server_securitygroup"
        sg_rules = {
          "port 22" = { type ="ingress",port ="22",protocol ="tcp",cidr_blocks =["154.181.24.109/32"]}
          "port 9000" = { type ="ingress",port ="9000",protocol ="tcp",cidr_blocks =[var.allow_ip]}
          "egress all" = { type ="egress",port ="0",protocol ="-1",cidr_blocks =["0.0.0.0/0"]}
        }
}

module "eks_cluster" {
  source = "./modules/eks"
  project = var.project_tag
  subnet_id_list = [ module.network.subnet_id["public1"], module.network.subnet_id["public2"] ]
  keypair = var.keypair
  instance_types_list = var.eks_worker_instance_types_list
  scaling_config = {
    desired_size = var.scaling_config["desired_size"]
    max_size = var.scaling_config["max_size"]
    min_size = var.scaling_config["min_size"]
  }
}
