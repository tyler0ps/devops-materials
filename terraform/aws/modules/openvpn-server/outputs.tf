output "ec2_public_ip" {
  value = aws_eip.openvpn_server.public_ip
}