#data source for lista vailablity zones in the specific region
data "aws_availability_zones" "availability_zones" {
  state = "available"
  
}

# data source for fetching list of instance type offering zones
data "aws_ec2_instance_type_offerings" "offerings" {
  for_each = toset(data.aws_availability_zones.availability_zones.names)
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }

  filter {
    name   = "location"
    values = each.value
  }

  location_type = "availability-zone"
}




