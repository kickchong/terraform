# data "tfe_workspace_ids" "cloudengws_all" {
#   names         = ["*"]
#   organization  = "albertchong"
# }

# data "tfe_workspace" "cloudengws_all" {
#   for_each      = data.tfe_workspace_ids.cloudengws_all.ids
#   name          = each.key
#   organization = "albertchong"
# }

# resource "tfe_variable" "cloudeng_repobranch" {
#   for_each     = data.tfe_workspace_ids.cloudengws_all.ids
#   key          = "repo_branch"
#   value        = "${data.tfe_workspace.cloudengws_all[each.key].vcs_repo[0].identifier}:${data.tfe_workspace.cloudengws_all[each.key].vcs_repo[0].branch}"
#   #value        = data.tfe_workspace.cloudengws_all[each.key].vcs_repo[0].identifier
#   category     = "terraform"
#   workspace_id = each.value
#   sensitive    = false
#   description  = "Set the repo branch info"
# }
