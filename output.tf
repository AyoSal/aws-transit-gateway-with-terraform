output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.tgw-vpc.id

}

output "vpc_id2" {
  description = "The ID of the VPC"
  value = aws_vpc.tgw-vpc2.id

}

output "private_subnets" {
  value = aws_subnet.private_subnets[*]
}


output "private_subnets2" {
  value = aws_subnet.vpc2-private_subnets[*]
}

output "public_subnets" {
  value = aws_subnet.public_subnets[*]

}
  output "tgw_id" {
    description = "The ID of the VPC"
    value = aws_ec2_transit_gateway.tgw.id
  }

output "tgw_arn" {
  description = "The arn of the TGW"
  value = aws_ec2_transit_gateway.tgw.arn

    }

output "tgw_attachment" {
  description = "VPC attachments to TGW"
  value = aws_ec2_transit_gateway_vpc_attachment.tgw-att.id
}

output "tgw_attachment2" {
  description = "VPC attachments to TGW"
  value = aws_ec2_transit_gateway_vpc_attachment.tgw-att2.id
}
output "tgw_routetable_id" {
  description = "Transit Gateway Route Table ID"
  value = aws_ec2_transit_gateway_route_table.tgw-rtable.id
}

output "tgw_routetable_association" {
  description = "transit gateway routetable association"
  value = aws_ec2_transit_gateway_route_table_association.tgw-rta.id
}

output "tgw_routetable_association2" {
  description = "transit gateway routetable association"
  value = aws_ec2_transit_gateway_route_table_association.tgw-rta2.id
}

output "instance" {
  description = "ec2 instance id"
  value = aws_instance.access_server.id
}

output "instance_ip" {
  description = "ec2 instance ip"
  value = aws_instance.access_server.public_ip
}

output "instance2_prv_ip" {
  description = "ec2 instance ip"
  value = aws_instance.priv-access_server.private_ip
}

//output "aws_ram_resource_share" {
//  description = "arn of resource share"
 // value = aws_ram_resource_share.TGW_share.arn
//}