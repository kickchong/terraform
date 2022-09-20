provider "aws" {
   region = "us-west-1"
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
  alias      = "us-west"
}
provider "aws" {
  region     = "us-west-2"
  alias      = "us-west-2"
}
provider "aws" {
  region     = "us-east-1"
  alias      = "us-east"
}
provider "aws" {
  region     = "us-east-2"
  alias      = "us-east-2"
}