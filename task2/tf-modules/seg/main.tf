resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.sg_name
    env  = var.env
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule" {
  for_each = var.ingress_rules

  security_group_id            = aws_security_group.sg.id
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
  ip_protocol                  = each.value.ip_protocol
  cidr_ipv4                    = each.value.cidr_ipv4 != "" ? each.value.cidr_ipv4 : null
  referenced_security_group_id = each.value.referenced_security_group_id != "" ? each.value.referenced_security_group_id : null
}

resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  for_each = var.egress_rules

  security_group_id = aws_security_group.sg.id
  from_port         = each.value.ip_protocol != "-1" ? each.value.from_port : null
  to_port           = each.value.ip_protocol != "-1" ? each.value.to_port : null
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
}
