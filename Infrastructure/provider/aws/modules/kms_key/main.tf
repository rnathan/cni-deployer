data aws_iam_policy_document default {
  source_json = var.source_json_policy
  statement {
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
    actions = [
      "kms:*"
    ]
    resources = [
      "*"
    ]
    condition {
      test = "StringLike"
      variable = "aws:PrincipalArn"
      values = var.admin_principals
    }
  }
  version = "2012-10-17"
}

resource aws_kms_key default {
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.default.json
  tags                = var.tags
}

resource aws_kms_alias default {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.default.id

  count         = var.enable_alias ? 1 : 0
}
