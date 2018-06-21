output "id" {
  depends_on = ["shell_script.workspace"]
  value      = "${var.organization}/${var.name}"
}
