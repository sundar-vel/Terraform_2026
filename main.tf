# main module file
module "sg" {
    source = "/module/security_group"

# input
  security_group_name = var.security_group_name
  env = var.env
  ports = var.port
  cidr_ingress = var.cidr_ingress
  cidr_egress  = var.cidr_egress
}