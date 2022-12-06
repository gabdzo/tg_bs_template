locals {
  account_name = "${basename(get_terragrunt_dir())}"
  aws_profile = "default"
  aws_account_id = "12312"
}