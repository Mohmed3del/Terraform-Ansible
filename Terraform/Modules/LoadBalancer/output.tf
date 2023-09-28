output "load_balancers" {
  description = "List of load balancers created"
  value       = aws_lb.load_balancer
}