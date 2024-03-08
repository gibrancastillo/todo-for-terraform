variable "purpose" {
    type = string
    description = "Tag the purpose of this todo"
    default = "testing-modules"
}

variable "github_token" {
    type = string
    description = "The token required to authenticate against GitHub"
}

variable "create_repo" {
    type = bool
    description = "Should we create the repo?"
    default = true
}

variable "repo_count" {
    type = number
    description = "The number of repos that we want."
    default = 1
    validation {
        condition = ( var.repo_count >= 0 && var.repo_count <= 3 )
        error_message = "Must be an integer between 0 and 3."
    }
}