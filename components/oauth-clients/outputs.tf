output "id" {
  value = "${lookup(shell_script.vcs.output,"id")}"
}
