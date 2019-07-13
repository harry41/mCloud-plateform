# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "${var.project}_InternetGateway"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# resource "aws_eip" "nat_eip" {
#   vpc        = true
#   depends_on = ["aws_internet_gateway.default"]
# }
#
# resource "aws_nat_gateway" "nat" {
#   subnet_id     = "${aws_subnet.public.id}"
#   allocation_id = "${aws_eip.nat_eip.id}"
#   depends_on    = ["aws_internet_gateway.default"]
# }

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Private route table"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = "${aws_route_table.private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = "${aws_instance.nat.id}"
  depends_on             = ["aws_instance.nat"]

  # nat_gateway_id         = "${aws_instance.nat.id}"
}

# Associate subnet public_subnet_eu_west_1a to public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_vpc.default.main_route_table_id}"
}

# Associate subnet private_1_subnet_eu_west_1a to private route table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
