################################
# Table                        #
################################

locals {
  key_attributes      = var.sort_key != null ? [var.hash_key, var.sort_key] : [var.hash_key]
  gsi_hash_attributes = [for v in var.gsi_keys : v["hash_key"]]
  gsi_sort_attributes = [for v in var.gsi_keys : try(v["sort_key"], null) if try(v["sort_key"], null) != null]
  attributes          = toset(concat(local.key_attributes, local.gsi_hash_attributes, local.gsi_sort_attributes))
}

resource "aws_dynamodb_table" "main" {
  billing_mode   = var.provisioned != null ? "PROVISIONED" : "PAY_PER_REQUEST"
  hash_key       = var.hash_key["name"]
  range_key      = try(var.sort_key["name"], null)
  name           = var.identifier
  read_capacity  = try(var.provisioned["read_capacity"], null)
  write_capacity = try(var.provisioned["write_capacity"], null)

  dynamic "attribute" {
    for_each = local.attributes
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.gsi_keys
    content {
      name               = global_secondary_index.value["name"] != null ? global_secondary_index.value["name"] : global_secondary_index.value["hash_key"]["name"]
      hash_key           = global_secondary_index.value["hash_key"]["name"]
      range_key          = try(global_secondary_index.value["sort_key"]["name"], null)
      projection_type    = try(global_secondary_index.value["projection_type"], null)
      non_key_attributes = try(global_secondary_index.value["non_key_attributes"], null)
      read_capacity      = try(global_secondary_index.value["read_capacity"], null)
      write_capacity     = try(global_secondary_index.value["write_capacity"], null)
    }
  }

  tags = var.tags
}
