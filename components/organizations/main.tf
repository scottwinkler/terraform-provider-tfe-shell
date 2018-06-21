provider "shell" {}

resource "shell_script" "organization" {
  lifecycle_commands {
    create = "${file("${path.module}/scripts/create.sh")}"
    read   = "${file("${path.module}/scripts/read.sh")}"
    delete = "${file("${path.module}/scripts/delete.sh")}"
  }

  environment = {
    NAME                 = "${var.name}"
    EMAIL                = "${var.email}"
    TOKEN          = "${var.atlas_token}"
  }
}
