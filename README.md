# IaC terragrunt framework
This repository holds the configuration for the GCP environment infrastructure using Terragrunt - a wrapper for Terraform which is used to help keep Terraform code DRY. 

We define two repositories, which provide the version control of the infra module and then standalone the module in order to be less influenced by the infra live. Then, what is the difference between live and module repositories?

  - infra-live-gcp-temp: The repository defines the customized configuration input for different environments.
  - infra-modules-temp: The repository defines the reusable modules.

GCP Environemnts: 
  - dev
  - pre
  - pro

### Terraform Updating
1. Implement the module in `infra-modules-temp` repository. Commit it to the remote with the tag
2. Implement the `infra-live-gcp-temp` which align with the `infra-modules-temp`. 
3. In the env-vars.hcl (under dev and pre folder), provide the correct git_version to fetch the version of `infra-modules-temp`
4. Do the `terragrunt run-all plan` under dev or pre folder locally, the commend line is to display the plans of a stck. it will recursively search the current working directory for any folders that contain Terragrunt modules and run plan in each one
5. After you fix all the error, then you can commit the code with PR.

### Multiple envs arrangement
We follow the Terragrunt official [documentation](https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d) to moduleize the Terraform, and then generate the IaC into two repos ([infra-live-gcp-temp](https://github.com/pty41/infra-live-gcp-temp) and [infra-module-temp](https://github.com/pty41/infra-modules-temp)). In the infra-live-gcp-temp repos, different env setting is implemented in a different folder, which are dev, pre, and pro, respectively. Under the folder, you can configure the git_version, project_id, and etc... in env-vars.hcl according to the different env.
* The git_version configurations are as follows:

  `dev`: it is pointed to the **dev** branch of the **infra-module-temp** repos
  
  `pre`: it is pointed to the **pre** branch of the **infra-module-temp** repos
  
  `pro`: it is pointed to the specific **tag** number of the **infra-module-temp** repos

ps: When someone commits the code to the dev or the pre branch in infra-module-temp repos of folder gcp, it will trigger the deployment process in infra-live-gcp-temp.

### CI/CD
In this repository, we use the GitHub Actions workflow to automate our deployment pipeline [here](https://github.com/pty41/infra-live-gcp-temp/.github/workflows/cicd.yaml).
 
