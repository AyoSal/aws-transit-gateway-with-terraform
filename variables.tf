variable "tgw_name" {
    default = "transit-gw"
}

variable "exit_rte_cidr" {
    description = "destination cidr block for transit gateway route table"
    default = "0.0.0.0/0"
    type = string
}

variable "vpc_cidr_block" {
    description = "cidr block for VPC"
    default = "15.0.0.0/16"
    type = string
}

variable "cidr_block_a" {
    description = "cidr block for Public subnet 2a"
    default = "15.0.0.0/24"
    type = string
} 


variable "cidr_block_b" { 
    description = "cidr block for Public subnet 2b"
    default = "15.0.1.0/24"
    type = string
}


variable "cidr_block_c" {
    description = "cidr block for Private subnet 2b"
    default = "15.0.2.0/24"
    type = string
}


variable "cidr_block_d" {
    description = "cidr block for Private subnet 2b"
    default = "15.0.3.0/24"
    type = string
}


variable "my_ip" {
    description = "whitelist my ip for bastion access"
    default = "142.118.174.17/32"
    type = string
}


variable "cidr_block_or" {
    description = "cidr block for Oregon vpc Public subnet 2a"
    default = "10.0.0.0/16"
    type = string
}


variable "from_port" {
    description = "security group from port"
    default = "3389"
    type = string
}


variable "to_port" {
    description = "security group to port"
    default = "3389"
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
