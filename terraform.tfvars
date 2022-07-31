# Shared variables for creating pipeline

# s3 bucket vars
s3_artifacts_bucket_name = ""

# Needed if docker image is in a private repo (registry)
# secets_arn = ""

# Codestar connection arn
github_codestar_connection_arn = ""

# iam vars
code_pipeline_role_name = ""
code_pipeline_policy_name = ""
code_build_role_name = ""
code_build_policy_name = ""

# Codebuild vars
dockerhub_terraform_image = "hashicorp/terraform:latest"
terraform_plan_codebuild_project_name = ""
terraform_plan_log_group_name = ""
terraform_apply_codebuild_project_name = ""
terraform_apply_log_group_name = ""

# Codepipeline vars
codepipline_name = ""
repository_id = ""  # Ex: <username>/<repo_name>
Branchname = ""  # Ex: main, master