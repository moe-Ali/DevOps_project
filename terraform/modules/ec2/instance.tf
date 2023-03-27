resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ec2_ami.id
  instance_type = var.ec2_instance_type
  key_name = var.ec2_instance_keypair
  associate_public_ip_address = var.associate_public_ip_address

  subnet_id     = var.ec2_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    "Name" = var.ec2_name
    "project" = var.project_tag
  }
  provisioner "local-exec"{
    command = "echo ${self.tags_all["Name"]} ansible_host=${self.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=../keypair/${var.ec2_instance_keypair}.pem >> ../ansible/inventory"
  }
}