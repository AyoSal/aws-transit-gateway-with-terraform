
#TGW Resource specific variables

variable "tgw_name" {
  description = "Name of the transit gateway"
  default = "transit-gw"
}

variable "tgw_id" {
  description = "id of the transit gateway"
  default = "tgw_id"
}

variable "amazon_side_as" {
  description = "Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs"
  default = "64512"
}

variable "auto_accept_shared_attachments" {

  description = "Whether resource attachment requests are automatically accepted"
  default = "enable"
  type = string
}

variable "default_route_table_association" {
  description = "Whether resource attachments are automatically associated with the default association route table"
  default = "disable"
  type = string
}

variable "default_route_table_propagation" {
  description = "Whether resource attachments automatically propagate routes to the default propagation route table"
  default =  "disable"
  type = string
}

variable "description" {
  description = "Description of the EC2 Transit Gateway"
  default = "desc"
  type = string
}

variable "dns_support" {
  description = "Whether DNS support is enabled for Transit gateway"
  default = "enable"
   type = string
}

variable "vpn_ecmp_support" {
  description = "Whether VPN Equal Cost Multipath Protocol support is enabled"
  default = "enable"
  type = string
}

variable "ipv6_support" {
  description = "Whether IPv6 support is enabled"
  default = "disable"
  type = string
}

variable "transit_gateway_default_route_table_association" {
 description = "whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table"
 default = false
}

variable "transit_gateway_default_route_table_propagation" {
description = "whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table"
default = false
}

variable "transit_gateway_attachment_id" {
  description = "Identifier of EC2 Transit Gateway Attachment"
  default = "tgw_attachment_id"
  type = string

}

  variable "transit_gateway_route_table_id" {
    description = "Identifier of EC2 Transit Gateway Route Table"
    default = "tgw_routetable_id"
    type = string
  }

#TGW Route Resource Variables

variable "exit_rte_cidr" {
  description = "destination cidr block for transit gateway route table"
  default = "0.0.0.0/0"
  type = string
}

variable "destination_cidr_block" {
  description = "IPv4 CIDR range used for destination matches. Routing decisions are based on the most specific match"
  default = " "
}

variable "blackhole" {
  description = "Indicates whether to drop traffic that matches this route"
  default = false
}

#VPC Resource Variables

variable "vpc_cidr_block" {
  description = "cidr block for VPC"
  default = "15.0.0.0/16"
  type = string
}


variable "vpc2_cidr_block" {
  description = "cidr block for VPC"
  default = "10.0.0.0/16"
  type = string
}


variable "cidr_block_a" {
  description = "cidr block for Public subnet 1a"
  default = "15.0.0.0/24"
  type = string
}


variable "cidr_block_b" {
  description = "cidr block for Public subnet 1b"
  default = "15.0.1.0/24"
  type = string
}


variable "cidr_block_a2" {
  description = "cidr block for Public subnet 1a"
  default = "10.0.0.0/24"
  type = string
}


variable "cidr_block_b2" {
  description = "cidr block for Public subnet 1b"
  default = "10.0.1.0/24"
  type = string
}

variable "cidr_block_c" {
  description = "cidr block for Private subnet 1b"
  default = "15.0.2.0/24"
  type = string
}


variable "cidr_block_d" {
  description = "cidr block for Private subnet 1b"
  default = "15.0.3.0/24"
  type = string
}

variable "azs" {
  description = "availability zones"
default = ["us-east-1a", "us-east-1b"]
type = list(string)
}

variable "pub_subnet_cidrs" {
  description = "public subnet cidrs"
  default = ["15.0.0.0/24", "15.0.1.0/24"]
  type = list(string)
}


variable "prv_subnet_cidrs" {
  description = "private subnet cidrs"
  default = ["15.0.2.0/24", "15.0.3.0/24"]
  type = list(string)
}


variable "prv2_subnet_cidrs" {
  description = "private subnet cidrs"
  default = ["10.0.0.0/24", "10.0.1.0/24"]
  type = list(string)
}

variable "pub_subnets" {
  description = "Public subnets"
  default = ["pub-1a", "pub-1b"]
  type = list(string)
}


variable "prv_subnets" {
  description = "Private subnets"
  default = ["prv-1a", "prv-1b"]
  type = list(string)
}

variable "my_ip" {
  description = "whitelist my ip for bastion access"
  default = "142.116.203.156/32"
  type = string
}

variable "from_port" {
  description = "security group from port"
  default = "22"
  type = string
}


variable "from_icmp_port" {
  description = "security group from port"
  default = "8"
  type = string
}


variable "to_icmp_port" {
  description = "security group to port"
  default = "0"
  type = string
}

variable "to_port" {
  description = "security group to port"
  default = "22"
  type = string
}


variable "icmp_protocol" {
  description = "security group protocol"
  default = "icmp"
  type = string
}
variable "protocol" {
  description = "security group protocol"
  default = "tcp"
  type = string
}
variable "egress_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}


variable "keyp" {
  description = "keypair filename"
  type    = string
  default = "Ayos-windows-key"
}

variable "az1" {
  description = "first availability zone"
  default = "us-east-1a"
 type = string
  }


variable "az2" {
  description = "second availability zone"
  default = "us-east-1b"
  type = string
}
