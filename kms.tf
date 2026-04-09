##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

data "aws_caller_identity" "current" {}

locals {
  atlas_region = upper(replace(data.aws_region.current.id, "-", "_"))
}

data "aws_iam_policy_document" "kms_assume_role" {
  count = try(var.settings.encryption_at_rest.enabled, false) ? 1 : 0
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [module.project.cloud_provider_setup_aws_account_arn]
    }
    condition {
      test     = "StringEquals"
      values   = [module.project.cloud_provider_setup_aws_external_id]
      variable = "sts:ExternalId"
    }
  }
}

resource "aws_iam_role" "kms" {
  count              = try(var.settings.encryption_at_rest.enabled, false) ? 1 : 0
  name               = "mongodbatlas-${local.system_name}-kms"
  assume_role_policy = data.aws_iam_policy_document.kms_assume_role[count.index].json
  tags               = local.all_tags
}

data "aws_iam_policy_document" "kms_key_policy" {
  count = try(var.settings.encryption_at_rest.enabled, false) ? 1 : 0
  statement {
    sid    = "AllowAtlasToUseKMS"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:ReEncrypt*",
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = [module.project.cloud_provider_setup_aws_account_arn]
    }
  }
  statement {
    sid    = "RootUserAccess"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_iam_role_policy" "kms" {
  count = try(var.settings.encryption_at_rest.enabled, false) ? 1 : 0
  role  = aws_iam_role.kms[count.index].name
  name  = "kms_access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowAtlasToUseKMS"
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:GenerateDataKey",
          "kms:ReEncrypt*",
        ]
        Resource = aws_kms_key.kms[count.index].arn
      }
    ]
  })
}

resource "aws_kms_key" "kms" {
  count                   = try(var.settings.encryption_at_rest.enabled, false) ? 1 : 0
  description             = "KMS key for MongoDB Atlas - ${module.project.project_name}"
  deletion_window_in_days = try(var.settings.encryption_at_rest.deletion_window_in_days, 7)
  enable_key_rotation     = try(var.settings.encryption_at_rest.enable_key_rotation, true)
  rotation_period_in_days = try(var.settings.encryption_at_rest.rotation_period_in_days, 90)
  multi_region            = try(var.settings.encryption_at_rest.multi_region, false)
  policy                  = data.aws_iam_policy_document.kms_key_policy[count.index].json
  tags = merge(
    {
      Name = format("mongodbatlas-%s-kms", local.system_name)
    },
    local.all_tags
  )
}

resource "aws_kms_alias" "kms" {
  count         = try(var.settings.encryption_at_rest.enabled, false) ? 1 : 0
  name          = format("alias/mongodbatlas-%s-kms", local.system_name)
  target_key_id = aws_kms_key.kms[count.index].id
}
