
resource "aws_vpc" "tgw-vpc2" {
  cidr_block       = var.vpc2_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "tgw2-vpc"
  }
}


resource "aws_subnet" "vpc2-private_subnets" {
  count             = length(var.prv_subnets)
  vpc_id            = aws_vpc.tgw-vpc2.id
  cidr_block        = var.prv2_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = var.prv_subnets[count.index]
  }
}


resource "aws_instance" "priv-access_server" {
  ami                         = "ami-09d8b5222f2b93bf0"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.vpc2-private_subnets[0].id
  associate_public_ip_address = false
  source_dest_check           = false
  key_name                    = var.keyp
  vpc_security_group_ids      = [aws_security_group.tgw-prv-sg.id]

  tags = {
    Name = "bastion"
  }

}

resource "aws_route_table" "vpc2_private_rt" {
  vpc_id = aws_vpc.tgw-vpc2.id
  depends_on = [aws_ec2_transit_gateway.tgw]
  route {
    cidr_block = var.exit_rte_cidr
    gateway_id = aws_ec2_transit_gateway.tgw.id

  }
  tags = {
    Name = "vpc2_private_rt"
  }
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.vpc2-private_subnets[0].id
  route_table_id = aws_route_table.vpc2_private_rt.id
}

