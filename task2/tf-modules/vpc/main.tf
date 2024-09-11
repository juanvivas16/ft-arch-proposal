# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    name = var.vpc_name
    env  = var.env
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = "${var.vpc_name}-igw"
    env  = var.env
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet["0"].id
  tags = {
    name = "${var.vpc_name}-nat-gw"
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
    name = "${var.vpc_name}-public-${each.key}"
    env  = var.env
  }
}

#Private subnet
resource "aws_subnet" "private_subnet" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    name = "${var.vpc_name}-private-${each.key}"
    env  = var.env
  }
}
