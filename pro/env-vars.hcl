locals {
  project_id     = "test-pro-xxx" #The ID of GCP project
  env            = "test-pro"
  git_repo       = "github.com/pty41/infra-modules-temp.git"
  git_version    = get_env("GIT_VERSION", "v0.0-noversion")
  region         = "europe-west1"
}