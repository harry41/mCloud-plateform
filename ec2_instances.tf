resource "aws_instance" "nat" {
  ami                         = "${lookup(var.nat_amis, var.aws_region)}"
  key_name                    = "${aws_key_pair.bastion_key.id}"
  instance_type               = "${var.bastian_instance_type}"
  security_groups             = ["${aws_security_group.bastion-sg.id}"]
  subnet_id                   = "${aws_subnet.public.id}"
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = "ping 8.8.8.8"

  # vpc_security_group_ids      = ["${aws_security_group.default.id}"]
  root_block_device = {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }

  tags {
    Name        = "${var.project}_nat_${count.index}"
    Environment = "${var.project}"
  }
}

resource "aws_instance" "web" {
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = false
  user_data                   = "sudo apt-get install python-minimal -y"
  ami                         = "${lookup(var.aws_amis, var.aws_region)}"
  key_name                    = "${aws_key_pair.auth.id}"
  vpc_security_group_ids      = ["${aws_security_group.default.id}"]
  subnet_id                   = "${aws_subnet.private.id}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }

  tags {
    Name        = "${var.project}_Server_${count.index}"
    Environment = "${var.project}"
  }
}
