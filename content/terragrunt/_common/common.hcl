locals {
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  deployment_vars = read_terragrunt_config(find_in_parent_folders("deployment.hcl"))
  stack_vars = read_terragrunt_config(find_in_parent_folders("stack.hcl"))

  module =  "${basename(get_terragrunt_dir())}"

  env = local.environment_vars.locals.env
  full_env = local.environment_vars.locals.full_env
  stack_prefix = local.stack_vars.locals.stack_prefix
  project = local.project_vars.locals.project
  deployment = local.deployment_vars.locals.deployment

  name = local.deployment != "shared" ? "${local.stack_prefix}-${local.deployment}-${local.module}" : "${local.stack_prefix}-${local.project}-${local.env}-${local.deployment}-${local.module}"
}

inputs = {
  name = local.name
  bucket = local.name

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}