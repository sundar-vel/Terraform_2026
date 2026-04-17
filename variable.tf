#Creating variable for security group name
variable "security_group_name" {
    description = "Name of the security group"
    type = string
}

# Creating env names
variable "env" {
    description = "Assign environment to the Sg"
    type = list(string)
}
#creating variable for pass port numbers
variable "Ports" {
  description = "List of port numbers to opend in the ingress"
  type = map(number)
  /*default = {
    ssh = 22
    http = 80
    https = 443
  }*/
}
#creating ingress cidr level
variable "CIDR-ingress" {
    description = "ingress allowed level"
    type = string
    #default = "0.0.0.0/0"

}
#creating egress cidr level
variable "CIDR-egress" {
    description = "egress allowed level"
    type = string
   # default = "0.0.0.0/0"

}