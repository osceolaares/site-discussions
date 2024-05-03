variable "domain_name" {
  type        = string
  description = "The domain name to host site"
}

variable "host_name" {
  type        = string
  description = "The host name for the site"
  default     = null
}
