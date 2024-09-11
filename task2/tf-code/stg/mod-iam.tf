module "iam_ec2" {
  source = "../../tf-modules/iam"

  role_name          = var.iam_role_name
  assume_role_policy = var.iam_assume_role_policy

  policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${module.s3_prive_bucket.bucket_arn}",
          "${module.s3_prive_bucket.bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = ["*"]
      }
    ]
  }

  tags = {
    name = var.iam_role_name
    env  = var.env
  }
}
