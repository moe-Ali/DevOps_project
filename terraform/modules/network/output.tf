output "vpc_main_id" {
    value = aws_vpc.main.id
}
output "public_subnet_id" {
    value = aws_subnet.public.id
}
output "igw_main_id" {
    value = aws_internet_gateway.main.id
}
