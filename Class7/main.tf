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


# Create a sec group
resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow TLS inbound traffic"
  ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "wordpress"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]
  db_subnet_group_name  = aws_db_subnet_group.default.name
  publicly_accessible   = true
}


data "aws_route53_zone" "selected" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "db" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "wordpressdb.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [
    aws_db_instance.default.address
  ]
}
variable domain {}