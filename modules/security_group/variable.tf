#Creating variable for security group name
variable "security_group_name" {
    description = "Name of the security group"
    type = string
}
#creating variable for pass port numbers
variable "Ports" {
  description = "List of port numbers to opend in the ingress"
  type = list(number)
  default = [22, 443, 80 ]
}
#creating ingress cidr level
variable "CIDR-ingress" {
    description = "ingress allowed level"
    type = string
    default = "0.0.0.0/0"

}
#creating egress cidr level
variable "CIDR-egress" {
    description = "egress allowed level"
    type = string
    default = "0.0.0.0/0"

}
