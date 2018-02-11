resource "aws_iam_role" "external_dns_pod_role" {
  name = "external_dns_pod_role"
  assume_role_policy = "${file("pod-role-trust-policy.json")}"
}

resource "aws_iam_role_policy" "external_dns_pod_role_policy" {
  name = "external_dns_pod_role_policy"
  role = "${aws_iam_role.external_dns_pod_role.id}"
  policy ="${file("external-dns-role-rights.json")}"
}