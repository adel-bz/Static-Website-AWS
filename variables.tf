#My Variables
variable "perfix" {
  type        = string
  default     = "your_perfix_name"
  description = "My perfix name for resource"
}

variable "project" {
  type        = string
  default     = "your_project-name"
  description = "My project name & tag"
}

variable "region" {
  default = "us-east-1"
  description = "You can change it to whatever region you want"
}

variable "cloudflayr_token" {
  type        = string
  default     = "$your_cloudflayr_api_token"
  description = "Cloudflayr API token"
}

variable "domain" {
  type        = string
  default     = "$your_website_domain"
  description = "Frontend website domain"
}

variable "sub_domain" {
  type        = string # if you don't want to use sub_domain variable, comment this varible or delete it
  default     = "$your_sub_domain"
  description = "Sub Domain"
}