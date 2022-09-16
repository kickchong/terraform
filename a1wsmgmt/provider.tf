terraform {

required_version = ">= 0.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.10.0"
    }
  }
}

# variable "repo_branch" {
#   type = string
# }

provider "aws" {
   region = var.a1_aws_region
   default_tags {
    tags = {
      Managedby               = "Albert Chong"  
 #     Repo-Branch             = var.repo_branch
      TerraformWorkspace      = terraform.workspace
    }
  }
}
provider "aws" {
  region     = "us-west-1"
  alias      = "west-1"
}
provider "aws" {
  region     = "us-west-2"
  alias      = "west-2"
}
provider "aws" {
  region     = "us-east-1"
  alias      = "east-1"
}
provider "aws" {
  region     = "us-east-2"
  alias      = "east-2"
}