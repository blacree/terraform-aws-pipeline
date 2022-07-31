# Vars
variable "github_codestar_connection_arn" {}
variable "codepipline_name" {}
variable "repository_id" {}
variable "Branchname" {}


resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipline_name
  role_arn = aws_iam_role.crc_codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.artifacts_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Repo-connection"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.github_codestar_connection_arn
        FullRepositoryId = var.repository_id
        BranchName       = var.Branchname
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Terraform-Plan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["terraform_plan_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.terraform-plan.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Terraform-Apply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
          ProjectName = aws_codebuild_project.terraform-apply.name
      }
    }
  }
}