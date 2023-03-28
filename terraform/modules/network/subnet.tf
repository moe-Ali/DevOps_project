resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet["cidr"]
  availability_zone = var.public_subnet["az"]
  
  tags = {
    Name = var.project_tag
    Project = var.project_tag
  }
}
resource "aws_route_table_association" "publicSubnet-publicRt" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}