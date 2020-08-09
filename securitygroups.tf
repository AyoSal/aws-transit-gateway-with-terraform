resource "aws_security_group" "tgw-pub-sg" {
  name        = "ayos-tgw-pub-sg"
  description = "Allow access to bastion in public"
  vpc_id      = aws_vpc.tgw-vpc.id

  ingress {
    description = "SSH Access"
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = [var.cidr_block_a, var.my_ip]
  }


  ingress {
    description = "SSH Access"
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = [var.cidr_block_a]
  }


  ingress {
    description = "icmp Access"
    from_port   = var.from_icmp_port
    to_port     = var.to_icmp_port
    protocol    = var.icmp_protocol
    cidr_blocks = [var.vpc2_cidr_block]
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


resource  "aws_security_group" "tgw-prv-sg" {
  name        = "ayos-tgw-prv-sg"
  description = "Allow access to bastion in public"
  vpc_id      = aws_vpc.tgw-vpc2.id

  ingress {
    description = "SSH Access"
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = [var.cidr_block_a, var.my_ip]
  }


  ingress {
    description = "SSH Access"
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = [var.cidr_block_a]
  }

  ingress {
    description = "SSH Access"
    from_port   = var.from_icmp_port
    to_port     = var.to_icmp_port
    protocol    = var.icmp_protocol
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr

  }

  tags = {
    Name = "allow_access_to_prv"
  }
}