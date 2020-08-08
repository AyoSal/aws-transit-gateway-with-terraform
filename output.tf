output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.tgw-vpc.id

}

  output "private_subnet1_id" {
    value = aws_subnet.prv-1a.*.id
  }

  output "private_subnet2_id" {
    value = aws_subnet.prv-1b.*.id
  }


output "public_subnet1_id" {
  value = aws_subnet.pub-1a.*.id
}

output "public_subnet2_id" {
  value = aws_subnet.pub-1b.*.id
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

output "tgw_routetable_id" {
  description = "Transit Gateway Route Table ID"
  value = aws_ec2_transit_gateway_route_table.tgw-rtable.id
}

output "tgw_routetable_association" {
  description = "transit gateway routetable association"
  value = aws_ec2_transit_gateway_route_table_association.tgw-rta.id
}

output "instance" {
  description = "ec2 instance id"
  value = aws_instance.access_server.id
}

output "instance_ip" {
  description = "ec2 instance ip"
  value = aws_instance.access_server.public_ip
}
