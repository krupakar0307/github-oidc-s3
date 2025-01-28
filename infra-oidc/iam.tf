
resource "aws_iam_policy" "s3_full_access" {
  name        = "S3FullAccessPolicy"
  description = "S3 Full Access Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_full_access_attachment" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = aws_iam_policy.s3_full_access.arn
}

resource "aws_iam_policy" "eks_inline_policy" {
  name        = "EKSInlinePolicy"
  description = "EKS Inline Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks-auth:*"
        ]
        Resource = "arn:aws:eks:ap-south-1:288761748973:cluster/eks-demo"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_auth_policy_attachment" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = aws_iam_policy.eks_inline_policy.arn
}
