variable "load_balancers" {
  description = "A map of load balancer configurations."
  type        = map(object({
    internal        = bool
    type            = string
    port            = number
    protocol        = string
    target_groups   = list(object({
      target_group_name = string
      target_type       = string
      port              = number
      protocol          = string
    }))
  }))
}
variable "type_id" {
  description = "A map of type IDs for load balancers."
  type        = map(string)
}

variable "vpc_id" {
  description = "The ID of the VPC where the load balancers will be created."
  type        = string
}

variable "subnets_id" {
  description = "A list of subnet IDs where the load balancers will be placed."
  type        = list(string)
}

variable "security_groups" {
  description = "A list of security group IDs associated with the load balancers."
  type        = list(string)
}
