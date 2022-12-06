locals {
  env = "dev"
  full_env = "Development"
  aws_role = ${{ values.aws_role | dump }}
}