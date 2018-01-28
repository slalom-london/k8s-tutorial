resource "aws_iam_role" "ingress_pod_role" {
  name = "ingress_pod_role"
  assume_role_policy = "${file("pod-role-trust-policy.json")}"
}

resource "aws_iam_role_policy" "ingress_pod_role_policy" {
  name = "ingress_pod_role_policy"
  role = "${aws_iam_role.ingress_pod_role.id}"
  policy ="${file("ingress-role-rights.json")}"
}