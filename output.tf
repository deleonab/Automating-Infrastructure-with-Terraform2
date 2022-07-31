# I addedd the following outputs to output.tf to print them on screen

output "alb_dns_name" {
  value = aws_lb.ext-alb.dns_name
}

output "lb_target_group_arn" {
  value = aws_lb_target_group.nginx-tgt.arn
}