provider "aws" {
  region = "eu-west-1"
}

# Main VPC
resource "aws_vpc" "jenkins-vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "jenkins"
  }
}

# VPC internet gateway
resource "aws_internet_gateway" "jenkins-igw" {
  vpc_id = aws_vpc.jenkins-vpc.id
  tags = {
    Name = "jenkins-igw"
  }
}

# VPC route table
resource "aws_route_table" "jenkins-route-table" {
  vpc_id = aws_vpc.jenkins-vpc.id

  tags = {
    Name = "jenkins-route-table"
  }
}

# Public subnet
resource "aws_subnet" "jenkins-PUB-1" {
  vpc_id            = aws_vpc.jenkins-vpc.id
  cidr_block        = "10.0.101.0/24"
  availability_zone = "eu-west-1a"

  map_public_ip_on_launch = true

  tags = {
    Name : "Jenkins-PUB-1"
  }
}

# route table association with PUB subnet
resource "aws_route_table_association" "namePUB-1-route-table-associationa" {
  subnet_id = aws_subnet.jenkins-PUB-1.id
  route_table_id = aws_route_table.jenkins-route-table.id
}


