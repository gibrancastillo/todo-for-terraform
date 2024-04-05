output "todo_1_ids" {
  value = todo_todo.test1.*.id
}

output "todo_2_ids" {
  value = todo_todo.test2.*.id
}

output "first_series_ids" {
  value = module.series-data.first_series_ids
}
output "second_series_ids" {
  value = module.series-data.second_series_ids
}