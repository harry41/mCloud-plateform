resource "aws_key_pair" "auth" {
  key_name = "${var.project}_deploy_key"

  #key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_file)}"
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "${var.project}_bastian_key"
  public_key = "${file(var.bastian_public_key_file)}"
}
