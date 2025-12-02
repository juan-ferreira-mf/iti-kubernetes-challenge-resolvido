variable "release_name" {
  type        = string
  description = "Name of the Helm release"
  default     = "tempo"
}

variable "namespace" {
  type        = string
  description = "Namespace where Tempo will be deployed"
  default     = "monitoring"
}

variable "chart_version" {
  type        = string
  description = "Version of the tempo chart"
  default     = "1.8.0"
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

