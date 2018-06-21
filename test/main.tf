module "organization-platform-engineering" {
  source      = "../components/organizations"
  name        = "PlatformEngineering"
  email       = "Scott.Winkler@elliemae.io"
  atlas_token = "${var.atlas_token}"
}

module "vcs-test" {
  source       = "../components/oauth-clients"
  organization = "${module.organization-platform-engineering.name}"
  atlas_token  = "${var.atlas_token}"
  github_token = "${var.github_token}"
}

module "team-test" {
  source       = "../components/teams"
  organization = "${module.organization-platform-engineering.name}"
  name         = "brownie-brittle"
  atlas_token  = "${var.atlas_token}"
}

module "workspace-test" {
  source              = "../components/workspaces"
  depends_on          = ["${module.vcs-test.id}"]
  name                = "example"
  organization        = "${module.organization-platform-engineering.name}"
  auto_apply          = false
  terraform_version   = "0.11.7"
  working_directory   = "."
  vcs_repo_branch     = "master"
  ingress_submodules  = false
  vcs_repo_identifier = "CloudPlatform/terraform-tfe-config"
  atlas_token         = "${var.atlas_token}"
}

module "variables-test" {
  source = "../components/variables"

  workspaces = [
    "${module.workspace-test.id}",
  ]

  environment_vars = {
    test1 = "something"
  }

  sensitive_environment_vars = {
    test2 = "somethingelse"
  }

  vars = {
    test3 = "somethingelse3"
  }

  sensitive_vars = {
    test4 = "somethingelse4"
  }

  atlas_token = "${var.atlas_token}"
}