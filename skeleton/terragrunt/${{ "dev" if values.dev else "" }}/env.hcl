locals {
  env = "dev"
  full_env = "Development"
  aws_role = ${{ values.aws_role | dump }}

  # Account
  account_name = "${basename(get_terragrunt_dir())}-acc"
  aws_profile = "default"
  aws_account_id = "12312"

  # Project
  project = ${{ values.name | dump }}

  # Region
  aws_region = ${{ values.region | dump}}
}