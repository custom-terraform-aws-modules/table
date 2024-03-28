################################
# DynamoDB                     #
################################

resource "aws_dynamodb_table" "main" {
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = try(var.partition_key["name"], null)
  range_key    = try(var.sort_key["name"], null)
  name         = var.identifier

  attribute {
    name = try(var.partition_key["name"], null)
    type = try(var.partition_key["type"], null)
  }

  attribute {
    name = try(var.sort_key["name"], null)
    type = try(var.sort_key["type"], null)
  }

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = try(attribute.value["name"], null)
      type = try(attribute.value["type"], null)
    }
  }

  tags = var.tags
}
