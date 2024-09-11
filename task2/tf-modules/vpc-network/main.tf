# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
    env  = var.env
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
    env  = var.env
  }
}

# Network ACL
# resource "aws_network_acl" "public_nacl" {
#   vpc_id = aws_vpc.vpc.id

#   egress {
#     rule_no    = var.public_nacl_egress["rule_no"]
#     protocol   = var.public_nacl_egress["protocol"]
#     action     = var.public_nacl_egress["action"]
#     cidr_block = var.public_nacl_egress["cidr_block"]
#     from_port  = var.public_nacl_egress["from_port"]
#     to_port    = var.public_nacl_egress["to_port"]
#   }

#   ingress {
#     rule_no    = var.public_nacl_ingress["rule_no"]
#     protocol   = var.public_nacl_ingress["protocol"]
#     action     = var.public_nacl_ingress["action"]
#     cidr_block = var.public_nacl_ingress["cidr_block"]
#     from_port  = var.public_nacl_ingress["from_port"]
#     to_port    = var.public_nacl_ingress["to_port"]
#   }

#   tags = {
#     Name = "${var.vpc_name}-public-nacl"
#     env  = var.env
#   }
# }

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet["0"].id
  tags = {
    Name = "${var.vpc_name}-nat-gw"
    env  = var.env
  }
}

#Public subnet
resource "aws_subnet" "public_subnet" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-${each.key}"
    env  = var.env
  }
}

# Route Table from Public subnet to Internet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.vpc_name}-route-table-public"
    env  = var.env
  } 
}

# Route Table Association to Public subnet
resource "aws_route_table_association" "public_subnet_association" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_route_table.id
}

#Private subnet
resource "aws_subnet" "private_subnet" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = "${var.vpc_name}-private-${each.key}"
    env  = var.env
  }
}

# Route Table from Private subnet to NAT Gateway(Internet)
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.vpc_name}-route-table-private"
    env  = var.env
  } 
}

# Route Table Association to private subnet
resource "aws_route_table_association" "private_subnet_association" {
  for_each       = aws_subnet.private_subnet
  subnet_id      = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.private_route_table.id
}
