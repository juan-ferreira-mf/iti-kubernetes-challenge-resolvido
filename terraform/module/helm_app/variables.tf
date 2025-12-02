variable "app_name" {
  type        = string
  description = "Name of the Helm release"
}

variable "namespace" {
  type        = string
  description = "Namespace where the application will be deployed"
}

variable "chart_path" {
  type        = string
  description = "Path to the Helm chart directory"
}

variable "values" {
  type        = list(string)
  description = "List of YAML values to pass to Helm"
  default     = []
}

variable "timeout" {
  type        = number
  description = "Timeout for Helm operations in seconds"
  default     = 600
}

variable "namespace_resource" {
  type        = any
  description = "Namespace resource that must exist before Helm release"
}

