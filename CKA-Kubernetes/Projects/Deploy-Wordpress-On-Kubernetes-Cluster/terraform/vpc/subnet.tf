resource "aws_subnet" "public_subnet" {
  count                   = length(var.public-subnet-zone)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public-cidr, count.index)
  availability_zone       = element(var.public-subnet-zone, count.index)
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.vpc_name}-public-subent-${substr(element(var.public-subnet-zone, count.index), -2, 2)}" }
}

resource "aws_route_table_association" "pub_sub_associate" {
  count          = length(var.public-subnet-zone)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public-rt.id
}



resource "aws_subnet" "private_subnet" {
  count                   = length(var.private-subnet-zone)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private-cidr, count.index)
  availability_zone       = element(var.private-subnet-zone, count.index)
  map_public_ip_on_launch = false
  tags                    = { Name = "${var.vpc_name}-private-subent-${substr(element(var.private-subnet-zone, count.index), -2, 2)}" }
}

resource "aws_route_table_association" "private_subnet_associate" {
  count          = length(var.private-subnet-zone)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private-rt.id
}