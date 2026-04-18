#creating ec2 instance
data "aws_ami" "amazon_linux" {
  most_recent      = true
  owners           = ["amozon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  vpc_security_group_ids = aws_security_group.Security-group.id

  for_each = toset(keys({
    for az, details in data.aws_ec2_instance_type_offerings.offerings: az => details.instance_types if length(details.instance_types) > 0
  }))
  availability_zone = each.value

  tags = {
    Name = "Instance-${each.value}"
  }
}