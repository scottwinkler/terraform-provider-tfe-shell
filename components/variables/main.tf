provider "shell" {}

resource "shell_script" "variables" {
  lifecycle_commands {
    create = "bash ${path.module}/scripts/create.sh"
    read   = "${file("${path.module}/scripts/read.sh")}"
    delete = "${file("${path.module}/scripts/delete.sh")}"
  }

  environment = {
    VARS_KEYS                         = "${join(";", keys(var.vars))}"
    VARS_VALUES                       = "${join(";", values(var.vars))}"
    SENSITIVE_VARS_KEYS               = "${join(";", keys(var.sensitive_vars))}"
    SENSITIVE_VARS_VALUES             = "${join(";", values(var.sensitive_vars))}"
    ENVIRONMENT_VARS_KEYS             = "${join(";", keys(var.environment_vars))}"
    ENVIRONMENT_VARS_VALUES           = "${join(";", values(var.environment_vars))}"
    SENSITIVE_ENVIRONMENT_VARS_KEYS   = "${join(";", keys(var.sensitive_environment_vars))}"
    SENSITIVE_ENVIRONMENT_VARS_VALUES = "${join(";", values(var.sensitive_environment_vars))}"
    WORKSPACES                        = "${join(";",var.workspaces)}"
    TOKEN                             = "${var.atlas_token}"
  }
}
