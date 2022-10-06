provider "aws" {
   region = "us-west-2"
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
  alias      = "us-west-1"
}
provider "aws" {
  region     = "us-west-2"
  alias      = "us-west"
  default_tags {
    tags = {
      Managedby               = "Albert Chong"  
 #     Repo-Branch             = var.repo_branch
      TerraformWorkspace      = terraform.workspace
    }
  }
}
provider "aws" {
  region     = "us-east-1"
  alias      = "us-east"
  default_tags {
    tags = {
      Managedby               = "Albert Chong"  
 #     Repo-Branch             = var.repo_branch
      TerraformWorkspace      = terraform.workspace
    }
  }
}
provider "aws" {
  region     = "us-east-2"
  alias      = "us-east-2"
}