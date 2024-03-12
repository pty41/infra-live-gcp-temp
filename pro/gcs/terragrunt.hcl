include {
  path = find_in_parent_folders()
}
terraform {
  source = "git::ssh://git@${local.git_repo}//gcp/gcs?ref=${local.git_version}"
}
dependency "iam_module" {
  config_path = "../iam"
  mock_outputs = {
    airflow_connection_sa     = "test_sa"
    master_feed_connection_sa = "test_sa"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}
locals {
  env_vars    = read_terragrunt_config(find_in_parent_folders("env-vars.hcl"))
  git_version = local.env_vars.locals.git_version
  git_repo    = local.env_vars.locals.git_repo
}

inputs = {
  project_id                      = local.env_vars.locals.project_id
  env                             = local.env_vars.locals.env
  region                          = local.env_vars.locals.region
  airflow_connection_sa_email     = dependency.iam_module.outputs.airflow_connection_sa
  master_feed_connection_sa_email = dependency.iam_module.outputs.master_feed_connection_sa
}