
resource "aws_vpc" "tgw-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "tgw-vpc"
  }
}
resource "aws_subnet" "public_subnets" {
  count = length(var.pub_subnets)
  vpc_id = aws_vpc.tgw-vpc.id
  cidr_block = var.pub_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = var.pub_subnets[count.index]
  }
}


resource "aws_subnet" "private_subnets" {
  count = length(var.prv_subnets)
  vpc_id = aws_vpc.tgw-vpc.id
  cidr_block = var.prv_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = var.prv_subnets[count.index]
  }
}

//resource "aws_subnet" "prv-1a" {
//  vpc_id            = aws_vpc.tgw-vpc.id
//  availability_zone = var.az1
//  cidr_block        = var.cidr_block_c
 // tags = {
 //   Name = "tgw-prv-1a"
 // }
//}


//resource "aws_subnet" "prv-1b" {
//  vpc_id            = aws_vpc.tgw-vpc.id
 // availability_zone = var.az2
 // cidr_block        = var.cidr_block_d
 // tags = {
  //  Name = "tgw-prv-1b"
 // }
//}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tgw-vpc.id

  tags = {
    Name = "tgw-igw"
  }
}

resource "aws_eip" "pub1" {
  vpc = true

}

resource "aws_nat_gateway" "gw1" {
  allocation_id = aws_eip.pub1.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name = "tgw NAT"
  }
}

resource "aws_instance" "access_server" {
  ami                         = "ami-09d8b5222f2b93bf0"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true
  source_dest_check           = false
  key_name                    = var.keyp
  vpc_security_group_ids      = [aws_security_group.tgw-pub-sg.id]

  tags = {
    Name = "bastion"
  }

}

resource "aws_route_table" "vpc_public_rt" {
  vpc_id = aws_vpc.tgw-vpc.id

  route {
    cidr_block = var.exit_rte_cidr
    gateway_id = aws_internet_gateway.gw.id
  }
  route {
    cidr_block = var.vpc2_cidr_block
    gateway_id = aws_ec2_transit_gateway.tgw.id
  }
 depends_on = [aws_ec2_transit_gateway.tgw]
  tags = {
    Name = "vpc_public_rt"
  }
}


resource "aws_route_table" "vpc_private_rt" {
  vpc_id = aws_vpc.tgw-vpc.id

  route {
    cidr_block = var.exit_rte_cidr
    gateway_id = aws_nat_gateway.gw1.id
  }

  tags = {
    Name = "vpc_private_rt"
  }
}

resource "aws_route_table_association" "rta" {
   subnet_id   = aws_subnet.public_subnets[0].id
  route_table_id = aws_route_table.vpc_public_rt.id
}


resource "aws_route_table_association" "rta_prv" {
  subnet_id   = aws_subnet.private_subnets[0].id
  route_table_id = aws_route_table.vpc_private_rt.id
}

