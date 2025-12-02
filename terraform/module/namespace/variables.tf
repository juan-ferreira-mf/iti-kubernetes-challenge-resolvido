variable "name" {
  type        = string
  description = "Name of the namespace"
}

variable "app_name" {
  type        = string
  description = "Name of the application (for labels)"
  default     = ""
}

variable "labels" {
  type        = map(string)
  description = "Additional labels for the namespace"
  default     = {}
}

