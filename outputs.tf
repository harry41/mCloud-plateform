output "ELB_ENDPOINT" {
  value = "${aws_elb.web.dns_name}"
}

output "nat_public_ip" {
  value = "${aws_instance.nat.public_ip}"
}

output "app_private_ip" {
  value = "${aws_instance.web.private_ip}"
}
