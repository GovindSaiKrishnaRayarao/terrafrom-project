resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr1
  tags = {
    name = "my-vpc"
  }
  
}
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = var.subnet_cidr1
    tags = {
      name = "my-subnet"
    }
}

    