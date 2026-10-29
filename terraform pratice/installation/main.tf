resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "my-vpc"
    }
  
}
resource "aws_subnet" "subnet1"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "my-subnet1"
    }
}
resource "aws_subnet" "subnet2"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "my-subnet2"
    }
}
resource "aws_security_group" "sg" {
    name = "my-security-group"
    description = "Allow SSH and HTTP"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {#this is used to allow all outbound traffic from the security group. if we don't allow all outbound traffic, the instance will not be able to access the internet. this is because the instance will not be able to send any traffic to the internet. so we need to allow all outbound traffic in order for the instance to access the internet.
        from_port = 0
        to_port = 0
        protocol = "-1"# this is used to allow all protocols. if we don't allow all protocols, the instance will not be able to access the internet. this is because the instance will not be able to send any traffic to the internet. so we need to allow all protocols in order for the instance to access the internet.
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "my-route-table"
    }
    route{
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
         # this is used to route all traffic to the internet
    }
}
resource "aws_route_table_association" "subnet1_association" {# why need to create route table association for each subnet? because each subnet needs to be associated with a route table in order to have internet access. if we don't associate the route table with the subnet, the subnet will not have internet access.
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.route_table.id
}
resource "aws_route_table_association" "subnet2_association" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.route_table.id
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "my-igw"
    }
}
resource "aws_db_subnet_group" "db_subnet_group" {# why we need to create a db subnet group? because the db instance needs to be associated with a db subnet group in order to have internet access. if we don't associate the db instance with the db subnet group, the db instance will not have internet access.
    name = "my-db-subnet-group"
    subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    tags = {
        Name = "my-db-subnet-group"
    }
}
resource "aws_db_instance" "my_db_instance" {
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    username = "mydatabase"
    password = "mypassword"
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name # db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name this used to associate the db instance with the db subnet group .name used to get the name of the db subnet group attribute name
    vpc_security_group_ids = [aws_security_group.sg.id] # vpc_security_group_ids = [aws_security_group.sg.id] this used to associate the db instance with the security group .id used to get the id of the security group attribute id
    publicly_accessible = true
    skip_final_snapshot = true
}
