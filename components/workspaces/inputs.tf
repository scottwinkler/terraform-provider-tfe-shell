variable "name" {
  type = "string"
}

variable "organization" {
  type = "string"
}

variable "auto_apply" {
  type    = "string"
  default = false
}

variable "terraform_version" {
  type = "string"
}

variable "working_directory" {
  type    = "string"
  default = "."
}

variable "vcs_repo_branch" {
  type    = "string"
  default = "master"
}

variable "ingress_submodules" {
  type    = "string"
  default = false
}

variable "vcs_repo_identifier" {
  type = "string"
}

variable "atlas_token" {
  type = "string"
}

variable depends_on { default = [], type = "list"}