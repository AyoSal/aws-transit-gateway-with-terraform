resource "aws_security_group" "tgw-pub-sg" {
  name        = "ayos-tgw-pub-sg"
  description = "Allow access to bastion in public"
  vpc_id      = aws_vpc.tgw-vpc.id

  ingress {
    description = "RDP Access"
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = [var.cidr_block_a, var.my_ip]
  }


  ingress {
    description = "RDP Access"
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = [var.cidr_block_a]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr

  }

  tags = {
    Name = "allow_bastion"
  }
}