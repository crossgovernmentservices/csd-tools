# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
    Name = "csd-tools"
  }
}

# Public subnet
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/24"
  tags {
    Name = "csd-tools-public"
  }
}

# Private subnet
resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.2.0/24"
  tags {
    Name = "csd-tools-private"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "csd-tools"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# # NAT gateway elastic IP, AZ: A
# resource "aws_eip" "nat" {
#     vpc = true
# }

# # NAT gateway instance
# resource "aws_nat_gateway" "gw" {
#   allocation_id = "${aws_eip.nat.id}"
#   subnet_id = "${aws_subnet.public.id}"
#   depends_on = ["aws_internet_gateway.default"]
# }

# # NAT gateway route table
# resource "aws_route_table" "private-nat" {
#   vpc_id = "${aws_vpc.default.id}"
#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = "${aws_nat_gateway.gw.id}"
#   }

#   tags {
#     Name = "csd-tools-private-nat"
#   }
# }

# # NAT gateway route table association
# resource "aws_route_table_association" "private-nat" {
#   subnet_id = "${aws_subnet.private.id}"
#   route_table_id = "${aws_route_table.private-nat.id}"
# }
