provider "shell" {}

resource "shell_script" "vcs" {
  lifecycle_commands {
    create = "${file("${path.module}/scripts/create.sh")}"
    read   = "${file("${path.module}/scripts/read.sh")}"
    delete = "${file("${path.module}/scripts/delete.sh")}"
  }

  environment = {
    ORGANIZATION                 = "${var.organization}"
    GITHUB_TOKEN="${var.github_token}"
    TOKEN          = "${var.atlas_token}"
  }
}