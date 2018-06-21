variable "workspaces" {
  type        = "list"
  description = "A list of workspaces in which to put credentials. Workspaces are fully qualified names of the form: organization/name"
  default     = []
}

variable "vars" {
  type        = "map"
  description = "A key value mapping of variables to update"
  default     = {}
}

variable "sensitive_vars" {
  type        = "map"
  description = "A key value mapping of sensitive variables to update"
  default     = {}
}

variable "environment_vars" {
  type        = "map"
  description = "A key value mapping of environment variables to update"
  default     = {}
}

variable "sensitive_environment_vars" {
  type        = "map"
  description = "A key value mapping of sensitive environment variables"
  default     = {}
}

variable "atlas_token" {
  type = "string"
}