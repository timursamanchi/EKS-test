provider "aws" {
  region = "eu-west-1"
}
resource "aws_vpc" "jenkins-vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name" = "jenkins"
  }
}
resource "aws_internet_gateway" "jenkins-igw" {
  vpc_id = aws_vpc.jenkins-vpc.id
}