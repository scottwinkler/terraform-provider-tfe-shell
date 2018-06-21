provider "shell" {}

resource "shell_script" "team" {
  lifecycle_commands {
    create = "${file("${path.module}/scripts/create.sh")}"
    read   = "${file("${path.module}/scripts/read.sh")}"
    delete = "${file("${path.module}/scripts/delete.sh")}"
  }

  environment = {
    ORGANIZATION                 = "${var.organization}"
    NAME= "${var.name}"
    TOKEN          = "${var.atlas_token}"
  }
}
