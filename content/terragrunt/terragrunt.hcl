locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  deployment_vars = read_terragrunt_config(find_in_parent_folders("deployment.hcl"))

  account_name = local.account_vars.locals.account_name
  aws_account_id = local.account_vars.locals.aws_account_id
  aws_region = local.region_vars.locals.aws_region
  env = local.environment_vars.locals.env
  project = local.project_vars.locals.project
  aws_role = local.environment_vars.locals.aws_role
  deployment = local.deployment_vars.locals.deployment

}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  assume_role {
    role_arn = "${local.aws_role}"
  }
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "${local.deployment}-${local.aws_region}-${local.account_name}-terraform-state-s3"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = local.aws_region
    dynamodb_table = "${local.deployment}-${local.aws_region}-${local.account_name}-terraform-locks-dynamodb"
  }
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.project_vars.locals,
  local.environment_vars.locals,
)