data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]

}


resource "aws_security_group" "openvpn_server" {
  name        = "openvpn_server"
  description = "Security group for OpenVPN server"
  vpc_id      = var.vpc_id

  tags = {
    Name = "openvpn"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.openvpn_server.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_openvpn_port" {
  security_group_id = aws_security_group.openvpn_server.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 1194
  ip_protocol       = "udp"
  to_port           = 1194
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.openvpn_server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.openvpn_server.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "openvpn_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = var.public_subnet_id

  associate_public_ip_address = false

  vpc_security_group_ids = [aws_security_group.openvpn_server.id]

  key_name = "ec2-devops"

  tags = {
    Name = "openvpn"
  }
}


resource "aws_eip" "openvpn_server" {
  domain = "vpc"

  tags = {
    Name = "openvpn"
  }
}

resource "aws_eip_association" "openvpn_server" {
  instance_id   = aws_instance.openvpn_server.id
  allocation_id = aws_eip.openvpn_server.id
}
