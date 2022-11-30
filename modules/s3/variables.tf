variable "bucket_name" {
  description = "Bucket name"
  type        = string
}

variable "cloudfront_origin_access_identity_arn" {
  description = "Cloudfront OAI arn"
  type        = string
  default = ""
}

variable "namespace" {
  description = "Environment namespace."
  type        = string
  default     = "all"

  validation {
    condition     = contains(["development", "acceptance", "production", "all"], var.namespace)
    error_message = "Allowed values for namespace are development, acceptance, or production."
  }
}
