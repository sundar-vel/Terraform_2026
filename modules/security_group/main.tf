#Creating security group
resource "aws_security_group" "Security-group" {
  for_each = toset(var.env)
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  

  tags = {
    Name = each.key
  }
}

# ingress rules as resout=rces
resource "aws_vpc_security_group_ingress_rule" "Ingress_trafic-rule" {
  for_each =  toset(var.Ports)
  security_group_id = aws_security_group.Security-group.id
  cidr_ipv4         = var.CIDR-ingress
  from_port         = each.values
  ip_protocol       = each.key
  to_port           = each.value
}

resource "aws_vpc_security_group_egress_rule" "egress_traffic_rule" {
  security_group_id = aws_security_group.Security-group.id
  cidr_ipv4         = var.CIDR-egress
  ip_protocol       = "-1" # semantically equivalent to all ports
}

