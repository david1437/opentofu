terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 5.0.0"
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::test",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "",
        "home/",
        "home/&{aws:username}/",
      ]
    }
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::test/home/&{aws:username}",
      "arn:aws:s3:::test/home/&{aws:username}/*",
    ]
  }
}