## Terraform-module-aws-transit-gateway

A terraform module to create setup to connect 2 VPCs with a transit-gateway.
It also creates 
 - transit gateway route-table
 - transit gateway routes for each vpc
 - transit gateway attachments for each vpc
 
attach the transit gateway to 2 vpc 

VPC 1 with 
- public and private subnets
- public and private route tables 
- ec2 bastion instance
- security group for the ec2 instance

VPC 2 with 
- private subnet
- private route table
- ec2 instance server
- security group for the ec2 instance

Please see diagram below on this
 
![picture](/images/tgw-setup.png)


## Code example

```
resource "aws_ec2_transit_gateway" "tgw" {
  default_route_table_association =  "disable"
  description                     = "tgw setup with terraform"
  default_route_table_propagation =  "disable"

  tags = {
    Name = "transit-gw"
  }
}

resource "aws_ec2_transit_gateway_route_table" "tgw-rtable" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att" {
  //depends_on                    = [aws_ec2_transit_gateway_route_table.tgw-rtable]
  subnet_ids                    = [aws_subnet.prv-1a.id, aws_subnet.prv-1b.id]
  transit_gateway_id             = aws_ec2_transit_gateway.tgw.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation  = false
  vpc_id                         = aws_vpc.tgw-vpc.id
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rta" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw-att.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-rtable.id
}

resource "aws_ec2_transit_gateway_route" "tgw-rte" {
  destination_cidr_block         = var.exit_rte_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw-att.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-rtable.id
}
```


## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| amazon\_side\_as | Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs | `string` | `"64512"` | no |
| auto\_accept\_shared\_attachments | Whether resource attachment requests are automatically accepted | `string` | `"enable"` | no |
| az1 | first availability zone | `string` | `"us-east-1a"` | no |
| az2 | second availability zone | `string` | `"us-east-1b"` | no |
| azs | availability zones | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b"<br>]</pre> | no |
| blackhole | Indicates whether to drop traffic that matches this route | `bool` | `false` | no |
| cidr\_block\_a | cidr block for Public subnet 1a | `string` | `"15.0.0.0/24"` | no |
| cidr\_block\_b | cidr block for Public subnet 1b | `string` | `"15.0.1.0/24"` | no |
| cidr\_block\_c | cidr block for Private subnet 1b | `string` | `"15.0.2.0/24"` | no |
| cidr\_block\_d | cidr block for Private subnet 1b | `string` | `"15.0.3.0/24"` | no |
| default\_route\_table\_association | Whether resource attachments are automatically associated with the default association route table | `string` | `"disable"` | no |
| default\_route\_table\_propagation | Whether resource attachments automatically propagate routes to the default propagation route table | `string` | `"disable"` | no |
| description | Description of the EC2 Transit Gateway | `string` | `"desc"` | no |
| destination\_cidr\_block | IPv4 CIDR range used for destination matches. Routing decisions are based on the most specific match | `string` | `" "` | no |
| dns\_support | Whether DNS support is enabled for Transit gateway | `string` | `"enable"` | no |
| egress\_cidr | n/a | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| exit\_rte\_cidr | destination cidr block for transit gateway route table | `string` | `"0.0.0.0/0"` | no |
| from\_port | security group from port | `string` | `"3389"` | no |
| ipv6\_support | Whether IPv6 support is enabled | `string` | `"disable"` | no |
| keyp | keypair filename | `string` | `"Ayos-windows-key"` | no |
| my\_ip | whitelist my ip for bastion access | `string` | `"142.118.174.17/32"` | no |
| protocol | security group protocol | `string` | `"tcp"` | no |
| pub\_subnet\_cidrs | public subnet cidrs | `list(string)` | <pre>[<br>  "15.0.0.0/24",<br>  "15.0.1.0/24"<br>]</pre> | no |
| pub\_subnets | Public subnets | `list(string)` | <pre>[<br>  "pub-1a",<br>  "pub-1b"<br>]</pre> | no |
| tgw\_id | id of the transit gateway | `string` | `"tgw_id"` | no |
| tgw\_name | Name of the transit gateway | `string` | `"transit-gw"` | no |
| to\_port | security group to port | `string` | `"3389"` | no |
| transit\_gateway\_attachment\_id | Identifier of EC2 Transit Gateway Attachment | `string` | `"tgw_attachment_id"` | no |
| transit\_gateway\_default\_route\_table\_association | whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table | `bool` | `false` | no |
| transit\_gateway\_default\_route\_table\_propagation | whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table | `bool` | `false` | no |
| transit\_gateway\_route\_table\_id | Identifier of EC2 Transit Gateway Route Table | `string` | `"tgw_routetable_id"` | no |
| vpc\_cidr\_block | cidr block for VPC | `string` | `"15.0.0.0/16"` | no |
| vpn\_ecmp\_support | Whether VPN Equal Cost Multipath Protocol support is enabled | `string` | `"enable"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance | ec2 instance id |
| instance\_ip | ec2 instance ip |
| private\_subnet1\_id | n/a |
| private\_subnet2\_id | n/a |
| public\_subnets | n/a |
| tgw\_arn | The arn of the TGW |
| tgw\_attachment | VPC attachments to TGW |
| tgw\_id | The ID of the VPC |
| tgw\_routetable\_association | transit gateway routetable association |
| tgw\_routetable\_id | Transit Gateway Route Table ID |
| vpc\_id | The ID of the VPC |