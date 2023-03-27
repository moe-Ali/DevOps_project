resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.rt_public_cidr
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = var.project_tag
    Project = var.project_tag
  }
}