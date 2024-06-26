variable "identifier" {
  description = "Unique identifier to differentiate global resources."
  type        = string
  validation {
    condition     = length(var.identifier) > 2
    error_message = "Identifier must be at least 3 characters"
  }
}

variable "hash_key" {
  description = "Partition or hash key of the table."
  type = object({
    name = string
    type = string
  })
}

variable "sort_key" {
  description = "Sort or range key of the table."
  type = object({
    name = string
    type = string
  })
  default = null
}

variable "provisioned" {
  description = "Objetct to define read and write capacity for a provisioned table. If not defined an on demand table will be created."
  type = object({
    read_capacity  = number
    write_capacity = number
  })
  default = null
}

variable "gsi_keys" {
  description = "Global secondary index keys of the table."
  type = list(object({
    name = optional(string, null)
    hash_key = object({
      name = string
      type = string
    })
    sort_key = optional(object({
      name = string
      type = string
    }), null)
    projection_type    = optional(string, "ALL")
    non_key_attributes = optional(list(string), null)
    read_capacity      = optional(number, null)
    write_capacity     = optional(number, null)
  }))
  default = []
}

variable "stream_view" {
  description = "View type of streams from the DynamoDB table. Valid values are: 'KEYS_ONLY', 'NEW_IMAGE', 'OLD_IMAGE', 'NEW_AND_OLD_IMAGES' and null. If null streams will be disabled."
  type        = string
  default     = null
  validation {
    condition = var.stream_view == null || var.stream_view == "KEYS_ONLY" || (
      var.stream_view == "NEW_IMAGE") || var.stream_view == "OLD_IMAGE" || (
    var.stream_view == "NEW_AND_OLD_IMAGES")
    error_message = "Stream view must be 'KEYS_ONLY', 'NEW_IMAGE', 'OLD_IMAGE', 'NEW_AND_OLD_IMAGES' or null"
  }
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
