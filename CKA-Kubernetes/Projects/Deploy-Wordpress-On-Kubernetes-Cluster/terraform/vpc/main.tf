resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "${var.vpc_name}-igw" }
}

# ------- NAT Gateway fot private instance 
resource "aws_eip" "eip" {
  tags = { Name = "${var.vpc_name}-nat-gateway-ip" }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.vpc_name}-public-rt" }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "${var.vpc_name}-private-rt" }
}

resource "aws_route" "r" {
  route_table_id         = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
  depends_on             = [aws_nat_gateway.nat-gw, aws_route_table.private-rt]
}


