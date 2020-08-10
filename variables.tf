variable "tgw_name" {

}

variable "exit_rte_cidr" {
  description = "destination cidr block for transit gateway route table"
  type        = string
}

variable "vpc_cidr_block" {
  description = "cidr block for VPC"
   type        = string
}

variable "pub_subnet_cidrs" {
  description = "cidr block for Public subnets"
    type = list
}

variable "prv_subnet_cidrs" {
  description = "cidr block for Private subnets"
  type        = list
}

variable "cidr_block_a" {
  description = "cidr block for Public subnet 2a"
  type        = string
}


variable "cidr_block_b" {
  description = "cidr block for Public subnet 2b"
   type        = string
}

variable "prv2_subnet_cidrs" {
  description = "private subnet cidrs"
   type        = list(string)
}

variable "vpc2_cidr_block" {
  description = "cidr block for VPC"
    type        = string
}

variable "pub_subnets" {
  description = "Public subnets"
   type = list(string)
}

variable "prv_subnets" {
  description = "Private subnets"
  type        = list(string)
}

variable "cidr_block_c" {
  description = "cidr block for Private subnet 2b"
   type        = string
}


variable "icmp_protocol" {
  description = "security group protocol"
  type = string
}

variable "from_icmp_port" {
  description = "security group from port"
  type = string
}


variable "to_icmp_port" {
  description = "security group to port"
   type = string
}


variable "azs" {
  description = "Availability Zones "
  type        = list
}


variable "cidr_block_d" {
  description = "cidr block for Private subnet 2b"
  type        = string
}


variable "my_ip" {
  description = "whitelist my ip for bastion access"
    type        = string
}

variable "from_port" {
  description = "security group from port"
  type        = string
}


variable "to_port" {
  description = "security group to port"
  type        = string
}



variable "protocol" {
  description = "security group protocol"
  type        = string
}
variable "egress_cidr" {
  type    = list(string)

}


variable "keyp" {
  description = "keypair filename"
  type        = string

}
