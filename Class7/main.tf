# Read all available AZ in ohio
data "aws_availability_zones" "all" {}

# Print out 
output "AZ" {
	value = data.aws_availability_zones.all.names
}

resource "aws_default_subnet" "default_az1" {
	availability_zone = data.aws_availability_zones.all.names[0]
	tags = {
		Name = "Subnet1"
	}
}
resource "aws_default_subnet" "default_az2" {
	availability_zone = data.aws_availability_zones.all.names[1]
	tags = {
		Name = "Subnet2"
	}
}
resource "aws_default_subnet" "default_az3" {
	availability_zone = data.aws_availability_zones.all.names[2]
	tags = {
		Name = "Subnet3"
	}
}

resource "aws_db_subnet_group" "default" {
  name       = "class7"
  subnet_ids = [
    aws_default_subnet.default_az1.id,
    aws_default_subnet.default_az2.id,
    aws_default_subnet.default_az3.id
  ]

  tags = {
    Name = "My DB subnet group"
  }
}