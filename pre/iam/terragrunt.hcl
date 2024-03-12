include {
  path = find_in_parent_folders()
}
locals {
  env_vars    = read_terragrunt_config(find_in_parent_folders("env-vars.hcl"))
  git_version = local.env_vars.locals.git_version
  git_repo    = local.env_vars.locals.git_repo
}
terraform {
  source = "git::ssh://git@${local.git_repo}//gcp/iam?ref=${local.git_version}"
}
inputs = {
  project_id = local.env_vars.locals.project_id
}