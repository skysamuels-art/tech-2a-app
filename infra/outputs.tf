output "ecr_url"          { value = aws_ecr_repository.app.repository_url }
output "lb_role_arn"      { value = module.lb_controller_role.iam_role_arn }
output "autoscaler_role"  { value = module.autoscaler_role.iam_role_arn }
output "vpc_id"           { value = module.vpc.vpc_id }