variable "identifier" {
  description = "Unique identifier to differentiate global resources."
  type        = string
  validation {
    condition     = length(var.identifier) > 2
    error_message = "Identifier must be at least 3 characters"
  }
}

variable "partition_key" {
  description = "Partition key of the table."
  type = object({
    name = string
    type = string
  })
}

variable "sort_key" {
  description = "Sort key of the table."
  type = object({
    name = string
    type = string
  })
}

variable "attributes" {
  description = "List of attributes of the table."
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
