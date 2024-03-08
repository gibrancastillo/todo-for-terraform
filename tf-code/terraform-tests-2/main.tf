terraform {
  required_providers {
    todo = {
      source  = "spkane/todo"
      version = "2.0.5"
    }
    github = {
      source = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "todo" {
  host = "todo-api.techlabs.sh"
  port = "8080"
  apipath = "/"
  schema = "http"
}

provider "github" {
token = var.github_token
}


locals {
  class = "O'Reilly"
  remaining_todos = [for t in todo_todo.step_2 : t.description if t.completed == false]
}
resource "todo_todo" "remaining" {
  description = "${local.class} has asked us to complete these! (${join(",", local.remaining_todos)})"
  completed = false
}


/*resource "todo_todo" "step_2" {
  count = 5
  description = "${count.index}: ${var.purpose} todo"
  completed = false
}*/
resource "todo_todo" "step_2" {
  for_each = {
    for repo in tolist(module.simple_github_repo[*]):
    repo.github_repository.name => ({
      url = repo.github_repository.html_url
    })
  }

  description = "${each.value.url}: ${var.purpose} todo"
  completed = false
}



resource "todo_todo" "create_first" {
  description = "An important todo."
  completed = false
}
resource "todo_todo" "create_second" {
  description = "Forced dependency"
  completed = true
  # completed = false
  depends_on =[ todo_todo.create_first ]
}
/*resource "todo_todo" "create_third" {
  description = "Automatic dependency"
  completed = todo_todo.create_second.completed
}*/

resource "todo_todo" "create_third" {
  description = "Automatic dependency"
  completed = todo_todo.create_second.completed
  lifecycle {
    ignore_changes = [
      completed,
    ]
  }
}



module "simple_github_repo" {
  source = "github.com/spkane/terraform-github-repository?ref=8b72dcbac2c4287672a22435e36bbc27a869db5c"

  count = var.repo_count
  # count = var.create_repo ? 1 : 0

  # name = "testing-terraform-modules"
  name = "testing-terraform-modules-${count.index}"

  # description = "Testing GitHub repo automation via Terraform. This repo should probably be deleted."
  description = "Testing GitHub repo automation via Terraform. This repo should probably be deleted. Repo #${count.index + 1} out of ${var.repo_count}"
  visibility = "private"
  auto_init = true
  default_branch = "main"
  has_issues = "false"
}

# moved {
#   from = module.simple_github_repo
#   to = module.simple_github_repo[0]
# }