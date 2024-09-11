# IAM Role for EC2
resource "aws_iam_role" "iam_role" {
  name = var.role_name
  assume_role_policy = jsonencode(var.assume_role_policy)

  tags = var.tags
}

resource "aws_iam_policy" "iam_policy" {
  name = "${var.role_name}-policy"
  policy = jsonencode(var.policy)
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

# IAM Instance Profile for EC2
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.role_name}-instance-profile"
  role = aws_iam_role.iam_role.name
}
