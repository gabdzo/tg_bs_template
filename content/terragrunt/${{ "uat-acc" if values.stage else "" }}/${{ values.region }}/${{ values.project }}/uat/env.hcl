locals {
  env = "uat"
  full_env = "User Acceptance Testing"
  aws_role = ${{ values.aws_role | dump }}
}