# Jenkins
resource "aws_instance" "jenkins" {
  instance_type = "m4.large"
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${aws_key_pair.auth.id}"
  subnet_id = "${aws_subnet.public.id}"
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
  associate_public_ip_address = true

  tags {
    Name = "csd-tools-jenkins"
  }
}
