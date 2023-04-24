region = "us-east-1"

project_tag = "DevOps_project"

vpc_id = "10.0.0.0/16"

allow_ip = "0.0.0.0/0"

#public1_subnet is used for jenkins_server, nexus_server, sonarqube_server and k8s nodes
public1_subnet = {
  az = "us-east-1a"
  cidr = "10.0.0.0/24"
}

#public2_subnet is used for k8s nodes
public2_subnet = {
  az = "us-east-1b"
  cidr = "10.0.1.0/24"
}

eks_worker_instance_types_list = ["t2.medium"]

scaling_config = {
  desired_size = 2
  max_size = 3
  min_size = 2
}

#ec2 keypair would be downloaded localy in the keypair folder
keypair = "devops_project"