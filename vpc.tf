
resource "aws_vpc" "tgw-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "tgw-vpc"
  }
}


resource "aws_subnet" "pub-1a" {
  vpc_id     = aws_vpc.tgw-vpc.id
  cidr_block = var.cidr_block_a
  availability_zone = "us-east-1a"
  tags = {
    Name = "tgw-pub-2a"
  }
}

resource "aws_subnet" "pub-1b" {
  vpc_id     = aws_vpc.tgw-vpc.id
  availability_zone = "us-east-1b"
  cidr_block = var.cidr_block_b
  tags = {
    Name = "tgw-pub-2b"
  }
}


resource "aws_subnet" "prv-1a" {
  vpc_id     = aws_vpc.tgw-vpc.id
  availability_zone = "us-east-1a"
  cidr_block = var.cidr_block_c
  tags = {
    Name = "tgw-prv-2a"
  }
}


resource "aws_subnet" "prv-1b" {
  vpc_id     = aws_vpc.tgw-vpc.id
  availability_zone = "us-east-1b"
  cidr_block = var.cidr_block_d
  tags = {
    Name = "tgw-prv-2b"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tgw-vpc.id

  tags = {
    Name = "tgw-igw"
  }
}

resource "aws_eip" "pub1" {
  vpc   = true

}

resource "aws_nat_gateway" "gw1" {
  allocation_id = aws_eip.pub1.id
  subnet_id     = aws_subnet.pub-1a.id

  tags = {
    Name = "tgw NAT"
  }
}

resource "aws_instance" "access_server" {
  ami           = "ami-0f38562b9d4de0dfe"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pub-1a.id
  associate_public_ip_address = true
  source_dest_check = false
  key_name = var.keyp
  vpc_security_group_ids  = [aws_security_group.tgw-pub-sg.id]

  tags = {
    Name = "bastion"
  }

}

resource "aws_route_table" "vpc_public_rt" {
  vpc_id = aws_vpc.tgw-vpc.id

  route {
    cidr_block =  var.exit_rte_cidr

    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "vpc_public_rt"
  }
}


resource "aws_route_table" "vpc_private_rt" {
  vpc_id = aws_vpc.tgw-vpc.id

  route {
    cidr_block =  var.exit_rte_cidr

    gateway_id = aws_nat_gateway.gw1.id
  }

  tags = {
    Name = "vpc_private_rt"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.pub-1a.id
  route_table_id = aws_route_table.vpc_public_rt.id
}
