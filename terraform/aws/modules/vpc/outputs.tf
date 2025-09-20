output "vpc_id" {
  value = aws_vpc.main.id
}

output "aws_subnet_private_zone1_id" {
  value = aws_subnet.private_zone1.id
}

output "aws_subnet_private_zone2_id" {
  value = aws_subnet.private_zone2.id
}

output "aws_subnet_public_zone1_id" {
  value = aws_subnet.public_zone1.id
}

output "aws_subnet_public_zone2_id" {
  value = aws_subnet.public_zone2.id
}
