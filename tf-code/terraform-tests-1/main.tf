terraform {
  required_providers {
    todo = {
      source  = "spkane/todo"
      version = "2.0.5"
    }
  }
}

provider "todo" {
  # host = "127.0.0.1"
  host = "todo-api.techlabs.sh"
  port = "8080"
  apipath = "/"
  schema = "http"
}

data "todo_todo" "foreign" {
  id = 8
}

resource "todo_todo" "test1" {
  count = 4
  description = "${count.index}-1 ${var.purpose} todo"
  completed = false
}

resource "todo_todo" "test2" {
  count = 4
  description = "${count.index}-2 ${var.purpose} todo (linked to ${data.todo_todo.foreign.description})"
  completed = false
}

resource "todo_todo" "primary" {
  description = "save the world"
  completed = false
}

module "series-data" {
  source = "../__modules/todo-test-data"
  number = 5
  purpose = "testing"
  team_name = "oreilly"
  descriptions = ["my first completed todo", "my second completed todo",
                  "my third completed todo", "my fourth completed todo",
                  "my fifth completed todo"
                 ]
}