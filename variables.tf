#My Variables
variable "perfix" {
  type        = string
  default     = "digialpha"
  description = "My perfix name for resource"
}

variable "project" {
  type        = string
  default     = "gtw-app"
  description = "My project name & tag"
}

variable "region" {
  default = "us-east-1"
}

variable "cloudflayr_token" {
  type        = string
  default     = "CRO1FCTLQl4wBDOvYJkmwro6a_ZyUN6pYkUc5N0h"
  description = "Cloudflayr API token"
}

variable "domain" {
  type        = string
  default     = "cryptopia.site"
  description = "Frontend website domain"
}

variable "sub_domain" {
  type        = string
  default     = "gtw"
  description = "Sub Domain"
}