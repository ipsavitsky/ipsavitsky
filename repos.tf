terraform {
  backend "remote" {
    organization = "ipsavitsky234"
    workspaces {
      name = "gh-state"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.2.1"
    }
  }
}

variable "github_token" {
  description = "Token used to authenticate in github"
}

provider "github" {
  token = var.github_token
}

resource "github_repository" "doom_emacs_configs" {
  name = ".doom.d"
}
