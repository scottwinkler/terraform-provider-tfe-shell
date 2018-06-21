provider "shell" {}

locals {
  ingress_submodules = "${var.ingress_submodules == false ? "false" : "true"}"
  auto_apply         = "${var.auto_apply == false ? "false" : "true"}"
}

resource "shell_script" "workspace" {
  lifecycle_commands {
    create = "${file("${path.module}/scripts/create.sh")}"
    read   = "${file("${path.module}/scripts/read.sh")}"
    delete = "${file("${path.module}/scripts/delete.sh")}"
  }

  environment = {
    ORGANIZATION        = "${var.organization}"
    NAME                = "${var.name}"
    TOKEN               = "${var.atlas_token}"
    AUTO_APPLY          = "${local.auto_apply}"
    TERRAFORM_VERSION   = "${var.terraform_version}"
    WORKING_DIRECTORY   = "${var.working_directory}"
    VCS_REPO_BRANCH     = "${var.vcs_repo_branch}"
    INGRESS_SUBMODULES  = "${local.ingress_submodules}"
    VCS_REPO_IDENTIFIER = "${var.vcs_repo_identifier}"
  }
}
