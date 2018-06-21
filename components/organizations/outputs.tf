output "name" {
  depends_on = [
    "shell_script.organization",
  ]

  value = "${var.name}"
}
