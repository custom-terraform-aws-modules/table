output "name" {
  description = "Name of the DynamoDB table."
  value       = try(aws_dynamodb_table.main.id, null)
}

output "arn" {
  description = "ARN of the DynamoDB table."
  value       = try(aws_dynamodb_table.main.arn, null)
}

output "stream_arn" {
  description = "ARN of the stream of the DynamoDB table."
  value       = try(aws_dynamodb_table.main.stream_arn, null)
}
