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