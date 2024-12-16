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
  sensitive   = true
}

provider "github" {
  token = var.github_token
}

resource "github_repository" "readme" {
  name       = "ipsavitsky"
  visibility = "public"
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

resource "github_repository" "wiki_search" {
  name       = "wiki_search"
  has_issues = true
}

resource "github_repository" "greedy_scheduling" {
  name       = "greedy-scheduling"
  has_issues = true
}

resource "github_repository" "cmc_mdo" {
  name = "cmc-mdo"
}

resource "github_repository" "cmc_numerical_methods" {
  name = "cmc-numerical-methods"
}

resource "github_repository" "cmc_ml_course" {
  name = "cmc-ml-course"
}

resource "github_repository" "opaste" {
  name = "opaste"
}

resource "github_repository" "linux_development" {
  name = "linux_development"
}

resource "github_repository" "gl-watcher" {
  name       = "gl-watcher"
  visibility = "private"
}

resource "github_repository" "script_pile" {
  name        = "script_pile"
  description = "Random pile of scripts"
}

moved {
  from = github_repository.gitlab_gopher
  to   = github_repository.suslik
}

resource "github_repository" "suslik" {
  name        = "suslik"
  description = "Automatically assign reviewers to your project"
  visibility  = "private"
}

resource "github_repository" "gitlab_due_dates" {
  name = "gitlab_due_dates"
  description = "Monitor your due dates and automatically postpone them"
  visibility = "private"
}
