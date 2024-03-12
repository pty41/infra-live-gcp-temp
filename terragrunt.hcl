locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env-vars.hcl"))
  project  = local.env_vars.locals.project_id
  region   = "europe-west4"
}

remote_state {
  backend = "gcs"
  config = {
    project  = local.project
    location = local.region
    bucket   = "${local.project}-terraform-state"
    prefix   = "${path_relative_to_include()}"
  }
}