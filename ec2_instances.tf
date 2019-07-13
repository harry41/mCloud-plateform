# resource "aws_instance" "bastion" {
#   ami           = "${lookup(var.aws_amis, var.aws_region)}"
#   key_name      = "${aws_key_pair.bastion_key.id}"
#   instance_type = "${var.bastian_instance_type}"
#
#   security_groups             = ["${aws_security_group.bastion-sg.id}"]
#   subnet_id                   = "${aws_subnet.public.id}"
#   associate_public_ip_address = true
#   user_data                   = "ping 8.8.8.8"
#
#   root_block_device = {
#     volume_type           = "gp2"
#     volume_size           = "8"
#     delete_on_termination = true
#   }
#
#   tags {
#     Name = "${var.project}_bastian_${count.index}"
#
#     #Owner       = "${var.owner}"
#     Environment = "${var.project}"
#   }
# }

resource "aws_instance" "nat" {
  ami           = "${lookup(var.nat_amis, var.aws_region)}"
  key_name      = "${aws_key_pair.bastion_key.id}"
  instance_type = "${var.bastian_instance_type}"

  security_groups = ["${aws_security_group.bastion-sg.id}"]

  # vpc_security_group_ids      = ["${aws_security_group.default.id}"]
  subnet_id                   = "${aws_subnet.public.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  # user_data                   = "ping 8.8.8.8"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }
  tags {
    Name = "${var.project}_nat_${count.index}"

    #Owner       = "${var.owner}"
    Environment = "${var.project}"
  }
}

# resource "aws_instance" "web" {
#   # The connection block tells our provisioner how to  # communicate with the resource (instance)  # connection {  #   # The default username for our AMI  #   user        = "ubuntu"  #   private_key = "${file("${var.private_key}")}"  #  #   # The connection will use the local SSH agent for authentication.  # }
#
#   instance_type = "${var.instance_type}"
#
#   associate_public_ip_address = false
#
#   #availability_zone = "${var.aws_region}c"
#   #source_dest_check           = false
#   user_data = "ping 8.8.8.8"
#
#   root_block_device = {
#     volume_type           = "gp2"
#     volume_size           = "8"
#     delete_on_termination = true
#   }
#
#   # Lookup the correct AMI based on the region
#   # we specified
#   ami = "${lookup(var.aws_amis, var.aws_region)}"
#
#   # The name of our SSH keypair we created above.
#   key_name = "${aws_key_pair.auth.id}"
#
#   # Our Security group to allow HTTP and SSH access
#   vpc_security_group_ids = ["${aws_security_group.default.id}"]
#
#   # We're going to launch into the same subnet as our ELB. In a production
#   # environment it's more common to have a separate private subnet for
#   # backend instances.
#   subnet_id = "${aws_subnet.private.id}"
#
#   # We run a remote provisioner on the instance after creating it.
#   # In this case, we just install nginx and start it. By default,
#   # this should be on port 80
#   # provisioner "remote-exec" {
#   #   inline = [
#   #     "sudo apt-get -y update",
#   #     "sudo apt-get -y install nginx",
#   #     "sudo service nginx start",
#   #   ]
#   # }
#   tags {
#     Name = "${var.project}_Server_${count.index}"
#
#     #Owner       = "${var.owner}"
#     Environment = "${var.project}"
#   }
# }

