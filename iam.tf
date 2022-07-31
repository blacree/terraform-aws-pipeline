# Codepipeline and Codebuild Iam role and policy
# VARS
variable "code_pipeline_policy_name" {}
variable "code_pipeline_role_name" {}
variable "code_build_role_name" {}
variable "code_build_policy_name" {}


# Codepipeline role
resource "aws_iam_role" "crc_codepipeline_role"{
    name = var.code_pipeline_role_name

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      },
    ]
  })

  tags = {
      Description = "Codepipeline iam role for cloud resume challenge"
  }
}

# Codepipeline policy
resource "aws_iam_policy" "codepipeline_policy" {
    name = var.code_pipeline_policy_name
    path = "/"
    description = "Codepipeline iam policy for cloud resume challenge"

    policy = jsonencode({
    Version = "2012-10-17"

    # main permissions for terraform pipeline
    Statement = [
      {
        Action = [
          "s3:*",
          "codestar-connections:*",
          "codebuild:*",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
    
    # Add more statements if needed for your project
    # Statement = [
    #   {
    #     Action = [
    #       "codedeploy:*", "lambda:InvokeFunction"
    #     ]
    #     Effect   = "Allow"
    #     Resource = "*"
    #   },
    # ]

  })
}

# Attach codepipeline policy to codepipeline role
resource "aws_iam_role_policy_attachment" "attach_codepipeline_policy" {
    role = aws_iam_role.crc_codepipeline_role.name
    policy_arn = aws_iam_policy.codepipeline_policy.arn
}


# Codebuild role
resource "aws_iam_role" "crc_codebuild_role"{
    name = var.code_build_role_name

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      },
    ]
  })

  tags = {
      Description = "Codbuild iam role for cloud resume challenge"
  }
}

# Codebuild iam policy
resource "aws_iam_policy" "codebuild_policy" {
    name = var.code_build_policy_name
    path = "/"
    description = "Codebuild iam policy for cloud resume challenge"

    policy = jsonencode({
    Version = "2012-10-17"

    # Add permissions for resources used in your terraform project
    Statement = [
      {
        Action = [
          "apigateway:*",
          "cloudfront:*",
          "dynamodb:*",
          "lambda:*",
          # main permissions needed
          "s3:*",
          "iam:*",
          "codebuild:*",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Attach codebuild policy to codebuild role
resource "aws_iam_role_policy_attachment" "attach_codebuild_policy" {
    role = aws_iam_role.crc_codebuild_role.name
    policy_arn = aws_iam_policy.codebuild_policy.arn
}
