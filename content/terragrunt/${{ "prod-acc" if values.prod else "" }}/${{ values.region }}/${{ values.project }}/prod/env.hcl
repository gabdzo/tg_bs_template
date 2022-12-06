locals {
  env = "prod"
  full_env = "Production"
  aws_role = ${{ values.aws_role | dump }}
}