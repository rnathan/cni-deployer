resource "aws_iam_role" "flow_logs" {
  name = "${var.resource_prefix}-flow-logs"

  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/PCSKPermissionsBoundary"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "flow_logs_cloudwatch_write_access" {
  role       = aws_iam_role.flow_logs.name
  policy_arn = aws_iam_policy.cloudwatch_write_access.arn
}