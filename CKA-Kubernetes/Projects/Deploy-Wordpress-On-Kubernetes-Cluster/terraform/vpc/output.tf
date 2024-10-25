output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "public_rt_id" {
  value = aws_route_table.public-rt.id
}
output "private-rt" {
  value = aws_route_table.private-rt.id
}

output "public-subnet" {
  value = aws_subnet.public_subnet.*.id
}
output "private-subnet" {
  value = aws_subnet.private_subnet.*.id
}
