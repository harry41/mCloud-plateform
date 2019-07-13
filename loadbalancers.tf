# resource "aws_elb" "web" {
#   name = "${var.project}-web-elb"
#
#   subnets         = ["${aws_subnet.private.id}", "${aws_subnet.public.id}"]
#   security_groups = ["${aws_security_group.elb.id}"]
#   instances       = ["${aws_instance.web.id}"]
#
#   listener {
#     instance_port     = 80
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }
# }

