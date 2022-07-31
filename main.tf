terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.23.0"
        }
    }
}

provider "aws"{
    region = "us-east-1"
    profile = "default"
}

# Note: Make sure the backend of the terraform project in the github repo to be used in the pipeline is configured to use an aws s3 bucket to store your state file
# Example:
# terraform{
#     backend "s3" {
#       bucket = "<bucket_name>"
#       encrypt = true
#       key = "terraform.tfstate"
#       region = "<region-where-bucket-is-located>"
#     }    
# }
# Tip: Enable versioning for that bucket so as to store previous terraform states