# VARS
variable "dockerhub_terraform_image" {}
variable "terraform_plan_codebuild_project_name" {}
variable "terraform_plan_log_group_name" {}
variable "terraform_apply_codebuild_project_name" {}
variable "terraform_apply_log_group_name" {}
# variable "secrets_arn" {}


resource "aws_codebuild_project" "terraform-plan" {
  name          = var.terraform_plan_codebuild_project_name
  description   = "Perform terraform plan execution"
#   build_timeout = "20"
  service_role  = aws_iam_role.crc_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    # Modify compute_type if your project needs higher computer resources (other options: BUILD_GENERAL1_MEDIUM, BUILD_GENERAL1_LARGE, BUILD_GENERAL1_2XLARGE)
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.dockerhub_terraform_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"

    # environment_variable {
    #   name  = "SOME_KEY1"
    #   value = "SOME_VALUE1"
    # }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.terraform_plan_log_group_name
    #   stream_name = "log-stream"
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec = file("./codebuild_commands/terraform_plan.yml")
  }

  # Configure if docker image is in a private repo (registry)
#   registry_credential{
#       credential = var.secrets_arn
#       credential_provider = "SECRETS_MANAGER"
#   }
  
#   tags = {
#     Environment = "Test"
#   }
}



resource "aws_codebuild_project" "terraform-apply" {
  name          = var.terraform_apply_codebuild_project_name
  description   = "Perform terraform plan execution"
#   build_timeout = "20"
  service_role  = aws_iam_role.crc_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    # Modify compute_type if your project needs higher computer resources (other options: BUILD_GENERAL1_MEDIUM, BUILD_GENERAL1_LARGE, BUILD_GENERAL1_2XLARGE)
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.dockerhub_terraform_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"

    # environment_variable {
    #   name  = "SOME_KEY1"
    #   value = "SOME_VALUE1"
    # }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.terraform_apply_log_group_name
    #   stream_name = "log-stream"
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec = file("./codebuild_commands/terraform_apply.yml")
  }

  # Configure if docker image is in a private repo (registry)
#   registry_credential{
#       credential = var.secrets_arn
#       credential_provider = "SECRETS_MANAGER"
#   }
  
#   tags = {
#     Environment = "Test"
#   }
}