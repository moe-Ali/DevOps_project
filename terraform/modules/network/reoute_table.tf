resource "aws_route_table" "rt" {
  for_each = var.network_route_table
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = each.value["cidr"]
    gateway_id = each.value["gateway_id"]
  }

  tags = {
    Name = each.key
    Project = var.project_tag
  }
}