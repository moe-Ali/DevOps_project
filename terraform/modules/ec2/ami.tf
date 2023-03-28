data "aws_ami" "ec2_ami"{
    most_recent = true
    owners=var.ec2_ami["owners"]
    filter {
        name ="name"
        values=var.ec2_ami["name_values"]
    }
}