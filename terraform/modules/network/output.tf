output "vpc_main_id" {
    value = aws_vpc.main.id
}
output "subnet_id" {
    value = {for subnet in aws_subnet.subnets : subnet.tags_all["Name"] => subnet.id}
}
output "igw_main_id" {
    value = aws_internet_gateway.main.id
}
# output "nat_main_id" {
#     value = aws_nat_gateway.main.id
# }
