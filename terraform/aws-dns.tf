resource "aws_route53_zone" "tools" {
  name = "${var.r53_tools_zone_name}"
}

resource "aws_route53_record" "tools-ns" {
    zone_id = "${var.r53_main_zone_id}"
    name = "${var.r53_tools_zone_name}"
    type = "NS"
    ttl = "30"
    records = [
        "${aws_route53_zone.tools.name_servers.0}",
        "${aws_route53_zone.tools.name_servers.1}",
        "${aws_route53_zone.tools.name_servers.2}",
        "${aws_route53_zone.tools.name_servers.3}"
    ]
}

# Jenkins A record
resource "aws_route53_record" "jenkins-a" {
  zone_id = "${aws_route53_zone.tools.id}"
  name = "jenkins"
  type = "A"
  ttl = "30"
  records = [
    "${aws_instance.jenkins.public_ip}"
  ]
}
