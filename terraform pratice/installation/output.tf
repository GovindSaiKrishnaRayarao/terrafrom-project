output "vpc_id" {
  value = aws_vpc.vpc.id
}


output "subnet1_id" {
  value = aws_subnet.subnet1.id
}


output "subnet2_id" {
  value = aws_subnet.subnet2.id
}


output "security_group_id" {
  value = aws_security_group.sg.id
}


output "route_table_id" {
  value = aws_route_table.route_table.id
}


output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}


output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}


output "rds_endpoint" {
  value = aws_db_instance.my_db_instance.endpoint
}


output "rds_id" {
  value = aws_db_instance.my_db_instance.id
}