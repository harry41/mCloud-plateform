# A security group for the ELB so it is accessible via the web
resource "aws_security_group" "elb" {
  name        = "${var.project}_elb_sg"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.default.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name = "${var.project}-common-sg"

  # description = "Used in the terraform"
  vpc_id = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["${aws_instance.nat.public_ip}/32"]
    security_groups = ["${aws_security_group.bastion-sg.id}"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastion-sg" {
  name   = "${var.project}-bastion-sg"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   protocol    = "tcp"
  #   from_port   = 22
  #   to_port     = 22
  #   cidr_blocks = "${var.ip_list}"
  #
  #   #cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.project}-rds-sg"
  description = "Basic Security Group for RDS Server"
  vpc_id      = "${aws_vpc.default.id}"

  #vpc_id = "${data.aws_subnet.default.vpc_id}"

  ingress {
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]

    # cidr_blocks     = "${var.private_subnet_cidr}"
    security_groups = ["${aws_security_group.bastion-sg.id}"]
    description     = "it will allow to connect db from anywhere inside vpc"
  }
  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound Traffic allowed"
  }
}
