variable "instance_name" {
  description = "EC2 Instance Name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC that EC2 should be connected to"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate"
  type        = list(string)
}

variable "namespace" {
  description = "Environment namespace."
  type        = string
  default     = ""

  validation {
    condition     = contains(["development", "acceptance", "production", ""], var.namespace)
    error_message = "Allowed values for namespace are development, acceptance, or production."
  }
}
