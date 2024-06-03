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

resource "github_repository" "spotistatsR" {
  name       = "spotistatsR"
  visibility = "private"
}

resource "github_repository" "resume" {
  name          = "resume"
  has_downloads = true
}

resource "github_repository" "simple_shell" {
  name       = "simple_shell"
  has_issues = true
}


resource "github_repository" "codewars_solutions" {
  name                 = "codewars-solutions"
  vulnerability_alerts = true
  allow_rebase_merge   = false
  allow_squash_merge   = false
}


resource "github_repository" "leetcode_solutions" {
  name = "leetcode-solutions"
}

resource "github_repository" "cryptobotAPI" {
  name                 = "cryptobotAPI"
  has_issues           = true
  vulnerability_alerts = true
}

resource "github_repository" "multiprocessor_scheduling_text" {
  name = "multiprocessor-scheduling-text"
}
