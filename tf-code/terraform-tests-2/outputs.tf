/*output "todo_ids" {
  value = todo_todo.step_2.*.id
}*/

output "todo_ids" {
  value = {
    for k, v in todo_todo.step_2 : k => v.id
  }
}

output "remaining_todo_details" {
  value = todo_todo.remaining
}

output "repo_url" {
  # value = module.simple_github_repo.github_repository.html_url
  # value = module.simple_github_repo[0].github_repository.html_url
  value = module.simple_github_repo[*].github_repository.html_url
}